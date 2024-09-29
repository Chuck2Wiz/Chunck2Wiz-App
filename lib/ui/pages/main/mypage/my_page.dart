import 'package:chuck2wiz/data/blocs/main/mypage/my_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/mypage/my_state.dart';
import 'package:chuck2wiz/ui/util/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyPage extends BasePage<MyBloc, MyState> {
  @override
  Widget buildContent(BuildContext context, MyState state) {
    return Center(child: Text("MyPage"),);
  }

  @override
  MyBloc createBloc(BuildContext context) => MyBloc(MyInitial());

}