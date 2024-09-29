import 'package:chuck2wiz/data/blocs/main/ai/ai_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/ai/ai_state.dart';
import 'package:chuck2wiz/ui/util/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

class AiPage extends BasePage<AiBloc, AiState> {
  @override
  Widget buildContent(BuildContext context, AiState state) {
    return const Center(child: Text("AI"),);
  }

  @override
  AiBloc createBloc(BuildContext context) => AiBloc(AiInitial());
  
}