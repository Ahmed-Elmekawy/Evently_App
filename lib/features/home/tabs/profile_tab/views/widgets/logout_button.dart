import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../l10n/app_localizations.dart';
import '../../../../../auth/view_model/bloc/auth_bloc.dart';
import '../../../../../auth/view_model/bloc/auth_event.dart';
import '../../../../../auth/view_model/bloc/auth_state.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return InkWell(
          onTap: state is AuthLoading
              ? null
              : () {
                  context.read<AuthBloc>().add(LogoutRequested());
                },
          child: Container(
            padding: REdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 1.w,
              ),
              color: Theme.of(context).primaryColor,
            ),
            width: double.infinity,
            child: Row(
              children: [
                Text(
                  appLocalizations.logout,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const Spacer(),
                state is AuthLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.red,
                        ),
                      )
                    : const Icon(Icons.logout, color: Colors.red),
              ],
            ),
          ),
        );
      },
    );
  }
}
