import 'package:evently_app/core/config/theme/theme_manager.dart';
import 'package:evently_app/core/utils/prefs_manager.dart';
import 'package:evently_app/core/utils/routes_manager.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_bloc.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_event.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_state.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:evently_app/core/di/injection_container.dart' as di;

import 'features/home/tabs/profile_tab/view_model/profile_bloc.dart';
import 'features/home/tabs/profile_tab/view_model/profile_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PrefsManager.init();
  await di.init();
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<ProfileBloc>()),
        BlocProvider(
          create: (_) => di.sl<AuthBloc>()..add(AuthCheckRequested()),
        ),
      ],
      child: const Evently(),
    ),
  );
}

class Evently extends StatefulWidget {
  const Evently({super.key});

  @override
  State<Evently> createState() => _EventlyState();
}

class _EventlyState extends State<Evently> {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, _) {
        return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, configState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: context.read<AuthBloc>().state is AuthSuccess
                  ? RoutesManager.homeScreen
                  : RoutesManager.login,
              onGenerateRoute: RoutesManager.router,
              theme: ThemeManager.light,
              darkTheme: ThemeManager.dark,
              themeMode: configState.themeMode,
              localizationsDelegates:
                  AppLocalizations.localizationsDelegates,
              supportedLocales: const [Locale('en'), Locale('ar')],
              locale: Locale(configState.language),
            );
          },
        );
      },
    );
  }
}
