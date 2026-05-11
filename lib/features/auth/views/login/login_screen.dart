import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:evently_app/core/utils/routes_manager.dart';
import 'package:evently_app/core/ui_utils/dialog_utils.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/core/widgets/custom_text_button.dart';
import 'package:evently_app/features/auth/views/widgets/social_auth_section.dart';
import 'package:evently_app/features/auth/views/widgets/auth_header.dart';
import 'package:evently_app/features/auth/views/widgets/auth_footer.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_bloc.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_event.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_state.dart';
import 'widgets/login_fields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            DialogUtils.showLoading(context, dismissible: false);
          } else if (state is AuthSuccess) {
            DialogUtils.hideDialog(context);
            DialogUtils.showToastMessage(
              message: "User Logged-In Successfully",
              bgColor: Colors.green,
            );
            Navigator.pushReplacementNamed(context, RoutesManager.homeScreen);
          } else if (state is AuthError) {
            DialogUtils.hideDialog(context);
            DialogUtils.showToastMessage(
              message: state.message,
              bgColor: Colors.red,
            );
          }
        },
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: REdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AuthHeader(title: appLocalizations.login_to_your_account),
                  SizedBox(height: 24.h),
                  LoginFields(
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
                  SizedBox(height: 8.h),
                  CustomTextButton(
                    title: appLocalizations.forget_password,
                    align: TextAlign.end,
                  ),
                  SizedBox(height: 47.h),
                  CustomElevatedButton(
                    title: appLocalizations.login,
                    onClick: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<AuthBloc>().add(
                              LoginRequested(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                      }
                    },
                  ),
                  SizedBox(height: 47.h),
                  AuthFooter(
                    text: appLocalizations.dont_have_an_account,
                    buttonTitle: appLocalizations.sing_up,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutesManager.register,
                      );
                    },
                  ),
                  SizedBox(height: 24.h),
                  GoogleAuthSection(
                    label: "Login with Google",
                    onPressed: () =>
                        context.read<AuthBloc>().add(GoogleLoginRequested()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
