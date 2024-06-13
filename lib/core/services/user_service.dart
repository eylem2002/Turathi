import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import '../data_layer.dart';

// Service class To Manage Users in Database

class UserService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _collectionName = "users";

  // create new account
  Future<String> addUser(UserModel model, String password) async {
    bool mounted = false;
    try {
      // add user to FirebaseAuth
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: model.email!, password: password);
    } catch (e) {
      if (e is FirebaseAuthException) {
        log("Error occurred: $e");
        mounted = true;
        String errorMessage = "An error occurred during sign up.";

        if (e.code == 'email-already-in-use') {
          errorMessage = "The account already exists for that email.";
        }
        if (mounted) {
          return errorMessage;
        }
      }
    }
    // add user to database
    _fireStore
        .collection(_collectionName)
        .add(model.toJson())
        .whenComplete(() => "user added successfully")
        .catchError((error) {
      log(error.toString());
      return "Failed";
    });
    return "Done";
  }

  //update user data in database
  Future<UserModel> updateUser(String id) async {
    String? newEmail = sharedUser.email;

    if (newEmail != null) {
      try {
        // update user email in FirebaseAuth
        var currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser?.email != newEmail) {
          await currentUser?.updateEmail(newEmail);
          print("Email updated successfully");
        } else {
          print("Email is already up-to-date");
        }
      } catch (error) {
        print("Error updating email: $error");
      }
    } else {
      print("New email address is null. Cannot update.");
    }

    // get user from database
    QuerySnapshot userData = await _fireStore
        .collection(_collectionName)
        .where('id', isEqualTo: id)
        .get();
    String userId = userData.docs[0].id;

    // update the user info in the database
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update(
        {
          'name': sharedUser.name,
          'email': sharedUser.email,
          'phone': sharedUser.phone,
        },
      ).whenComplete(() {
        log("user update : ${userId}");
      });
    } on FirebaseException catch (e) {
      log(e.toString());
    }
    return await getUserById(id);
  }

  // update user location to the current location
  Future<void> updateUserLocation() async {
    QuerySnapshot userData = await _fireStore
        .collection(_collectionName)
        .where('id', isEqualTo: sharedUser.id)
        .get();
    String userId = userData.docs[0].id;

    // get user current location
    GetCurrentLocation getCurrentLocation = GetCurrentLocation();
    Position? currentLocation = await getCurrentLocation.getCurrentLocation();
    try {
      // update user location in database
      await FirebaseFirestore.instance.collection('users').doc(userId).update(
        {
          'latitude': currentLocation!.latitude,
          'longitude': currentLocation.longitude,
        },
      ).whenComplete(() {
        log("user current location updated successfully");
        // update the user location in the application
        sharedUser.latitude = currentLocation.latitude;
        sharedUser.longitude = currentLocation.longitude;
      });
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }

  // sign in to the application
  Future<bool> signIn(String email, String password) async {
    try {
      // sign in using FirebaseAuth
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // get the user info from database
      sharedUser = (await getUserByEmail(email))!;
      log(credential.user.toString());
      return true;
    } on FirebaseAuthException catch (e) {
      log(e.message.toString());
      return false;
    } catch (e) {
      rethrow;
    }
  }

  //sign out from application
  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // get user from database by his email
  Future<UserModel?> getUserByEmail(String email) async {
    QuerySnapshot userData = await _fireStore
        .collection(_collectionName)
        .where('email', isEqualTo: email)
        .get();

    if (userData.docs.isEmpty) {
      // user with this email is not found in the database
      return null;
    }

    Map<String, dynamic> data = {}; // Retrieve data from the first document

    data["id"] = userData.docs[0].get("id");
    data["name"] = userData.docs[0].get("name");
    data["role"] = userData.docs[0].get("role");
    data["longitude"] = userData.docs[0].get("longitude");
    data["latitude"] = userData.docs[0].get("latitude");
    data["email"] = userData.docs[0].get("email");
    data["phone"] = userData.docs[0].get("phone");
    data["favList"] = userData.docs[0].get("favList");

    return UserModel.fromJson(data);
  }

  // get all users from database
  Future<UserList> getUsers() async {
    QuerySnapshot usersData =
        await _fireStore.collection(_collectionName).get().whenComplete(() {
      log("get users done");
    }).catchError((error) {
      log(error.toString());
    });
    Map<String, dynamic> data = {};
    UserModel tempModel;
    UserList userList = UserList(users: []);
    for (var item in usersData.docs) {
      data["id"] = item.get("id");
      data["name"] = item.get("name");
      data["role"] = item.get("role");
      data["longitude"] = item.get("longitude");
      data["latitude"] = item.get("latitude");
      data["email"] = item.get("email");
      data["phone"] = item.get("phone");
      data["favList"] = item.get("favList");

      tempModel = UserModel.fromJson(data);
      userList.users.add(tempModel);
    }
    return userList;
  }

  // user can add place to his favorite places list
  // add it to database
  Future<void> addFavoritePlace(String id) async {
    try {
      QuerySnapshot userData = await _fireStore
          .collection(_collectionName)
          .where('id', isEqualTo: sharedUser.id)
          .get();
      String userId = userData.docs[0].id;

      await FirebaseFirestore.instance.collection('users').doc(userId).update(
        {
          'favList': FieldValue.arrayUnion([id]),
        },
      ).whenComplete(() {
        log("fav place  added : $id");
      });
    } on FirebaseException catch (e) {
      log(e.toString() + "&");
    }
  }

  // user can remove place from his favorite places list
  // remove it from database
  Future<void> removeFavoritePlace(String id) async {
    try {
      QuerySnapshot userData = await _fireStore
          .collection(_collectionName)
          .where('id', isEqualTo: sharedUser.id)
          .get();
      String userId = userData.docs[0].id;
      await FirebaseFirestore.instance.collection('users').doc(userId).update(
        {
          'favList': FieldValue.arrayRemove([id]),
        },
      ).whenComplete(() {
        log("fav place   remove : $id");
      });
    } on FirebaseException catch (e) {
      log(e.toString() + "^");
    }
  }

  // delete user account
  Future<void> deleteUser() async {
    try {
      //delete user from FirebaseAuth
      await FirebaseAuth.instance.currentUser!.delete();
    } catch (error) {
      log('Error deleting user 1: $error');
    }
    // delete from the database
    await FirebaseFirestore.instance
        .collection('users')
        .where('id', isEqualTo: sharedUser.id)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        var doc = querySnapshot.docs.first;
        doc.reference.delete().then((_) {
          print('Successfully deleted document');
        }).catchError((error) {
          print('Error deleting user: $error');
        });
      } else {
        print("No documents found for current user.");
      }
    }).catchError((error) {
      print("Error getting documents: $error");
    });
  }

  // get user by Id from database
  Future<UserModel> getUserById(String Id) async {
    QuerySnapshot userData = await _fireStore
        .collection(_collectionName)
        .where('id', isEqualTo: Id)
        .get();
    Map<String, dynamic> data = {};

    UserModel tempModel;
    data["id"] = userData.docs[0].get("id");
    data["name"] = userData.docs[0].get("name");
    data["role"] = userData.docs[0].get("role");
    data["longitude"] = userData.docs[0].get("longitude");
    data["latitude"] = userData.docs[0].get("latitude");
    data["phone"] = userData.docs[0].get("phone");
    data["email"] = userData.docs[0].get("email");
    data["favList"] = userData.docs[0].get("favList");

    tempModel = UserModel.fromJson(data);

    return tempModel;
  }
}
