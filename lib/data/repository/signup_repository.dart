import 'package:chuck2wiz/data/server/request/auth/auth_request.dart';
import 'package:chuck2wiz/data/server/response/auth/check_nick_response.dart';
import 'package:chuck2wiz/data/server/response/auth/check_user_response.dart';
import 'package:chuck2wiz/data/server/response/auth/sign_up_response.dart';
import 'package:chuck2wiz/data/server/vo/auth/check_nick_vo.dart';
import 'package:chuck2wiz/data/server/vo/auth/check_user_vo.dart';
import 'package:chuck2wiz/data/server/vo/auth/sign_up_vo.dart';


class SignUpRepository {
  Future<SignUpResponse> register({
    required String userNum,
    required String nick,
    required int age,
    required String gender,
    required String job,
    required List<String> favorite
  }) async {
    return AuthRequest().register(
      SignUpVo(
          userNum: userNum,
          nick: nick,
          age: age,
          gender: mappingToGender(gender: gender),
          job: mappingToJob(job: job),
          favorite: favorite
      )
    );
  }

  Future<CheckNickResponse> checkNick({required String nick}) async {
    return AuthRequest().checkNick(CheckNickVo(nick: nick));
  }

  String mappingToGender({required String gender}) {
    return switch(gender) {
      '남성' => 'MALE',
      '여성' => 'FEMALE',
      _ => 'OTHER'
    };
  }

  String mappingToJob({required String job}) {
    return switch(job) {
      '학생' => 'STUDENT',
      '주부' => 'HOUSEWIFE',
      '직장인' => 'WORKER',
      '전문직' => 'PROFESSIONAL',
      _ => 'OTHER',
    };
  }
}
