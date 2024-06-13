import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turathi/core/data_layer.dart';
import 'package:turathi/view/view_layer.dart';

//page to upload a pdf file includes the required info to be an expert
class RequestToBeExpert extends StatefulWidget {
  const RequestToBeExpert({super.key});

  @override
  State<RequestToBeExpert> createState() => _RequestToBeExpertState();
}

class _RequestToBeExpertState extends State<RequestToBeExpert> {
  String? msg;
  File? file;

  @override
  Widget build(BuildContext context) {
    RequestProvider _provider = Provider.of<RequestProvider>(context);

    return Scaffold(
      backgroundColor: ThemeManager.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeManager.background,
        title: Text(
          'Request To Be Expert',
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
      body: FutureBuilder(
        future: _provider.getRequestByUserId(),
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (data == null)
            return const Center(child: CircularProgressIndicator());
          if (data == "Not Found") {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _pickFile();
                    },
                    style: ThemeManager.buttonStyle,
                    child: Text(
                      'Upload Certificate',
                      style: ThemeManager.textStyle
                          .copyWith(color: ThemeManager.primary),
                    ),
                  ),
                  SizedBox(
                    height: LayoutManager.widthNHeight0(context, 1) * 0.08,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _provider!
                          .addRequest(RequestModel(), file!)
                          .whenComplete(() => Navigator.of(context).pop());
                    },
                    style: ThemeManager.buttonStyle,
                    child: Text(
                      'Request',
                      style: ThemeManager.textStyle
                          .copyWith(color: ThemeManager.primary),
                    ),
                  )
                ],
              ),
            );
          }
          return Scaffold(
                 backgroundColor: ThemeManager.background,
            body:
             Center(
              
              
              child: 
              Text(
                data.toUpperCase(),
                style: ThemeManager.textStyle
                    .copyWith(color: ThemeManager.primary),
                   
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _pickFile() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], //remove doc
    );

    if (pickedFile != null) {
      file = File(pickedFile.files.single.path!);
    }
  }
}
