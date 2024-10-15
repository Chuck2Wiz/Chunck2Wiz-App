import 'dart:convert';

import 'package:chuck2wiz/data/http/base_http.dart';
import 'package:chuck2wiz/data/server/response/auth/check_nick_response.dart';
import 'package:chuck2wiz/data/server/response/auth/check_user_response.dart';
import 'package:chuck2wiz/data/server/response/auth/get_user_info_response.dart';
import 'package:chuck2wiz/data/server/vo/auth/check_nick_vo.dart';
import 'package:chuck2wiz/data/server/vo/auth/check_user_vo.dart';
import 'package:chuck2wiz/data/server/vo/auth/sign_up_vo.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../response/auth/sign_up_response.dart';

class AuthRequest {
  static String BASE_URL = "${dotenv.env['API_URL']}/v1/auth";

  /**
   *  /register
   * */
  Future<SignUpResponse> register(SignUpVo signUpVo) async {
    final url = Uri.parse('$BASE_URL/register');

    try {
      final response = await BaseHttp().post(
          url.toString(),
          signUpVo.toJson()
      );

      return SignUpResponse.fromJson(jsonDecode(response));
    }catch(e) {
      print("error: $e");
      rethrow;
    }
  }

  /**
   *  /check-existUser
   * */
  Future<CheckUserResponse> checkUser(CheckUserVo checkUserVo) async {
    final url = Uri.parse('$BASE_URL/check-existUser/${checkUserVo.userNum}');

    try {
      final response = await BaseHttp().get(url.toString());

      final parsedResponse = CheckUserResponse.fromJson(jsonDecode(response));

      return parsedResponse;
    } catch (e) {
      print("ERROR: $e");
      rethrow;
    }
  }



  /**
   *  /check-nickname
   * */
  Future<CheckNickResponse> checkNick(CheckNickVo checkNickVo) async {
    final url = Uri.parse('$BASE_URL/check-nickname/${checkNickVo.nick}');

    try {
      final response = await BaseHttp().get(url.toString());

      return CheckNickResponse.fromJson(jsonDecode(response));
    } catch(e) {
      rethrow;
    }
  }

  /**
   *  /user/:userNum
   */
  Future<GetUserInfoResponse> getUserInfo(String userNum) async {
    final url = Uri.parse('$BASE_URL/user/$userNum');

    try {
      final response = await BaseHttp().get(url.toString());

      return GetUserInfoResponse.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }
}