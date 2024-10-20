import 'package:bloc/src/bloc.dart';
import 'package:chuck2wiz/data/blocs/main/mypage/myArticles/my_articles_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/mypage/myArticles/my_articles_event.dart';
import 'package:chuck2wiz/data/blocs/main/mypage/myArticles/my_articles_state.dart';
import 'package:chuck2wiz/ui/util/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../../data/blocs/main/community/read/community_read_bloc.dart';
import '../../../../../data/blocs/main/community/read/community_read_event.dart';
import '../../../../../data/repository/article/article_repository.dart';
import '../../../../../data/repository/auth/user_repository.dart';
import '../../../../../data/repository/comment/comment_repository.dart';
import '../../../../define/color_defines.dart';
import '../../../../define/font_defines.dart';
import '../../../../widget/community/community_list_card.dart';
import '../../community/read/community_read_page.dart';

class MyArticlesPage extends BasePage<MyArticlesBloc, MyArticlesState> {
  const MyArticlesPage({super.key}): super(keepBlocAlive: true);

  @override
  MyArticlesBloc createBloc(BuildContext context) {
    return context.read<MyArticlesBloc>();
  }


  @override
  void onInit(BuildContext context, MyArticlesBloc bloc) {
    if(!bloc.isClosed) {
      bloc.add(const GetMyArticlesEvent());
    }
  }

  @override
  Widget buildContent(BuildContext context, state) {
    timeago.setLocaleMessages('ko', timeago.KoMessages());

    return Stack(
      children: [
        Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: _backButtonWidget(onClickBackButton: () {
                    Navigator.pop(context);
                  }),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "작성한 글",
                    style: FontDefines.black18Bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16,),
            Expanded(
                child: _articlesList(
                    state: state,
                    onClickPost: (articleId) {
                      final readBloc = CommunityReadBloc(ArticleRepository(), CommentRepository(), UserRepository());
                      readBloc.add(GetArticleRead(articleId: articleId));

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (newContext) => BlocProvider.value(
                            value: readBloc,
                            child: CommunityReadPage(),
                          ),
                        ),
                      );
                    }
                )),
          ],
        ),
        _circularLoading(state: state)
      ],
    );
  }

  Widget _circularLoading({required MyArticlesState state}) {
    return Visibility(
        visible: state.isLoading,
        child: Center(child: CircularProgressIndicator(color: ColorDefines.mainColor,),)
    );
  }

  Widget _backButtonWidget({required Function() onClickBackButton}) {
    return IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 24,
        ),
        onPressed: onClickBackButton);
  }

  Widget _articlesList({required MyArticlesState state, required Function(String) onClickPost}) {
    final articles = state.myArticlesResponse?.data.posts ?? [];

    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final formattedDate = timeago.format(articles[index].updatedAt, locale: 'ko');

        return CommunityListCard(
          id: articles[index].id,
          title: articles[index].title,
          content: articles[index].content,
          date: formattedDate,
          nick: articles[index].author.nick,
          commentCount: articles[index].comments.length,
          onClickArticle: () {
            onClickPost(articles[index].id);
          },
        );
      },
    );
  }


}