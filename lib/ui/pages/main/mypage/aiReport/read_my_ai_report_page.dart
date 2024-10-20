import 'package:chuck2wiz/data/blocs/main/ai/report/ai_report_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/ai/report/read/read_ai_report_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/ai/report/read/read_ai_report_state.dart';
import 'package:chuck2wiz/main.dart';
import 'package:chuck2wiz/ui/define/format_defines.dart';
import 'package:chuck2wiz/ui/util/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../define/color_defines.dart';

class ReadMyAiReportPage extends BasePage<ReadAiReportBloc, ReadAiReportState> {
  const ReadMyAiReportPage({super.key}) : super(keepBlocAlive: true);

  @override
  ReadAiReportBloc createBloc(BuildContext context) {
    return context.read<ReadAiReportBloc>();
  }

  @override
  Widget buildContent(BuildContext context, ReadAiReportState state) {
    return Stack(
      children: [
        Visibility(
            visible: state.getReadAiReportResponse != null,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _aiReportTitle(
                      state: state,
                      onClickBack: () {
                        Navigator.pop(context);
                      }),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "질문 내역",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorDefines.mainColor
                            ),
                          ),
                          const SizedBox(height: 8,),
                          _reportWidget(state: state),
                          const SizedBox(
                            height: 24,
                          ),
                          const Text(
                            "분석 내용",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ColorDefines.mainColor
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          _aiAnswerWidget(
                              aiAnswer: state.getReadAiReportResponse?.data.aiReport.data
                                  .reportValue ??
                                  "")
                        ],
                      ),
                  )
                ],
              ),
            )
        ),
        _circularLoading(state: state)
      ],
    );
  }

  Widget _circularLoading({required ReadAiReportState state}) {
    return Visibility(
        visible: state.isLoading,
        child: Center(
          child: CircularProgressIndicator(
            color: ColorDefines.mainColor,
          ),
        ));
  }

  Widget _aiReportTitle({required Function() onClickBack, required ReadAiReportState state}) {
    final selectOption = FormatDefines.formOptionFormat(option: state.getReadAiReportResponse?.data.aiReport.data.selectOption ?? "");

    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            child: IconButton(
                onPressed: onClickBack,
                icon: const Icon(Icons.arrow_back_ios, size: 24)),
          ),
          Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(top: 16),
                child: Text(
                  "$selectOption의 분석 레포트",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ))
        ],
      ),
    );
  }

  Widget _reportWidget({required ReadAiReportState state}) {
    final aiReport = state.getReadAiReportResponse?.data.aiReport;
    final formData = aiReport?.data.formData;
    final answerData = aiReport?.data.answerData;

    if (formData == null || answerData == null) {
      return Container();
    }

    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: formData.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${index + 1}. ${formData[index]}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: ColorDefines.primaryGray, width: 0.5),
                ),
                child: Text(answerData[index]),
              ),
              if (index != formData.length - 1)
                const SizedBox(
                  height: 12,
                )
            ],
          );
        });
  }

  Widget _aiAnswerWidget({required String aiAnswer}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ColorDefines.mainColor, width: 1),
          borderRadius: BorderRadius.circular(15)),
      child: Text(
        aiAnswer,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
