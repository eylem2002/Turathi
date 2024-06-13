import 'package:flutter/material.dart';

import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';

//page to view all user info
class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  SignUpController signUpController = SignUpController();
  TextController textController = TextController();
  String name = "", role = "", emailAddress = "", phoneNu = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeManager.background,
        title: Text(
          'Personal Details',
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
                    TextFormWidgetRead(
                      readly:true,
                      height: LayoutManager.widthNHeight0(context, 1) * 0.2,
                      width: double.infinity,
                      passToggle: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ' Name must not be empty ';
                        }
                        return null;
                      },
                      passController: signUpController.firstName,
                      str: sharedUser.name.toString().toUpperCase(),
                    ),
                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.008,
                    ),
                    Text(
                      'Role',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: ThemeManager.fontFamily,
                      ),
                    ),
                    TextFormWidgetRead(
                        readly:true,
                      height: LayoutManager.widthNHeight0(context, 1) * 0.2,
                      width: double.infinity,
                      passToggle: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ' role must not be empty ';
                        }
                        return null;
                      },
                      passController: signUpController.secondName,
                      str: sharedUser.role.toString().toUpperCase(),
                    ),
                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.008,
                    ),
                    Text(
                      'Email Address',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: ThemeManager.fontFamily,
                      ),
                    ),
                    TextFormWidgetRead(
                        readly:true,
                      height: LayoutManager.widthNHeight0(context, 1) * 0.2,
                      width: double.infinity,
                      passToggle: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email must not be empty ';
                        }
                        return null;
                      },
                      passController: signUpController.email,
                      str: sharedUser.email.toString(),
                    ),
                    SizedBox(
                      height: LayoutManager.widthNHeight0(context, 1) * 0.008,
                    ),
                    Text(
                      'Phone',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: ThemeManager.fontFamily,
                      ),
                    ),
                    TextFormWidgetRead(
                        readly:true,
                      height: LayoutManager.widthNHeight0(context, 1) * 0.2,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone must not be empty ';
                        }
                        return null;
                      },
                      width: double.infinity,
                      passToggle: false,
                      passController: signUpController.phone,
                      str: sharedUser.phone.toString(),
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
