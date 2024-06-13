import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../core/data_layer.dart';
import '../../../view_layer.dart';

//view all users requests to expert
//include the certificate as pdf and reject,accept actions
class RequestWidget extends StatefulWidget {
  RequestWidget({super.key, required this.count, required this.model});

  String count;
  RequestModel model;

  @override
  State<RequestWidget> createState() => _RequestWidgetState();
}

class _RequestWidgetState extends State<RequestWidget> {
  String remotePDFpath = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createFileOfPdfUrl().then((f) {
      setState(() {
        remotePDFpath = f.path;
      });
    });
  }

  TextStyle style = ThemeManager.textStyle
      .copyWith(fontSize: 16, color: ThemeManager.primary);
  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    try {
      final url = widget.model.certificate;
      final filename = url!.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = Directory.systemTemp;
      log("Download files");
      log("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    AdminService service = AdminService();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 150,
          color: ThemeManager.second,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.count, style: style),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.model.status!, style: style),
                  TextButton.icon(
                      icon: Icon(
                        Icons.picture_as_pdf,
                        color: ThemeManager.primary,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            requestPDFViewAdminRoute,
                            arguments: remotePDFpath);
                      },
                      label: Text(
                        "Download",
                        style: style,
                      )),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        widget.model.status = RequestStatus.accepted.name;
                        service.updateRequestStatus(
                          requestStatus: RequestStatus.accepted,
                          requestModel: widget.model,
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeManager.primary),
                    child: Text(
                      "Accept",
                      style: TextStyle(color: ThemeManager.second),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          widget.model.status = RequestStatus.rejected.name;
                          service.updateRequestStatus(
                              requestStatus: RequestStatus.rejected,
                              requestModel: widget.model);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeManager.primary,
                      ),
                      child: Text("Reject",
                          style: TextStyle(color: ThemeManager.second)))
                ],
              )
            ],
          )),
    );
  }
}
