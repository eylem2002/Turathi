import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';

class ReportPlace extends StatefulWidget {
  const ReportPlace({super.key, required this.placeId});
final String placeId;
  @override
  State<ReportPlace> createState() => _ReportPlaceState();

}

class _ReportPlaceState extends State<ReportPlace> {
  final formKey = GlobalKey<FormState>();
  final reasons = TextEditingController();


  @override
  Widget build(BuildContext context) {
    ReportProvider reportProvider = ReportProvider();
    return Scaffold(
       backgroundColor: ThemeManager.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeManager.background,
        title: Text(
          'Write a Report',
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
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormFieldWidget(
                  hintText: 'Enter Report Description',
                  labelText: '',
                  maxLine: 5,
                  controller: reasons,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (formKey.currentState!.validate()) {
                        //call controller
                        reportProvider.addReport(ReportModel(reasons: reasons.text,placeId: widget.placeId));
                        reasons.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Report Added Successfully")));
                        Navigator.pop(context);
                      } else {
                        log('add report failed');
                      }
                    });
                  },
                  style: ThemeManager.buttonStyle,
                  child: Text(
                    'Add Report',
                    style: ThemeManager.textStyle
                        .copyWith(color: ThemeManager.primary),
                  ),
                )
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
