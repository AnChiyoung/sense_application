import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sense_flutter_application/models/login/login_model.dart';

class ReportRequest {
  Future<bool> reportRequest(List<int> selectReportIndex, String description, int commentId) async {

    Map<String, dynamic> sendReport = ReportModel(reportChoiceId: selectReportIndex, description: description).toJson();

    print('https://dev.server.sense.runners.im/api/v1/comment/${commentId.toString()}/report');
    print(jsonEncode(sendReport));

    final response = await http.post(
      Uri.parse('https://dev.server.sense.runners.im/api/v1/comment/${commentId.toString()}/report'),
      body: jsonEncode(sendReport),
      headers: {
        'Authorization': 'Bearer ${PresentUserInfo.loginToken}',
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if(response.statusCode == 200 || response.statusCode == 201) {
      print('신고가 완료되었습니다.');
      return true;
    } else {
      print('신고에 실패하였습니다.');
      return false;
    }
  }
}

class ReportModel {
  List<int>? reportChoiceId;
  String? description;

  ReportModel({
    this.reportChoiceId,
    this.description,
  });

  Map<String, dynamic> toJson() => {
    'report_choice_ids': reportChoiceId,
    'description': description,
  };
}