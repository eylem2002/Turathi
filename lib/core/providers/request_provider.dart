import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import '../data_layer.dart';

// Provider class To Manage Request
class RequestProvider extends ChangeNotifier {
  final RequestService _requestService = RequestService();

  // add request to be an expert
  Future<String> addRequest(RequestModel model, File file) async {
    String msg =
        (await _requestService.addRequest(model, file).whenComplete(() {
      log("Request added successfully");
    }));
    return msg;
  }

  // get current user request if have
  Future<String> getRequestByUserId() async {
    RequestModel temp = await _requestService.getRequestByUserId();
    if (temp.requestId == "-1") {
      return "Not Found";
    }
    return temp.status!;
  }

}
