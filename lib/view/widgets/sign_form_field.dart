

import 'package:flutter/material.dart';

import 'package:turathi/view/view_layer.dart';

class TextFormFieldWidgetSign extends StatelessWidget {
  final bool passToggle;
  final String labelText;
  final TextEditingController passController;
  final String? Function(String?)? validator;
  final String str;
  final double width;
  final double height;
  final Color color;
  final int maxlin,maxlog;
  final IconData iconSufData;

  const TextFormFieldWidgetSign(
      {super.key,
      required this.passToggle,
      required this.passController,
      required this.labelText,
      required this.validator,
      required this.str,
      this.width = 0,
      this.height = 0,
      this.maxlin = 1,
       this.maxlog = 30,
      
      this.color = Colors.lime,
      this.iconSufData = Icons.add});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: SizedBox(
          width: (width == 0) ? null : width,
          height: (height == 0) ? null : height,

        
          child: TextFormField(
          maxLines: maxlin,
          
          maxLength:maxlog,
         
            textAlign: TextAlign.left,
            keyboardType: TextInputType.emailAddress,
            obscureText: passToggle,
            controller: passController,
               
            decoration: InputDecoration(
              counterText: "",
              prefixIcon: Icon((iconSufData == Icons.add) ? null : iconSufData),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: (color == Colors.lime)
                        ? ThemeManager.primary
                        : color,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: (color == Colors.lime)
                        ? ThemeManager.primary
                        : color,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red.withOpacity(0.8),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red.withOpacity(0.8),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red.withOpacity(0.8),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              labelText: labelText,
              isDense: true,
             hintStyle: TextStyle(color: ThemeManager.textColor),
              hintText: str,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              
            ),
            validator: validator,
              
          )),
    );
  }
}
