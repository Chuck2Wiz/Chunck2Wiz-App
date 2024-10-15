import 'package:chuck2wiz/data/blocs/main/community/read/community_read_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/community/read/community_read_event.dart';
import 'package:chuck2wiz/data/blocs/main/community/read/community_read_state.dart';
import 'package:chuck2wiz/data/server/response/article/article_read_response.dart';
import 'package:chuck2wiz/ui/util/base_page.dart';
import 'package:chuck2wiz/ui/widget/textField/base_text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../define/color_defines.dart';

class CommunityReadPage extends BasePage<CommunityReadBloc, CommunityReadState> {
  final TextEditingController _commentController = TextEditingController();

  CommunityReadPage({super.key}): super(keepBlocAlive: true);

  @override
  CommunityReadBloc createBloc(BuildContext context) {
    return context.read<CommunityReadBloc>();
  }

  @override
  void onBlockListener(BuildContext context, CommunityReadState state) {
    final articleId = state.articleId;

    if(state is CommentWriteSuccess && articleId != null) {
      _commentController.clear();
      context.read<CommunityReadBloc>().add(GetArticleRead(articleId: articleId));
    }
  }
  
  @override
  Widget buildContent(BuildContext context, CommunityReadState state) {
    final List<Comment> comment = state.articleReadResponse?.data?.comments ?? [];

    return Stack(
      children: [
        Visibility(
            visible: !state.isLoading,
            child: Column(
              children: [
                _communityTitle(onClickBack: () {
                  Navigator.pop(context);
                }),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    children: [
                      _profileWidget(state: state),
                      _contentWidget(state: state),
                      const Divider(color: ColorDefines.primaryGray),
                      const SizedBox(height: 12,),
                      ...comment.map((comment) => _commentWidget(comment: comment)),
                      _commentEmptyWidget(state: state),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: ColorDefines.lightGray,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)
                      ),
                    ),
                    child: _commentWriteWidget(
                      controller: _commentController,
                      onChange: (value) {
                        context.read<CommunityReadBloc>().add(CommentWrite(comment: value));
                      },
                      onClickWrite: () {
                        context.read<CommunityReadBloc>().add(PostComment(comment: state.comment));
                      },
                    ),
                  ),
                )
              ],
            )
        ),
        _circularLoading(state: state)
      ],
    );
  }

  Widget _communityTitle({required Function() onClickBack}) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            child: IconButton(
                onPressed: onClickBack,
                icon: const Icon(Icons.arrow_back_ios, size: 24)
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.only(top: 16),
              child: const Text(
                "커뮤니티",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
            )
          )
        ],
      ),
    );
  }

  Widget _circularLoading({required CommunityReadState state}) {
    return Visibility(
        visible: state.isLoading,
        child: const Center(child: CircularProgressIndicator(color: ColorDefines.mainColor,),)
    );
  }

  Widget _profileWidget({required CommunityReadState state}) {
    final data = state.articleReadResponse?.data;
    
    return SizedBox(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.account_circle_rounded, size: 45, color: ColorDefines.primaryGray,),
          const SizedBox(width: 8,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data?.author?.nick ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),),
              Text(
                  data?.createdAt.toString() ?? "",
                  style: const TextStyle(
                    fontSize: 12
                  ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _contentWidget({required CommunityReadState state}) {
    final data = state.articleReadResponse?.data;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data?.title ?? "",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22
            ),
          ),
          const SizedBox(height: 8,),
          Text(
            data?.content ?? "",
            style: const TextStyle(
                fontSize: 16
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _commentWidget({required Comment comment}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.account_circle_rounded, size: 28, color: ColorDefines.primaryGray,),
              const SizedBox(width: 8,),
              Text(comment.author?.nick ?? "", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)
            ],
          ),
          const SizedBox(height: 2,),
          Text(comment.content, style: const TextStyle(fontSize: 14),)
        ],
      ),
    );
  }
  
  Widget _commentEmptyWidget({required CommunityReadState state}) {
    return Visibility(
        visible: state.articleReadResponse?.data?.comments.isEmpty ?? false,
        child: const Center(
          child: Column(
            children: [
              Icon(IconData(0xf62f, fontFamily: 'MaterialIcons'), size: 36, color: ColorDefines.primaryGray,),
              SizedBox(height: 8,),
              Text("첫 댓글을 작성해보세요!", style: TextStyle(fontSize: 14, color: ColorDefines.primaryGray),)
            ],
          ),
        )
    );
  }
  
  Widget _commentWriteWidget({
    required Function(String) onChange,
    required Function() onClickWrite,
    required TextEditingController controller
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: BaseTextFieldWidget(
                onChange: onChange,
                hint: "댓글을 입력하세요.",
                hintTextStyle: const TextStyle(
                    color: ColorDefines.primaryGray,
                    fontSize: 14
                ),
              )
          ),
          IconButton(
            icon: const Icon(IconData(0xf574, fontFamily: 'MaterialIcons'), color: ColorDefines.mainColor, size: 28,),
            onPressed: onClickWrite,
          )
        ],
      ),
    );
  }

}