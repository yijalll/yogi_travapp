import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_and_travel/bloc/register/register_bloc.dart';
import 'package:tour_and_travel/core/build_context_ext.dart';
import 'package:tour_and_travel/core/colors.dart';
import 'package:tour_and_travel/models/register_request.dart';
import 'package:tour_and_travel/widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final alamatController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Text(
              'Registrasi',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24.0),
            CustomTextField(
              controller: nameController,
              label: 'Nama',
              hintText: 'Nama Lengkap',
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: emailController,
              label: 'Alamat Email',
              hintText: 'contoh: example@gmail.com',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: phoneNumberController,
              label: 'No Telepone',
              hintText: 'contoh: 081212345678',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
            CustomTextField(
              controller: alamatController,
              label: 'Alamat',
              hintText: 'contoh: Kebun Jeruk',
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: passwordController,
              label: 'Password',
              hintText: 'Masukkan passwordmu',
              textInputAction: TextInputAction.next,
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: confirmPasswordController,
              label: 'Konfirmasi Password',
              hintText: 'Masukkan ulang passwordmu',
              obscureText: true,
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                context.pop();
                context.showDialogSuccess(
                    state.data.message ?? 'Registrasi berhasil');
              } else if (state is RegisterFailed) {
                context.showDialogError(state.message);
              }
            },
            builder: (context, state) {
              if (state is RegisterLoading) {
                return const SizedBox(
                  height: 60.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return ElevatedButton(
                onPressed: () {
                  final request = RegisterRequest(
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneNumberController.text,
                    alamat: alamatController.text,
                    password: passwordController.text,
                    confPassword: confirmPasswordController.text,
                  );
                  context.read<RegisterBloc>().add(DoRegisterEvent(request));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: SizedBox(
                  width: context.deviceWidth,
                  height: 54.0,
                  child: const Center(
                    child: Text(
                      'Registrasi',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
