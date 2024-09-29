import 'package:bloc/bloc.dart';
import 'package:chuck2wiz/data/blocs/main/community/community_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/community/community_event.dart';
import 'package:chuck2wiz/data/blocs/main/community/community_state.dart';
import 'package:chuck2wiz/ui/util/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

class CommunityPage extends BasePage<CommunityBloc, CommunityState> {
  @override
  Widget buildContent(BuildContext context, CommunityState state) {
    return Center(child: Text("Community"),);
  }

  @override
  CommunityBloc createBloc(BuildContext context) => CommunityBloc(CommunityInitial());
}