import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_and_travel/bloc/auth/auth_bloc.dart';
import 'package:tour_and_travel/bloc/page_bloc.dart';
import 'package:tour_and_travel/core/assets.gen.dart';
import 'package:tour_and_travel/core/build_context_ext.dart';
import 'package:tour_and_travel/core/colors.dart';
import 'package:tour_and_travel/models/register_request.dart';
import 'package:tour_and_travel/pages/login_page.dart';
import 'package:tour_and_travel/services/auth_service.dart';
import 'package:tour_and_travel/widgets/custom_text_field.dart';
import 'package:tour_and_travel/widgets/dotted_divider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    final user = await AuthService().getUserFromLocal();
    nameController.text = user?.data?.name ?? '';
    emailController.text = user?.data?.email ?? '';
    phoneNumberController.text = user?.data?.phone ?? '';
    passwordController.text = '';
    confirmPasswordController.text = '';
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        children: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                return ListTile(
                  tileColor: AppColors.white,
                  title: Text(state.data.name!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.data.email!),
                      Text(state.data.phone!),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.gray),
              borderRadius: BorderRadius.circular(12.0),
              color: AppColors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Assets.icTask.image(width: 24.0),
                    const SizedBox(width: 16.0),
                    const Text(
                      'Ubah Data Diri',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const DottedDivider(),
                const SizedBox(height: 16.0),
                CustomTextField(
                  controller: nameController,
                  label: 'Nama',
                  hintText: 'contoh: Yoshrizal Fadli',
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
                const SizedBox(height: 16.0),
                // CustomTextField(
                //   controller: passwordController,
                //   label: 'Password',
                //   hintText: 'Masukkan passwordmu',
                //   textInputAction: TextInputAction.next,
                //   obscureText: true,
                // ),
                // const SizedBox(height: 16.0),
                // CustomTextField(
                //   controller: confirmPasswordController,
                //   label: 'Konfirmasi Password',
                //   hintText: 'Masukkan ulang passwordmu',
                //   obscureText: true,
                // ),
                // const SizedBox(height: 16.0),
                const Divider(),
                const SizedBox(height: 16.0),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) async {
                    if (state is AuthSuccess) {
                      context.showDialogSuccess('Profil berhasil diperbarui');
                      // final logout = await AuthService().clearStorageAuth();
                      // if (logout && context.mounted) {
                      //   context.pushAndRemoveUntil(
                      //       const LoginPage(), (route) => false);
                      // }
                      context.read<PageBloc>().add(0);
                    } else if (state is AuthFailed) {
                      context.showDialogError(state.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const SizedBox(
                        height: 60.0,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () async {
                        final user = await AuthService().getUserFromLocal();
                        final request = RegisterRequest(
                          id: user?.data?.id,
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneNumberController.text,
                          password: passwordController.text,
                          confPassword: confirmPasswordController.text,
                        );
                        if (context.mounted) {
                          context
                              .read<AuthBloc>()
                              .add(EditProfileEvent(request));
                        }
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
                              'Simpan',
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
        ],
      ),
      bottomNavigationBar: ColoredBox(
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () async {
              final logout = await AuthService().clearStorageAuth();
              if (logout && context.mounted) {
                context.showDialogSuccess('Berhasil logout');
                context.pushAndRemoveUntil(const LoginPage(), (route) => false);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
            child: SizedBox(
              width: context.deviceWidth,
              height: 54.0,
              child: const Center(
                child: Text(
                  'Keluar',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
