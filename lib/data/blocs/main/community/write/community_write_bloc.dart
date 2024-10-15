import 'package:bloc/bloc.dart';
import 'package:chuck2wiz/data/blocs/main/community/community_state.dart';
import 'package:chuck2wiz/data/blocs/main/community/write/community_write_event.dart';
import 'package:chuck2wiz/data/blocs/main/community/write/community_write_state.dart';
import 'package:chuck2wiz/data/db/shared_preferences_helper.dart';
import 'package:chuck2wiz/data/repository/article/article_repository.dart';
import 'package:chuck2wiz/data/server/vo/article/article_create_vo.dart';

import '../../../../repository/auth/user_repository.dart';

class CommunityWriteBloc extends Bloc<CommunityWriteEvent, CommunityWriteState> {
  final UserRepository userRepository;
  final ArticleRepository articleRepository;

  CommunityWriteBloc(this.userRepository, this.articleRepository): super(CommunityWriteInitial()) {
    on<WriteTitle>(_onWriteTitle);
    on<WriteContent>(_onWriteContent);
    on<CompleteWrite>(_onCompleteWrite);
  }

  void _onWriteTitle(WriteTitle event, Emitter<CommunityWriteState> emit) {
    emit(state.copyWith(title: event.title));
  }

  void _onWriteContent(WriteContent event, Emitter<CommunityWriteState> emit) {
    emit(state.copyWith(content: event.content));
  }

  Future<void> _onCompleteWrite(CompleteWrite event, Emitter<CommunityWriteState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final userNum = await SharedPreferencesHelper.getUserNum();
      String? nick = await SharedPreferencesHelper.getNick();

      /// nick이 로컬 DB에 없는 경우에만 API 호출
      if(nick == null) {
        final response = await userRepository.getUserInfo(userNum: userNum ?? "");

        if(response.success) {
          nick = response.data.nick;
          await SharedPreferencesHelper.saveNick(nick);
        } else {
          emit(const CommunityWriteFailure(error: "유저 정보를 불러오는데 실패했습니다."));
          return;
        }
      }

      final response = await articleRepository.createArticle(
        ArticleCreateVo(
            title: state.title,
            content: state.content,
            author: Author(userNum: userNum ?? "", nick: nick ?? "")
        )
      );

      if(response.success) {
        emit(CommunityWriteSuccess());
      } else {
        emit(CommunityWriteFailure(error: response.message));
      }
    }catch (e) {
      emit(CommunityWriteFailure(error: e));
    }finally {
      emit(state.copyWith(isLoading: false));
      emit(CommunityWriteInitial());
    }
  }
}