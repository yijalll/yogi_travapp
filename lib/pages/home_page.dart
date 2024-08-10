import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tour_and_travel/bloc/auth/auth_bloc.dart';
import 'package:tour_and_travel/core/assets.gen.dart';
import 'package:tour_and_travel/core/build_context_ext.dart';
import 'package:tour_and_travel/core/colors.dart';
import 'package:tour_and_travel/pages/send_package_page.dart';
import 'package:tour_and_travel/pages/ticket_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              ColoredBox(
                color: AppColors.primary,
                child: SizedBox(
                  width: context.deviceWidth,
                  height: 210.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        String name = '-';
                        if (state is AuthSuccess) {
                          name = state.data.name!;
                        }
                        return Text(
                          'Hi, $name',
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                    const Text(
                      'Selamat datang di Yogi Tour & Travel',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Assets.banner.image(),
                    ),
                    const SizedBox(height: 24.0),
                    const Text(
                      'Semua Layanan',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ListTile(
                      onTap: () {
                        context.push(const TicketListPage());
                      },
                      leading: Assets.pesanTiketCircle.image(),
                      title: const Text('Pesan Tiket'),
                      subtitle: const Text(
                          'Platform pemesanan tiket online tour & travel'),
                    ),
                    const SizedBox(height: 16.0),
                    ListTile(
                      onTap: () {
                        context.push(const SendPackagePage());
                      },
                      leading: Assets.kirimPaketCircle.image(),
                      title: const Text('Kirim Paket'),
                      subtitle:
                          const Text('Mengirim paket kapanpun dan kemanapun'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
