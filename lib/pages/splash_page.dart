import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_and_travel/bloc/auth/auth_bloc.dart';
import 'package:tour_and_travel/core/build_context_ext.dart';
import 'package:tour_and_travel/core/colors.dart';
import 'package:tour_and_travel/pages/login_page.dart';
import 'package:tour_and_travel/pages/main_page.dart';
import 'package:tour_and_travel/services/auth_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () => init(),
    );
    super.initState();
  }

  void init() async {
    try {
      final userData = await AuthService().getUser();
      if (mounted) {
        if (userData.data != null) {
          context.read<AuthBloc>().add(GetAuthEvent(userData.data!));
          context.pushReplacement(const MainPage());
        } else {
          context.pushReplacement(const LoginPage());
        }
      }
    } catch (e) {
      if (mounted) {
        context.pushReplacement(const LoginPage());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Text(
            'Yogi Tour \n& Travel',
            style: TextStyle(
              fontSize: 48.0,
              color: AppColors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
