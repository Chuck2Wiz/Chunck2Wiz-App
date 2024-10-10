import 'package:chuck2wiz/data/blocs/main/mypage/my_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/mypage/my_state.dart';
import 'package:chuck2wiz/ui/define/color_defines.dart';
import 'package:chuck2wiz/ui/util/base_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chuck2wiz/ui/widget/set_account_dialog_widget.dart';

class MyPage extends BasePage<MyBloc, MyState> {
  @override
  Widget buildContent(BuildContext context, MyState state) {
    return Scaffold(
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
          ..._buildCommunityMenuItems(context),
          _buildSectionTitle('기타 설정'),
          ..._buildSettingsMenuItems(context),
        ],
      ),
    );
  }

  Widget _buildHeader(MyState state) {
    final String nickname = state is MyProfile ? state.nick : "닉네임";
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
            nickname,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCommunityMenuItems(BuildContext context) {
    return [
      _buildMenuItem(
        iconPath: 'assets/images/ic_write.png',
        text: '작성한 글',
        onTap: () {
          // 보관함으로 이동
        },
      ),
      _buildMenuItem(
        iconPath: 'assets/images/ic_folder.png',
        text: '저장된 리포트',
        onTap: () {
          // 리포트로 이동
        },
      ),
    ];
  }

  List<Widget> _buildSettingsMenuItems(BuildContext context) {
    return [
    _buildMenuItem(
      iconPath: 'assets/images/ic_logout.png',
      text: '로그아웃',
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => buildLogoutConfirmationDialog(context),
        );
      },
    ),
    _buildMenuItem(
      iconPath: 'assets/images/ic_delete_account.png',
      text: '회원탈퇴',
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => buildDeleteAccountConfirmationDialog(context),
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

  @override
  MyBloc createBloc(BuildContext context) => MyBloc(MyInitial());

}