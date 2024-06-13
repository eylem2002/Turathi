import '../../utils/shared.dart';
enum RequestStatus { accepted, rejected,waiting,dataWarning }

// Model class representing a RequestModel
class RequestModel {
  String? requestId;
  String? status;
  String? certificate;
  String? userId;



  RequestModel.empty() {
    requestId = "-1";
  }

  RequestModel() {
    requestId = uuid.v4();
    userId = sharedUser.id;
    status = RequestStatus.waiting.name;
  }

//This is a factory Constructor to create RequestModel instance from JSON obj

  RequestModel.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    status = json['status'];
    certificate = json['certificate'];
    userId = json['userId'];
  }

//convert the RequestModel instance to a JSON object

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestId'] = this.requestId;
    data['status'] = this.status;
    data['certificate'] = this.certificate;
    data['userId'] = this.userId;
    return data;
  }
}

//  class representing a list of Requests
class RequestList {
  List<RequestModel> requests;

  RequestList({required this.requests});

  factory RequestList.fromJson(List<dynamic> data) {

    List<RequestModel> temp = [];
    temp = data.map((item) {
      return RequestModel.fromJson(Map<String, dynamic>.from(item));
    }).toList();

    return RequestList(requests: temp);
  }
}
