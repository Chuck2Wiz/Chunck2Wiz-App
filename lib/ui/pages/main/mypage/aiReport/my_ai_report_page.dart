import 'package:chuck2wiz/data/blocs/main/ai/report/read/read_ai_report_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/mypage/aiReport/my_ai_report_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/mypage/aiReport/my_ai_report_event.dart';
import 'package:chuck2wiz/data/blocs/main/mypage/aiReport/my_ai_report_state.dart';
import 'package:chuck2wiz/data/repository/aiReport/ai_report_repository.dart';
import 'package:chuck2wiz/main.dart';
import 'package:chuck2wiz/ui/define/format_defines.dart';
import 'package:chuck2wiz/ui/pages/main/mypage/aiReport/read_my_ai_report_page.dart';
import 'package:chuck2wiz/ui/util/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../data/blocs/main/ai/report/read/read_ai_report_event.dart';
import '../../../../define/color_defines.dart';

class MyAiReportPage extends BasePage<MyAiReportBloc, MyAiReportState> {
  const MyAiReportPage({super.key}): super(keepBlocAlive: true);

  @override
  MyAiReportBloc createBloc(BuildContext context) {
    return context.read<MyAiReportBloc>();
  }

  @override
  void onInit(BuildContext context, MyAiReportBloc bloc) {
    if(!bloc.isClosed) {
      bloc.add(GetAiReportEvent());
    }
  }


  @override
  Widget buildContent(BuildContext context, MyAiReportState state) {
    final aiReports = state.getAiReportResponse?.data.aiReports;

    return Stack(
      children: [
        Column(
          children: [
            _aiReportTitle(
                onClickBack: () {
                  Get.back();
                }
            ),
            Expanded(
              child: aiReports?.isEmpty == true
                  ? Center(  // Expanded 내에서 Center로 완전히 중앙 배치
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      IconData(0xf35b, fontFamily: 'MaterialIcons'),
                      size: 64,
                      color: ColorDefines.primaryGray,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "저장된 레포트가 없어요.\nAI 레포트를 저장해보세요!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorDefines.primaryGray
                      ),
                    ),
                  ],
                ),
              )
                  : _aiReportListWidget(
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
                  }
              ),
            ),
          ],
        ),
        _circularLoading(state: state)
      ],
    );
  }

  Widget _circularLoading({required MyAiReportState state}) {
    return Visibility(
        visible: state.isLoading,
        child: Center(child: CircularProgressIndicator(color: ColorDefines.mainColor,),)
    );
  }

  Widget _aiReportTitle({required Function() onClickBack}) {
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
                  "저장된 레포트",
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

  Widget _aiReportListWidget({
    required MyAiReportState state,
    required Function(String) onClickAiReport
  }) {
    final aiReports = state.getAiReportResponse?.data.aiReports ?? [];

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: ListView.builder(
            itemCount: aiReports.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  onClickAiReport(aiReports[index].id);
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
                    "${FormatDefines.formOptionFormat(option: aiReports[index].data.selectOption)}의 분석 레포트",
                    style: TextStyle(
                        color: ColorDefines.mainColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              );
            }
        ),
    );
  }

}