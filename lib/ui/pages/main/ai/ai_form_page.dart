import 'package:chuck2wiz/data/blocs/main/ai/ai_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/ai/ai_event.dart';
import 'package:chuck2wiz/data/blocs/main/ai/ai_state.dart';
import 'package:chuck2wiz/data/blocs/main/ai/form/ai_form_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/ai/form/ai_form_event.dart';
import 'package:chuck2wiz/data/blocs/main/ai/form/ai_form_state.dart';
import 'package:chuck2wiz/data/blocs/main/ai/report/ai_report_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/ai/report/ai_report_event.dart';
import 'package:chuck2wiz/data/db/shared_preferences_helper.dart';
import 'package:chuck2wiz/ui/define/format_defines.dart';
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

  List<String>? answerData;

  @override
  void onInit(BuildContext context, AiFormBloc bloc) {
    if (!bloc.isClosed) {
      bloc.add(GetAiFormDataEvent());
    }
  }

  @override
  Widget buildContent(BuildContext context, AiFormState state) {
    if(answerData == null && state.formData?[0].questions != null) {
      final formData = state.formData?[0].questions ?? [];
      answerData = List<String>.filled(formData.length, '');
    }
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
                      FormatDefines.formOptionFormat(option: state.selectOption ?? ""),
                      style: FontDefines.black18Bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
                child: Visibility(
                    visible: (answerData != null && state.formData != null),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: _formWidget(state: state),
                    )
                )
            ),
            GestureDetector(
              onTap: () {
                if(state.isCompleteAnswer) {
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
                }
              },
              child: Container(
                  width: double.infinity,
                  margin:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: state.isCompleteAnswer ? ColorDefines.mainColor : ColorDefines.primaryGray,
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

  Widget _formWidget({required AiFormState state}) {
    final formData = state.formData?[0].questions ?? [];

    if (state.formData == null || state.formData!.isEmpty || answerData == null) {
      return Container();
    }

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
                      context.read<AiFormBloc>()
                          .add(CheckAnswerValidationEvent(isValid: _validAnswerData(validData: answerData)));
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

  bool _validAnswerData({required List<String>? validData}) {
    if(validData == null) {
      return false;
    }

    for(var data in validData) {
      if(data.isEmpty) {
        return false;
      }
    }
    return true;
  }

}