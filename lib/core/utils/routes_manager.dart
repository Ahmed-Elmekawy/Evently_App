import 'package:evently_app/features/auth/views/login/login_screen.dart';
import 'package:evently_app/features/auth/views/register/register_screen.dart';
import 'package:evently_app/features/create_event/create_event.dart';
import 'package:evently_app/features/event_details/views/screens/edit_event_screen.dart';
import 'package:evently_app/features/event_details/views/screens/event_details_screen.dart';
import 'package:evently_app/features/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evently_app/core/di/injection_container.dart';
import 'package:evently_app/features/create_event/view_model/bloc/create_event_bloc.dart';
import 'package:evently_app/features/event_details/view_model/bloc/event_details_bloc.dart';
import '../../features/home/tabs/favourite_tab/view_model/bloc/favourite_bloc.dart';
import '../../features/home/tabs/home_tab/view_model/bloc/home_bloc.dart';

class RoutesManager {
  static const String login = '/login';
  static const String register = '/register';
  static const String homeScreen = '/homeScreen';
  static const String createEvent = '/createEvent';
  static const String eventDetails = '/eventDetails';
  static const String editEvent = '/editEvent';

  static Route? router(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return CupertinoPageRoute(builder: (_) => const LoginScreen());
      case register:
        return CupertinoPageRoute(builder: (_) => const RegisterScreen());
      case homeScreen:
        return CupertinoPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => sl<HomeBloc>()),
              BlocProvider(create: (_) => sl<FavouriteBloc>()),
            ],
            child: const HomeScreen(),
          ),
        );
      case createEvent:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => sl<CreateEventBloc>(),
            child: const CreateEvent(),
          ),
        );
      case eventDetails:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => sl<EventDetailsBloc>(),
            child: const EventDetailsScreen()
          ),
          settings: settings,
        );
      case editEvent:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => sl<EventDetailsBloc>(),
            child: const EditEventScreen(),
          ),
          settings: settings,
        );
    }
    return null;
  }
}
