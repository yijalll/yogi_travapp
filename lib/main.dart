import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tour_and_travel/bloc/auth/auth_bloc.dart';
import 'package:tour_and_travel/bloc/get_tickets/get_tickets_bloc.dart';
import 'package:tour_and_travel/bloc/page_bloc.dart';
import 'package:tour_and_travel/bloc/register/register_bloc.dart';
import 'package:tour_and_travel/bloc/send_package/send_package_bloc.dart';
import 'package:tour_and_travel/bloc/transaction/transaction_bloc.dart';
import 'package:tour_and_travel/core/colors.dart';
import 'package:tour_and_travel/pages/splash_page.dart';
import 'package:tour_and_travel/services/auth_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tour_and_travel/services/package_service.dart';
import 'package:tour_and_travel/services/transaction_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  await initializeDateFormatting('id_ID', null);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PageBloc>(create: (context) => PageBloc()),
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(AuthService())),
        BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(AuthService())),
        BlocProvider<GetTicketsBloc>(
            create: (context) => GetTicketsBloc(TransactionService())),
        BlocProvider<TransactionBloc>(
            create: (context) => TransactionBloc(TransactionService())),
        BlocProvider<SendPackageBloc>(
            create: (context) => SendPackageBloc(PackageService())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Yogi Tour & Travel',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          dividerTheme: DividerThemeData(color: AppColors.gray),
          scaffoldBackgroundColor: AppColors.white,
          useMaterial3: true,
          textTheme: GoogleFonts.rubikTextTheme(
            Theme.of(context).textTheme,
          ),
          listTileTheme: const ListTileThemeData(
            horizontalTitleGap: 12.0,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              fontSize: 16.0,
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.white,
            titleTextStyle: GoogleFonts.rubik(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
            shape: Border(
              bottom: BorderSide(color: AppColors.gray, width: 1),
            ),
          ),
        ),
        home: const SplashPage(),
      ),
    );
  }
}
