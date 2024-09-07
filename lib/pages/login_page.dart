import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/kakao/kakao_login_bloc.dart';
import '../blocs/kakao/kakao_login_event.dart';
import '../blocs/kakao/kakao_login_state.dart';
import 'signup_page.dart'; // Ensure this path is correct

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KakaoLoginBloc(),
      child: LoginForm(),
    );
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5D71BF),
      body: BlocListener<KakaoLoginBloc, KakaoLoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignupPage()),
            );
          }
        },
        child: BlocBuilder<KakaoLoginBloc, KakaoLoginState>(
          builder: (context, state) {
            if (state is LoginLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                SizedBox(height: 50),
                OutlinedButton.icon(
                  icon: Image.asset('assets/images/kakao_logo.png', width: 24),
                  label: Text(
                    '카카오로 시작하기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    minimumSize: Size(double.infinity, 50),
                    side: BorderSide(color: Colors.yellow),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onPressed: () {
                    context.read<KakaoLoginBloc>().add(LoginWithKakao());
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
