import 'package:chuck2wiz/data/blocs/main/ai/ai_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/ai/ai_event.dart';
import 'package:chuck2wiz/data/blocs/main/ai/ai_state.dart';
import 'package:chuck2wiz/data/blocs/main/ai/form/ai_form_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/ai/form/ai_form_event.dart';
import 'package:chuck2wiz/data/blocs/main/ai/form/ai_form_state.dart';
import 'package:chuck2wiz/data/blocs/main/ai/report/ai_report_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/ai/report/ai_report_event.dart';
import 'package:chuck2wiz/data/db/shared_preferences_helper.dart';
import 'package:chuck2wiz/ui/pages/main/ai/ai_report_page.dart';
import 'package:chuck2wiz/ui/util/base_page.dart';
import 'package:chuck2wiz/ui/widget/textField/base_text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../define/color_defines.dart';
import '../../../define/font_defines.dart';

class AiFormPage extends BasePage<AiFormBloc, AiFormState> {
  AiFormPage({super.key}): super(keepBlocAlive: true);

  @override
  AiFormBloc createBloc(BuildContext context) => context.read<AiFormBloc>();

  @override
  void onInit(BuildContext context, AiFormBloc bloc) {
    if (!bloc.isClosed) {
      bloc.add(GetAiFormDataEvent());
    }
  }

  List<String>? answerData;

  @override
  Widget buildContent(BuildContext context, AiFormState state) {
    return Stack(
      children: [
        _circularLoading(state: state),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
              child: Stack(
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
                      _formatOption(state.selectOption ?? ""),
                      style: FontDefines.black18Bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: _formWidget(state: state),
                )
            ),
            GestureDetector(
              onTap: () {
                print("탭전 상태: ${state}");
                SharedPreferencesHelper.saveAnswerData(answerData ?? []);

                final reportBloc = AiReportBloc();
                reportBloc.add(GetInitData(
                    formData: state.formData,
                    selectOption: state.selectOption
                ));

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (newContext) => BlocProvider.value(
                          value: reportBloc,
                          child: AiReportPage(),
                        )
                    )
                );
              },
              child: Container(
                  width: double.infinity,
                  margin:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: ColorDefines.mainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "다음",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            )
          ],
        ),
      ],
    );
  }

  Widget _circularLoading({required AiFormState state}) {
    return Visibility(
        visible: state.isLoading,
        child: const Center(
          child: CircularProgressIndicator(
            color: ColorDefines.mainColor,
          ),
        ));
  }

  Widget _backButtonWidget({required Function() onClickBackButton}) {
    return IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          size: 24,
        ),
        onPressed: onClickBackButton);
  }

  String _formatOption(String option) {
    final result = switch (option) {
      "TRAFFIC_ACCIDENT" => "교통사고",
      "DEFAMATION" => "명예훼손",
      "RENTAL" => "임대차",
      "DIVORCE" => "이혼",
      "ASSAULT" => "폭행",
      "FRAUD" => "사기",
      "SEX_CRIME" => "성범죄",
      "COPYRIGHT" => "저작권",
      _ => ""
    };

    return result;
  }

  Widget _formWidget({required AiFormState state}) {
    final formData = state.formData?[0].questions ?? [];
    answerData = List<String>.filled(formData.length, '');

    return ListView.builder(
        itemCount: formData.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "${index+1}. ${formData[index]}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
              ),
              const SizedBox(height: 8,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorDefines.primaryGray,
                    width: 0.5
                  ),
                ),
                child: BaseTextFieldWidget(
                    hint: "내용을 입력해주세요.",
                    onChange: (value) {
                      answerData?[index] = value;
                    },
                ),
              ),
              if(index != formData.length-1)
                const SizedBox(height: 12,)
            ],
          );
        }
    );
  }

}