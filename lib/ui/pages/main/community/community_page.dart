import 'package:bloc/bloc.dart';
import 'package:chuck2wiz/data/blocs/main/community/community_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/community/community_event.dart';
import 'package:chuck2wiz/data/blocs/main/community/community_state.dart';
import 'package:chuck2wiz/ui/define/color_defines.dart';
import 'package:chuck2wiz/ui/util/base_page.dart';
import 'package:chuck2wiz/ui/widget/community/community_list_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityPage extends BasePage<CommunityBloc, CommunityState> {
  const CommunityPage({super.key});

  @override
  CommunityBloc createBloc(BuildContext context) => CommunityBloc();

  @override
  Widget buildContent(BuildContext context, CommunityState state) {
    print("communityState: $state");
    return Stack(
      children: [
        Column(
          children: [
            _communityTitle(),
            const SizedBox(height: 16,),
            Expanded(child: _articlesList(state: state)),
          ],
        ),
        _circularLoading(state: state)
      ],
    );
  }

  @override
  void onInit(BuildContext context, CommunityBloc bloc) {
    bloc.add(const GetArticles());
  }

  Widget _communityTitle() {
    return const Text(
      "커뮤니티",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16
      ),
    );
  }

  Widget _circularLoading({required CommunityState state}) {
    return Visibility(
        visible: state is CommunityLoading,
        child: const Center(child: CircularProgressIndicator(color: ColorDefines.mainColor,),)
    );
  }

  Widget _articlesList({required CommunityState state}) {
    final articles = state.articleGetResponse?.data.sanitizedPosts ?? [];

    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return CommunityListCard(
          title: articles[index].title,
          content: articles[index].content,
          date: articles[index].updatedAt.toString(),
          nick: articles[index].author.nick,
          likeCount: articles[index].likes,
        );
      },
    );
  }
}