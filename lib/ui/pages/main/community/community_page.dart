import 'package:chuck2wiz/data/blocs/main/community/community_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/community/community_event.dart';
import 'package:chuck2wiz/data/blocs/main/community/community_state.dart';
import 'package:chuck2wiz/data/blocs/main/community/read/community_read_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/community/read/community_read_event.dart';
import 'package:chuck2wiz/data/repository/comment/comment_repository.dart';
import 'package:chuck2wiz/ui/define/color_defines.dart';
import 'package:chuck2wiz/ui/pages/main/community/read/community_read_page.dart';
import 'package:chuck2wiz/ui/pages/main/community/write/community_write_page.dart';
import 'package:chuck2wiz/ui/util/base_page.dart';
import 'package:chuck2wiz/ui/widget/community/community_list_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../data/blocs/main/community/write/community_write_bloc.dart';
import '../../../../data/repository/article/article_repository.dart';
import '../../../../data/repository/auth/user_repository.dart';
import '../../../define/font_defines.dart';

class CommunityPage extends BasePage<CommunityBloc, CommunityState> {
  const CommunityPage({super.key}): super(keepBlocAlive: true);

  @override
  void onBlockListener(BuildContext context, CommunityState state) {
    if(state is CommunityRefresh) {
      context.read<CommunityBloc>().add(const GetArticles());
    }
  }

  @override
  CommunityBloc createBloc(BuildContext context) {
    return context.read<CommunityBloc>();
  }

  @override
  Widget buildContent(BuildContext context, CommunityState state) {
    timeago.setLocaleMessages('ko', timeago.KoMessages());

    return RefreshIndicator(
      color: ColorDefines.mainColor,
      backgroundColor: Colors.white,
      onRefresh: () async {
        context.read<CommunityBloc>().add(RefreshArticle());
      },
      child: Stack(
        children: [
          Column(
            children: [
              _communityTitle(),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: _articleWriteButton(
                onClickWrite: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (newContext) => MultiBlocProvider(
                        providers: [
                          BlocProvider.value(value: context.read<CommunityBloc>()),
                          BlocProvider.value(value: context.read<CommunityWriteBloc>())
                        ],
                        child: const CommunityWritePage(),
                      ),
                    ),
                  );
                }
            ),
          ),
          _circularLoading(state: state)
        ],
      )
    );
  }

  @override
  void onInit(BuildContext context, CommunityBloc bloc) {
    if(!bloc.isClosed) {
      bloc.add(const GetArticles());
    }
  }

  Widget _communityTitle() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: const Text(
        "커뮤니티",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20
        ),
      ),
    );
  }

  Widget _circularLoading({required CommunityState state}) {
    return Visibility(
        visible: state.isLoading,
        child: const Center(child: CircularProgressIndicator(color: ColorDefines.mainColor,),)
    );
  }

  Widget _articlesList({required CommunityState state, required Function(String) onClickPost}) {
    final articles = state.articleGetResponse?.data.sanitizedPosts ?? [];

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

  Widget _articleWriteButton({required Function() onClickWrite}) {
    return GestureDetector(
      onTap: onClickWrite,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, -1),
                  blurRadius: 3,
                  spreadRadius: 3
              )
            ]
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/ic_button_write.png"),
            const SizedBox(width: 4,),
            Text("글쓰기", style: FontDefines.writeText,)
          ],
        ),
      ),
    );
  }

}