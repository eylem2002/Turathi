import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:turathi/view/view_layer.dart';

class TextFormFieldWidget extends StatelessWidget {
   const TextFormFieldWidget({super.key,
     required this.labelText, required this.hintText,this.maxLine=1, required this.controller});
final String labelText;
  final String hintText;
  final int maxLine;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return    Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLine,
        validator: (value) {
          if (value!.isEmpty) {
            return '* Required';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
              color: ThemeManager.primary,
              fontWeight: FontWeight.bold,
              fontSize: 18),
          hintText: hintText,
          filled: true,
          fillColor: ThemeManager.second,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}






class NumberFormFieldWidget extends StatelessWidget {
  const NumberFormFieldWidget({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.maxLine = 1,
    required this.controller,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final int maxLine;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLine,
        validator: (value) {
          if (value!.isEmpty) {
            return '* Required';
          }
          return null;
        },
        inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Allow only numbers
        keyboardType: TextInputType.number, // Show numerical keyboard
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: ThemeManager.primary,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          hintText: hintText,
          filled: true,
          fillColor: ThemeManager.second,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}




class TextFormWidgetRead extends StatelessWidget {
  final bool passToggle;
  final TextEditingController passController;
  final String str;
  final double width;
  final double height;
  final Color color;
     final readly;
     final labely;
  final IconData iconSufData;
    final int maxlin,maxlog;

  const TextFormWidgetRead(
      {super.key,
      required this.passToggle,
      required this.passController,
      required this.readly,

      required this.str,
      this.width = 0,
      this.height = 0,
    this.labely="",
      
      this.color = Colors.lime,
      this.iconSufData = Icons.add,
       this.maxlin = 1,
       this.maxlog = 28,
      required String? Function(dynamic value) validator});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: (width == 0) ? null : width,
        height: (height == 0) ? null : height,
        
        child: TextFormField(
          
              maxLines: maxlin,
                maxLength:maxlog,
        readOnly: readly,
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
                      ?  ThemeManager.primary
                      : color,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red.withOpacity(0.8),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red.withOpacity(0.8),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red.withOpacity(0.8),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            isDense: true,
            hintText: str,
            
            labelText: labely,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ));
  }
}