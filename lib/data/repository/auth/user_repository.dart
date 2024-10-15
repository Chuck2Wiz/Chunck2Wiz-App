import 'package:chuck2wiz/data/server/request/auth/auth_request.dart';
import 'package:chuck2wiz/data/server/response/auth/get_user_info_response.dart';

class UserRepository {
  Future<GetUserInfoResponse> getUserInfo({required String userNum}) async {
    return AuthRequest().getUserInfo(userNum);
  }
}