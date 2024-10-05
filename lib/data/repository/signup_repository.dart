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
          favorite: mappingToFavorite(favorite)
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

  List<String> mappingToFavorite(List<String> favorites) {
    return favorites.map((favorite) =>
    switch (favorite) {
      '교통사고' => 'TRAFFIC_ACCIDENT',
      '명예훼손' => 'DEFAMATION',
      '임대차' => 'RENTAL',
      '이혼' => 'DIVORCE',
      '폭행' => 'ASSAULT',
      '사기' => 'FRAUD',
      '성범죄' => 'SEX_CRIME',
      '저작권' => 'COPYRIGHT',
      _ => 'OTHER',
    }
    ).toList();
  }
}
