import 'package:chuck2wiz/data/blocs/main/home/home_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/home/home_state.dart';
import 'package:chuck2wiz/ui/util/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends BasePage<HomeBloc, HomeState> {
  @override
  HomeBloc createBloc(BuildContext context) => HomeBloc(HomeInitial());

  @override
  Widget buildContent(BuildContext context, HomeState state) {
    return Center(child: Text("Home"),);
  }
}