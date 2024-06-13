
import 'package:flutter/material.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';


//page to sign in the user with his email and password
class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  
  TextController textController = TextController();
  UserService userService = UserService();

  bool flag = false;

  @override
  void dispose() {
    textController.controllerEmail.dispose();
    textController.controllerPass.dispose();
    super.dispose();
  }

  bool? isChecked = false;
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key("log in"),
      backgroundColor: const Color(0xffEAEBEF),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
              key: textController.formField,
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
                              height: LayoutManager.widthNHeight0(context, 1) *
                                  0.54,
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
                                    fontSize: LayoutManager.widthNHeight0(
                                            context, 1) *
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
                                right: LayoutManager.widthNHeight0(context, 1) *
                                    0.6,
                                bottom:
                                    LayoutManager.widthNHeight0(context, 0) *
                                        0.02),
                          ),
                          TextFormFieldWidgetSign(
                            passToggle: false,
                            passController: textController.controllerEmail,
                            labelText: 'Email',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Email";
                              }
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.1#$&'*+-/=?^_ {|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value);
                              if (!emailValid) {
                                return "Enter valid Email";
                              }
                              return null;
                            },
                            str: "email@gmail.com",
                          ),
                          SizedBox(
                            height:
                                LayoutManager.widthNHeight0(context, 1) * 0.1,
                          ),
                          TextFormFieldWidgetSign(
                            passToggle: true,
                            passController: textController.controllerPass,
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
                    Column(
                      children: [
                        SizedBox(
                          width: LayoutManager.widthNHeight0(context, 1) * 0.55,
                          height:
                              LayoutManager.widthNHeight0(context, 0) * 0.06,
                          child: InkWell(
                            onTap: () async {
                              if (textController.formField.currentState!
                                  .validate()) {
                                    
                                bool signInSuccess = await userService.signIn(
                                  textController.controllerEmail.text,
                                  textController.controllerPass.text,
                                );


                                if (signInSuccess) {
                                  sharedUser = (await userService
                                      .getUserByEmail(textController
                                      .controllerEmail.text))!;
                                  Navigator.of(context)
                                      .pushReplacementNamed(bottomNavRoute);

                        


                                } else {
                                  print("error is happened");
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Error"),
                                        content: Text(
                                            "An error has occurred. Don't have an account?"),
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
                                  textController.controllerEmail.clear();
                                  textController.controllerPass.clear();
                                }
                              }
                            },
                            child: Container(
                              height:
                                  LayoutManager.widthNHeight0(context, 0) * .07,
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
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Not a member?",
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * .033,
                              fontFamily: ThemeManager.fontFamily,
                              color: Colors.grey[600]),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(signUp);
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  fontFamily: ThemeManager.fontFamily,
                                  color: Colors.grey[700]),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Are you admin?",
                          style: TextStyle(
                              fontSize:
                              MediaQuery.of(context).size.width * .033,
                              fontFamily: ThemeManager.fontFamily,
                              color: Colors.grey[600]),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(signInAdminRoute);
                            },
                            child: Text(
                              "Start",
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
      ),
    );
  }
}
class TextController{

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPass = TextEditingController();
  GlobalKey<FormState>_formField = GlobalKey<FormState>();


  // ignore: unnecessary_getters_setters
  TextEditingController get controllerEmail => _controllerEmail;

  // ignore: unnecessary_getters_setters
  TextEditingController get controllerPass => _controllerPass;

  GlobalKey<FormState> get formField => _formField;

  set formField(value) {
    _formField = value;
  }

  set controllerPass(TextEditingController value) {
    _controllerPass = value;
  }

  set controllerEmail(TextEditingController value) {
    _controllerEmail = value;
  }
}