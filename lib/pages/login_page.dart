import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_and_travel/bloc/auth/auth_bloc.dart';
import 'package:tour_and_travel/core/build_context_ext.dart';
import 'package:tour_and_travel/core/colors.dart';
import 'package:tour_and_travel/models/login_request.dart';
import 'package:tour_and_travel/pages/main_page.dart';
import 'package:tour_and_travel/pages/register_page.dart';
import 'package:tour_and_travel/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Text(
              'Log in',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24.0),
            CustomTextField(
              controller: emailController,
              label: 'Email',
              hintText: 'Masukkan emailmu',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: passwordController,
              label: 'Password',
              hintText: 'Masukkan passwordmu',
              obscureText: true,
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedButton(
                onPressed: () {
                  context.push(const RegisterPage());
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: SizedBox(
                  width: context.deviceWidth,
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        'Registrasi',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    context.pushReplacement(const MainPage());
                  } else if (state is AuthFailed) {
                    context.showDialogError(state.message);
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      final request = LoginRequest(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      context.read<AuthBloc>().add(LoginEvent(request));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    child: SizedBox(
                      width: context.deviceWidth,
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
