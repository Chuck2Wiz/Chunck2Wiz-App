import 'package:chuck2wiz/data/blocs/main/ai/ai_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/ai/ai_event.dart';
import 'package:chuck2wiz/data/blocs/main/ai/ai_state.dart';
import 'package:chuck2wiz/data/blocs/main/ai/form/ai_form_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/ai/form/ai_form_event.dart';
import 'package:chuck2wiz/data/repository/ai/form_repository.dart';
import 'package:chuck2wiz/data/server/response/form/get_form_response.dart';
import 'package:chuck2wiz/main.dart';
import 'package:chuck2wiz/ui/pages/main/ai/ai_form_page.dart';
import 'package:chuck2wiz/ui/util/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../define/color_defines.dart';
import '../../../define/font_defines.dart';

class AiPage extends BasePage<AiBloc, AiState> {
  const AiPage({super.key}) : super(keepBlocAlive: true);

  @override
  AiBloc createBloc(BuildContext context) => context.read<AiBloc>();

  @override
  void onInit(BuildContext context, AiBloc bloc) {
    if (!bloc.isClosed) {
      bloc.add(GetFormOptionsEvent());
    }
  }

  @override
  void onBlockListener(BuildContext context, AiState state) {}

  @override
  Widget buildContent(BuildContext context, AiState state) {
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "법률분쟁을 선택해주세요",
                          style: FontDefines.black18Bold,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "(최대 1개 선택 가능)",
                          style: FontDefines.gray12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _optionsGridWidget(
                state: state,
                onClickOption: (value) {
                  if (value != null) {
                    context.read<AiBloc>().add(SelectOptionEvent(selectOption: value));
                  }
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                if(state.selectOption != null && state.selectOption != "") {
                  final aiFormBloc = AiFormBloc(FormRepository());
                  Navigator.pushReplacement(context, PageRouteBuilder(
                      pageBuilder: (newContext, animation, secondaryAnimation) {
                        aiFormBloc.add(AiFormSelectOptionEvent(selectOption: state.selectOption ?? ""));
                        return BlocProvider.value(
                            value: aiFormBloc,
                            child: AiFormPage()
                        );
                      }));
                }
              },
              child: Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: state.selectOption == null ? ColorDefines.primaryGray : ColorDefines.mainColor,
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

  Widget _circularLoading({required AiState state}) {
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

  Widget _optionsGridWidget({
    required AiState state,
    required Function(String?) onClickOption,
  }) {
    String? clickOption;
    List<ResponseForm> items = state.formOptions ?? [];

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 12,
                mainAxisExtent: 40),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final bool selectOption =
                  items[index].option == state.selectOption;

              return GestureDetector(
                onTap: () {
                  onClickOption(items[index].option);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color:
                          selectOption ? ColorDefines.mainColor : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: ColorDefines.mainColor, width: 0.5)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      _formatOption(items[index].option),
                      style: selectOption
                          ? const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold)
                          : const TextStyle(
                              color: ColorDefines.mainColor,
                              fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            }));
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
}
