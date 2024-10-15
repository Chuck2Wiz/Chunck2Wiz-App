import 'package:chuck2wiz/data/blocs/main/mypage/my_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/mypage/my_event.dart';
import 'package:chuck2wiz/data/blocs/main/mypage/my_state.dart';
import 'package:chuck2wiz/ui/define/color_defines.dart';
import 'package:chuck2wiz/ui/pages/login_page.dart';
import 'package:chuck2wiz/ui/util/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chuck2wiz/ui/widget/set_account_dialog_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyPage extends BasePage<MyBloc, MyState> {
  const MyPage({super.key}): super(keepBlocAlive: true);
  
  @override
  MyBloc createBloc(BuildContext context) {
    return context.read<MyBloc>();
  }

  @override
  void onInit(BuildContext context, MyBloc bloc) {
    if(!bloc.isClosed) {
      bloc.add(GetUserInfoEvent());
    }
  }


  @override
  void onBlockListener(BuildContext context, MyState state) {
    if(state is SuccessDelete) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false
      );
    }
  }

  @override
  Widget buildContent(BuildContext context, MyState state) {
    return Stack(
      children: [
        Visibility(
            visible: state.isLoading == false,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('마이페이지'),
                centerTitle: true,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
              ),
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  _buildHeader(state),
                  Divider(color: Colors.grey, thickness: 1.0),
                  _buildSectionTitle('커뮤니티'),
                  ..._buildCommunityMenuItems(
                      context: context,
                      onClickMyPost: () {

                      },
                      onClickSavaReport: () {

                      }
                  ),
                  _buildSectionTitle('기타 설정'),
                  ..._buildSettingsMenuItems(
                      context: context,
                      onClickLogout: () {},
                      onClickDelete: () {
                        context.read<MyBloc>().add(DeleteAccount());
                      }
                  ),
                ],
              ),
            )
        ),
        _circularLoading(state: state)
      ],
    );
  }

  Widget _circularLoading({required MyState state}) {
    return Visibility(
        visible: state.isLoading == true,
        child: const Center(child: CircularProgressIndicator(color: ColorDefines.mainColor,),)
    );
  }

  Widget _buildHeader(MyState state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/ic_profile.png'),
            radius: 22,
            backgroundColor: ColorDefines.primaryWhite,
          ),
          const SizedBox(width: 16),
          Text(
            state.getUserInfoResponse?.data.nick ?? "",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCommunityMenuItems({
    required BuildContext context,
    required Function() onClickMyPost,
    required Function() onClickSavaReport
  }) {
    return [
      _buildMenuItem(
        iconPath: 'assets/images/ic_write.png',
        text: '작성한 글',
        onTap: onClickMyPost
      ),
      _buildMenuItem(
        iconPath: 'assets/images/ic_folder.png',
        text: '저장된 리포트',
        onTap: onClickSavaReport
      ),
    ];
  }

  List<Widget> _buildSettingsMenuItems({
    required BuildContext context,
    required Function() onClickLogout,
    required Function() onClickDelete
  }) {
    return [
    _buildMenuItem(
      iconPath: 'assets/images/ic_logout.png',
      text: '로그아웃',
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return buildLogoutConfirmationDialog(
                context: context,
                onClickLogout: onClickLogout
            );
          },
        );
      },
    ),
    _buildMenuItem(
      iconPath: 'assets/images/ic_delete_account.png',
      text: '회원탈퇴',
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return buildDeleteAccountConfirmationDialog(
                context: context,
                onClickDelete: onClickDelete
            );
          },
        );
        },
      ),
    ];
  }

  Widget _buildMenuItem({required String text, required VoidCallback onTap, required String iconPath}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 30),
      leading: Image.asset(iconPath, width: 24, height: 24),
      title: Text(text, style: TextStyle(fontSize: 16, color: ColorDefines.primaryBlack, fontWeight: FontWeight.bold)),
      onTap: onTap,
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(fontSize: 16, color: ColorDefines.primaryGray, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

}