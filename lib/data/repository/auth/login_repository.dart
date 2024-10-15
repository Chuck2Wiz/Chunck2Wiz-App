import 'package:chuck2wiz/data/server/request/auth/auth_request.dart';
import 'package:chuck2wiz/data/server/response/auth/check_user_response.dart';

import '../../server/vo/auth/check_user_vo.dart';

class LoginRepository {
  Future<CheckUserResponse> checkUser({required String userNum}) async {
    return AuthRequest().checkUser(CheckUserVo(userNum: userNum));
  }
}