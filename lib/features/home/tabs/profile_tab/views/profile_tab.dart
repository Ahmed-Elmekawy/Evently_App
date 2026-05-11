import 'package:evently_app/features/auth/view_model/bloc/auth_bloc.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/language_dropdown.dart';
import 'widgets/logout_button.dart';
import 'widgets/profile_header.dart';
import 'widgets/theme_switch.dart';


class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => current is AuthSuccess,
      builder: (context, authState) {
        if (authState is AuthSuccess) {
          final user = authState.user;
          return SafeArea(
            child: Padding(
              padding: REdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ProfileHeader(user: user),
                  SizedBox(height: 32.h),
                  const ThemeSwitch(),
                  SizedBox(height: 16.h),
                  const LanguageDropdown(),
                  SizedBox(height: 16.h),
                  const LogoutButton(),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
