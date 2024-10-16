import 'dart:io';

import 'package:chuck2wiz/data/blocs/main/ai/ai_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/community/community_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/community/read/community_read_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/community/write/community_write_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/main_bloc.dart';
import 'package:chuck2wiz/data/blocs/main/mypage/my_bloc.dart';
import 'package:chuck2wiz/data/repository/ai/form_repository.dart';
import 'package:chuck2wiz/data/repository/article/article_repository.dart';
import 'package:chuck2wiz/ui/pages/login_page.dart';
import 'package:chuck2wiz/ui/pages/main/community/write/community_write_page.dart';
import 'package:chuck2wiz/ui/pages/main/main_page.dart';
import 'package:chuck2wiz/ui/pages/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/repository/auth/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/config/.env');
  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: dotenv.env['KAKAO_NATIVE_KEY'],
    javaScriptAppKey: dotenv.env['KAKAO_JAVA_SCRIPT_KEY'],
  );

  HttpOverrides.global = NoCheckCertificateHttpOverrides(); // 생성된 HttpOverrides 객체 등록

  SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: [
        SystemUiOverlay.top,
        SystemUiOverlay.bottom,
      ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      // Set your desired color here
      statusBarIconBrightness: Brightness.dark,
      // Use Brightness.dark for dark text and icons
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    TargetPlatform? platform;
    if (kIsWeb) {
    } else {
      platform = Platform.isIOS ? TargetPlatform.iOS : TargetPlatform.android;
      if (Platform.isIOS) {
        platform = TargetPlatform.iOS;
      } else if (Platform.isAndroid) {
        platform = TargetPlatform.android;
      }
    }

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      getPages: [
        GetPage(
          name: '/login',
          page: () => const LoginPage(),
        ),
        GetPage(
            name: '/signUp',
            page: () => const SignUpPage(),
        ),
        GetPage(
          name: '/main',
          page: () => MultiBlocProvider(
            providers: [
              BlocProvider<MainBloc>(
                create: (context) => MainBloc(),
              ),
              BlocProvider<CommunityBloc>(
                create: (context) => CommunityBloc(),
              ),
              BlocProvider<CommunityWriteBloc>(
                create: (context) => CommunityWriteBloc(UserRepository(), ArticleRepository()),
              ),
              BlocProvider<MyBloc>(
                  create: (context) => MyBloc(),
              )
            ],
            child: const MainPage(),
          ),
        ),
      ],
    );
  }
}

// https 인증서 무시.
class NoCheckCertificateHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
