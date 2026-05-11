import 'package:evently_app/core/ui_utils/dialog_utils.dart';
import 'package:evently_app/core/utils/routes_manager.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_bloc.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_state.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evently_app/features/home/tabs/favourite_tab/views/favourite_tab.dart';
import 'package:evently_app/features/home/tabs/home_tab/views/home_tab.dart';
import 'package:evently_app/features/home/tabs/profile_tab/views/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AppLocalizations appLocalizations;

  List<Widget> tabs = [const HomeTab(), const FavouriteTab(), const ProfileTab()];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context)!;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          DialogUtils.showLoading(context, dismissible: false);
        } else if (state is AuthInitial) {
          DialogUtils.hideDialog(context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesManager.login,
            (route) => false,
          );
        } else if (state is AuthError) {
          DialogUtils.hideDialog(context);
          DialogUtils.showToastMessage(
            message: state.message,
            bgColor: Colors.red,
          );
        }
      },
      child: Scaffold(
        extendBody: true,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RoutesManager.createEvent);
          },
          child: const Icon(Icons.add),
        ),
        body: tabs[currentIndex],
        bottomNavigationBar: _buildBottomNavBar(),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: _onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 0 ? Icons.home_filled : Icons.home_outlined,
          ),
          label: appLocalizations.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 1 ? Icons.favorite : Icons.favorite_border,
          ),
          label: appLocalizations.favourite,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            currentIndex == 2 ? Icons.person : Icons.person_2_outlined,
          ),
          label: appLocalizations.profile,
        ),
      ],
    );
  }

  void _onTap(int newIndex) {
    setState(() {
      currentIndex = newIndex;
    });
  }
}
