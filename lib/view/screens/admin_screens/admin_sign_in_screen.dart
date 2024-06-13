import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../core/data_layer.dart';
import '../../view_layer.dart';

//Admin Sigin Page by ID and Password
class AdminSignIn extends StatefulWidget {
  const AdminSignIn({super.key});

  @override
  State<AdminSignIn> createState() => _AdminSignInState();
}

class _AdminSignInState extends State<AdminSignIn> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool flag = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    AdminService service = AdminService();
    return Scaffold(
      backgroundColor: const Color(0xffEAEBEF),
      body: SingleChildScrollView(
        child: Form(
            key: key,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(150.0),
                          bottomRight: Radius.circular(150.0),
                        ),
                        child: Transform.scale(
                          scale: 1.1,
                          child: Image.asset(
                            'assets/images/img_png/profile.png',
                            width: double.infinity,
                            height:
                                LayoutManager.widthNHeight0(context, 1) * 0.54,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Positioned(
                        top: LayoutManager.widthNHeight0(context, 1) * 0.155,
                        left: LayoutManager.widthNHeight0(context, 1) * 0.08,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Turathi",
                              style: TextStyle(
                                  fontSize:
                                      LayoutManager.widthNHeight0(context, 1) *
                                          0.084,
                                  color: ThemeManager.second,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: ThemeManager.fontFamily),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: LayoutManager.widthNHeight0(context, 1) * 0.18,
                  ),
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: LayoutManager.widthNHeight0(context, 1) *
                                  0.02,
                              right:
                                  LayoutManager.widthNHeight0(context, 1) * 0.6,
                              bottom: LayoutManager.widthNHeight0(context, 0) *
                                  0.02),
                        ),
                        TextFormFieldWidgetSign(
                          passToggle: false,
                          passController: _idController,
                          labelText: 'ID',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Admin ID";
                            }

                            return null;
                          },
                          str: "000000",
                        ),
                        SizedBox(
                          height: LayoutManager.widthNHeight0(context, 1) * 0.1,
                        ),
                        TextFormFieldWidgetSign(
                          passToggle: true,
                          passController: _passController,
                          labelText: 'password',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Password";
                            } else if (value.length < 7) {
                              return "Password length should be more than 7 characters";
                            } else {
                              return null;
                            }
                          },
                          str: "Password",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: LayoutManager.widthNHeight0(context, 1) * 0.2,
                  ),
                  SizedBox(
                    width: LayoutManager.widthNHeight0(context, 1) * 0.55,
                    height: LayoutManager.widthNHeight0(context, 0) * 0.06,
                    child: InkWell(
                      onTap: () async {
                        if (key.currentState!.validate()) {


                          bool t =await service.signIn(_idController.text, _passController.text);
                          log(    t.toString());

                          if(t) {
                            AdminCheck=true;
                            Navigator.of(context).pushReplacementNamed(homeAdminRoute);

                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Error"),
                                  content: const Text(
                                      "An error happened"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }

                        }
                      },
                      child: Container(
                        height: LayoutManager.widthNHeight0(context, 0) * .07,
                        decoration: BoxDecoration(
                            color: ThemeManager.primary,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                color: ThemeManager.second,
                                fontSize: 20,
                                fontFamily: ThemeManager.fontFamily,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: LayoutManager.widthNHeight0(context, 1) * 0.4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Back to User Mode?",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * .033,
                            fontFamily: ThemeManager.fontFamily,
                            color: Colors.grey[600]),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(signIn);
                          },
                          child: Text(
                            "Yes",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                fontFamily: ThemeManager.fontFamily,
                                color: Colors.grey[700]),
                          ))
                    ],
                  ),
                ])),
      ),
    );
  }
}
