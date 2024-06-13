import 'package:flutter/cupertino.dart';
import '../data_layer.dart';

// Provider class To Manage Reports
class ReportProvider extends ChangeNotifier {
  final ReportService _reportService = ReportService();

  // add new report about place to report about (wrong info,,,)
  Future<String> addReport(ReportModel model) async {
    String msg = (await _reportService.addReport(model).whenComplete(() {}));
    return msg;
  }
}