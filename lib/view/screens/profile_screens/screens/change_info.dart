import 'package:flutter/material.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';

//page to change user info
class ChangeInfo extends StatefulWidget {
  const ChangeInfo({Key? key});

  @override
  State<ChangeInfo> createState() => _ChangeInfoState();
}

class _ChangeInfoState extends State<ChangeInfo> {
  String name = "", emailAddress = "", phoneNu = "";
  SignUpController signUpController = SignUpController();
  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeManager.background,
        title: Text(
          'Change Info',
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
        key: signUpController.formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Center(
              child: SizedBox(
                width: LayoutManager.widthNHeight0(context, 1) * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(height: 1, color: Colors.grey[300]),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: ThemeManager.fontFamily,
                        ),
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      initialValue: sharedUser.name.toString(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        counterText: "",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ThemeManager.primary,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ThemeManager.primary,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        isDense: true,
                        hintText: 'Enter your name',
                      ),
                    ),
                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.05,
                    ),
                    Text(
                      'Email Address',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: ThemeManager.fontFamily,
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          emailAddress = value;
                        });
                      },
                      initialValue: sharedUser.email.toString(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email must not be empty';
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.1#$&'*+-/=?^_ {|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailValid) {
                          return "Enter valid Email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        counterText: "",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ThemeManager.primary,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ThemeManager.primary,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        isDense: true,
                        hintText: 'Enter your email',
                      ),
                    ),
                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.05,
                    ),
                    Text(
                      'Phone',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: ThemeManager.fontFamily,
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          phoneNu = value;
                        });
                      },
                      initialValue: sharedUser.phone.toString(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone must not be empty';
                        }
                        bool phoneExp = RegExp(r'^\d{10}$').hasMatch(value);
                        if (!phoneExp) {
                          return 'Phone number is not valid';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        counterText: "",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ThemeManager.primary,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ThemeManager.primary,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        isDense: true,
                        hintText: 'Enter your phone number',
                      ),
                    ),
                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.085,
                    ),
                    InkWell(
                      onTap: () async {
                        if (signUpController.formKey.currentState!.validate()) {
                          oldemail = sharedUser.email.toString();
                          if (name == "") {
                            name = sharedUser.name.toString();
                          }
                          if (emailAddress == "") {
                            emailAddress = sharedUser.email.toString();
                          }
                          if (phoneNu == "") {
                            phoneNu = sharedUser.phone.toString();
                          }
                          
                          userService.updateUser(sharedUser.id.toString());
                          sharedUser.name = name;
                          sharedUser.email = emailAddress;
                          sharedUser.phone = phoneNu;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("User Info Updated Successfully")),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: Center(
                        child: Container(
                          width: LayoutManager.widthNHeight0(context, 0) * 0.3,
                          height: LayoutManager.widthNHeight0(context, 0) * .06,
                          decoration: BoxDecoration(
                            color: ThemeManager.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "Edit Info",
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
    );
  }
}
