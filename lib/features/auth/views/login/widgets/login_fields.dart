import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../l10n/app_localizations.dart';

class LoginFields extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginFields({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<LoginFields> createState() => _LoginFieldsState();
}

class _LoginFieldsState extends State<LoginFields> {
  bool securePassword = true;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      children: [
        CustomTextFormField(
          validator: Validator.validateEmail,
          controller: widget.emailController,
          hintText: appLocalizations.enter_your_email,
          prefixIcon: const Icon(Icons.email_outlined),
        ),
        SizedBox(height: 16.h),
        CustomTextFormField(
          isSecure: securePassword,
          validator: Validator.validatePassword,
          controller: widget.passwordController,
          hintText: appLocalizations.enter_your_password,
          prefixIcon: const Icon(Icons.lock_clock_outlined),
          suffixIcon: IconButton(
            onPressed: () => setState(() => securePassword = !securePassword),
            icon: Icon(
              securePassword ? Icons.visibility_off : Icons.visibility,
            ),
          ),
        ),
      ],
    );
  }
}
