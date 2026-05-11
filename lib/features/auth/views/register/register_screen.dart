import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:evently_app/core/utils/routes_manager.dart';
import 'package:evently_app/core/ui_utils/dialog_utils.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_bloc.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_event.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_state.dart';
import '../widgets/social_auth_section.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_footer.dart';
import 'widgets/register_fields.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
              message: "Successfully Registered",
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
                  AuthHeader(title: appLocalizations.create_your_account),
                  SizedBox(height: 24.h),
                  RegisterFields(
                    nameController: _nameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                  ),
                  SizedBox(height: 60.h),
                  CustomElevatedButton(
                    title: appLocalizations.sing_up,
                    onClick: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<AuthBloc>().add(
                              RegisterRequested(
                                name: _nameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                      }
                    },
                  ),
                  SizedBox(height: 24.h),
                  AuthFooter(
                    text: appLocalizations.already_have_an_account,
                    buttonTitle: appLocalizations.login,
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        RoutesManager.login,
                      );
                    },
                  ),
                  SizedBox(height: 24.h),
                  GoogleAuthSection(
                    label: "Sign up with Google",
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

