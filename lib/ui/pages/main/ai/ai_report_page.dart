import 'package:chuck2wiz/data/blocs/main/ai/report/ai_report_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/ai/report/ai_report_state.dart';
import 'package:chuck2wiz/data/db/shared_preferences_helper.dart';
import 'package:chuck2wiz/main.dart';
import 'package:chuck2wiz/ui/util/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiReportPage extends BasePage<AiReportBloc, AiReportState> {
  const AiReportPage({super.key});

  @override
  AiReportBloc createBloc(BuildContext context) {
    return context.read<AiReportBloc>();
  }

  @override
  Widget buildContent(BuildContext context, AiReportState state) {
    print("상태값:  ${state.formData?[0].questions} ${state.answerData?[0]}");

    return Container();
  }

}