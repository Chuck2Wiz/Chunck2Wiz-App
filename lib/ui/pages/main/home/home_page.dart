import 'package:chuck2wiz/data/blocs/main/home/home_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/home/home_event.dart';
import 'package:chuck2wiz/data/blocs/main/home/home_state.dart';
import 'package:chuck2wiz/data/repository/aiReport/ai_report_repository.dart';
import 'package:chuck2wiz/data/repository/article/article_repository.dart';
import 'package:chuck2wiz/ui/define/color_defines.dart';
import 'package:chuck2wiz/ui/util/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../data/blocs/main/ai/report/read/read_ai_report_bloc.dart';
import '../../../../data/blocs/main/ai/report/read/read_ai_report_event.dart';
import '../../../../data/blocs/main/community/read/community_read_bloc.dart';
import '../../../../data/blocs/main/community/read/community_read_event.dart';
import '../../../../data/blocs/main/mypage/aiReport/my_ai_report_bloc.dart';
import '../../../../data/repository/auth/user_repository.dart';
import '../../../../data/repository/comment/comment_repository.dart';
import '../../../define/format_defines.dart';
import '../community/read/community_read_page.dart';
import '../mypage/aiReport/my_ai_report_page.dart';
import '../mypage/aiReport/read_my_ai_report_page.dart';

class HomePage extends BasePage<HomeBloc, HomeState> {
  const HomePage({super.key}): super(keepBlocAlive: true);

  @override
  HomeBloc createBloc(BuildContext context) {
    return context.read<HomeBloc>();
  }

  @override
  void onBlockListener(BuildContext context, HomeState state) {
    if(state is HomeRefresh) {
      context.read<HomeBloc>().add(RefreshHomeEvent());
    }
  }

  @override
  void onInit(BuildContext context, HomeBloc bloc) {
    if(!bloc.isClosed) {
      bloc.add(GetLoadHomeDataEvent());
    }
  }

  @override
  Widget buildContent(BuildContext context, HomeState state) {
    return Stack(
      children: [
        Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(12, 12, 0, 12),
                child: _homeLogo(),
              ),
            ),
            Visibility(
                visible: !state.isLoading,
                child: SingleChildScrollView(
                  child: RefreshIndicator(
                      color: ColorDefines.mainColor,
                      backgroundColor: Colors.white,
                      onRefresh: () async {
                        context.read<HomeBloc>().add(RefreshHomeEvent());
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        child: Column(
                          children: [
                            _aiReportWidget(
                                state: state,
                                onClickAiReport: (aiReportId) {
                                  final readMyAiReportBloc = ReadAiReportBloc(AiReportRepository());
                                  readMyAiReportBloc.add(GetAiReportReadEvent(aiReportId: aiReportId));

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (newContext) => BlocProvider.value(
                                        value: readMyAiReportBloc,
                                        child: ReadMyAiReportPage(),
                                      ),
                                    ),
                                  );
                                },
                                onClickAddition: () {
                                  final myAiReportBloc = MyAiReportBloc(AiReportRepository());
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (newContext) => BlocProvider.value(
                                            value: myAiReportBloc,
                                            child: MyAiReportPage(),
                                          )
                                      )
                                  );
                                }
                            ),
                            const SizedBox(height: 36,),
                            _articlesWidget(
                                state: state,
                                onClickArticle: (articleId) {
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
                                })
                          ],
                        ),
                      ),
                  ),
                )
            )
          ],
        ),
        _circularLoading(state: state)
      ],
    );
  }

  Widget _circularLoading({required HomeState state}) {
    return Visibility(
        visible: state.isLoading,
        child: const Center(child: CircularProgressIndicator(color: ColorDefines.mainColor,),)
    );
  }

  Widget _homeLogo() {
    return Row(
      children: [
        Image.asset('assets/images/ic_logo.png', width: 42,),
        const SizedBox(width: 8,),
        Text(
            "척척법사",
            style: TextStyle(
              color: ColorDefines.mainColor,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
        )
      ],
    );
  }
  
  Widget _aiReportWidget({
    required HomeState state,
    required Function(String) onClickAiReport,
    required Function() onClickAddition
  }) {
    final reportData = state.getAiReportResponse?.data.aiReports;

    if(reportData == null) {
      return Container();
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "최근 AI 분석 레포트",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            GestureDetector(
              onTap: onClickAddition,
              child: Container(
                padding: EdgeInsets.fromLTRB(14, 4, 0, 4),
                color: Colors.transparent,
                child: Text(
                  "더보기",
                  style: TextStyle(
                      fontSize: 14,
                      color: ColorDefines.primaryGray
                  ),
                ),
              )
            )
          ],
        ),
        const SizedBox(height: 12,),
        Visibility(
            visible: reportData.isNotEmpty,
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: reportData.length > 3 ? 3 : reportData.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      onClickAiReport(reportData[index].id);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                      margin: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: ColorDefines.mainColor,
                              width: 0.5
                          ),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Text(
                        "${FormatDefines.formOptionFormat(option: reportData[index].data.selectOption)}의 분석 레포트",
                        style: TextStyle(
                            color: ColorDefines.mainColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  );
                }
            )
        ),
        Visibility(
            visible: reportData.isEmpty,
            child: Center(
              child: Column(
                children: [
                  Icon(
                    IconData(0xf35b, fontFamily: 'MaterialIcons'),
                    size: 24,
                    color: ColorDefines.primaryGray,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "저장된 레포트가 없어요.\nAI 레포트를 저장해보세요!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ColorDefines.primaryGray
                    ),
                  ),
                ],
              ),
            )
        )
      ],
    );
  }

  Widget _articlesWidget({required HomeState state, required Function(String) onClickArticle}) {
    timeago.setLocaleMessages('ko', timeago.KoMessages());
    final articleData = state.articleGetResponse?.data.sanitizedPosts;

    if(articleData == null) {
      return Container();
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "최신글",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        const SizedBox(height: 12,),
        Visibility(
            visible: articleData.isNotEmpty,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: ColorDefines.mainColor,
                  width: 0.5
                )
              ),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: articleData.length > 5 ? 5 : articleData.length,
                  itemBuilder: (context, index) {
                    final formattedDate = timeago.format(articleData[index].updatedAt, locale: 'ko');

                    return GestureDetector(
                      onTap: () {
                        onClickArticle(articleData[index].id);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                articleData[index].title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                                ),
                            ),
                            Text(
                                formattedDate,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ColorDefines.primaryGray
                                ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
              ),
            )
        ),
      ],
    );
  }
}