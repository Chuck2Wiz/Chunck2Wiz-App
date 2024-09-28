import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


class SignUpRepository {
  final String apiUrl = dotenv.env['API_URL']!;

  Future<String> registerUser({
    required String userNum,
    required String nick,
    required int age,
    required String gender,
    required String job,
    required List<String> favorite,
  }) async {

    String serverGender;
    if (gender == '남성') {
      serverGender = 'MALE';
    } else if (gender == '여성') {
      serverGender = 'FEMALE';
    } else {
      serverGender = 'OTHER';
    }

    String serverJob;
    if (job == '학생') {
      serverJob = 'STUDENT';
    } else if (job == '주부') {
      serverJob = 'HOUSEWIFE';
    } else if (job == '직장인') {
      serverJob = 'WORKER';
    } else if (job == '전문직') {
      serverJob = 'PROFESSIONAL';
    } else {
      serverJob = 'OTHER';
    }

    final requestBody = {
      'userNum': userNum,
      'nick': nick,
      'age': age,
      'gender': serverGender, // 변환된 gender 값 사용
      'job': serverJob,
      'favorite': favorite,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      ).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Success SignUp: ${data['token']}');
        return data['token'];
      } else {
        print('Failed to SignUp: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to SignUp: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to SignUp: $e');
      throw Exception('Failed to SignUp: $e');
    }
  }
}
