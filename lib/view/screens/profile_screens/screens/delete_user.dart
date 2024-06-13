import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';


//page to remove user account
class DeleteUser extends StatefulWidget {
  const DeleteUser({Key? key});

  @override
  State<DeleteUser> createState() => _DeleteUser();
}

class _DeleteUser extends State<DeleteUser> {
  UserProvider userProvider = UserProvider();

  @override
  Widget build(BuildContext context) {
    print(
        "FirebaseAuth.instance.currentUser${FirebaseAuth.instance.currentUser?.email}");
    print("object${FirebaseAuth.instance.currentUser?.uid}");

    return Scaffold(
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeManager.background,
        title: Text(
          'Delete Account',
          style: ThemeManager.textStyle.copyWith(
            fontSize: LayoutManager.widthNHeight0(context, 1) * 0.05,
            fontWeight: FontWeight.bold,
            fontFamily: ThemeManager.fontFamily,
            color: ThemeManager.primary,
          ),
        ),
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(LayoutManager.widthNHeight0(context, 1) * 0.01),
          child: Divider(
            height: LayoutManager.widthNHeight0(context, 1) * 0.01,
            color: Colors.grey[300],
          ),
        ),
      ),
      body: Form(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Center(
              child: SizedBox(
                width: LayoutManager.widthNHeight0(context, 1) * 0.9,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: LayoutManager.widthNHeight0(context, 1) * 0.8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: ThemeManager.primary,
                                title: Text(
                                  'Confirm Deletion',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: Text(
                                  // textAlign: TextAlign.start,
                                  'Are you sure you want to delete your account ?',
                                  style: TextStyle(color: Colors.white,fontSize: 16),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                          color:ThemeManager.second,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      userProvider.deleteUser();

                                     
                                      Navigator.of(context)
                                          .pushReplacementNamed(signIn);
                                    },
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 255, 32, 16),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Center(
                          child: Container(
                            width:
                                LayoutManager.widthNHeight0(context, 0) * 0.3,
                            height:
                                LayoutManager.widthNHeight0(context, 0) * .06,
                            decoration: BoxDecoration(
                              color: ThemeManager.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                "Delete My Account",
                                style: TextStyle(
                                  color: ThemeManager.second,
                                  fontSize: 20,
                                  fontFamily: ThemeManager.fontFamily,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
