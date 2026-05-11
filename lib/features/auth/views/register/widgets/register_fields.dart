import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../l10n/app_localizations.dart';

class RegisterFields extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const RegisterFields({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  State<RegisterFields> createState() => _RegisterFieldsState();
}

class _RegisterFieldsState extends State<RegisterFields> {
  bool securePassword = true;
  bool secureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      children: [
        CustomTextFormField(
          validator: Validator.validateName,
          controller: widget.nameController,
          hintText: appLocalizations.enter_your_name,
          prefixIcon: const Icon(Icons.person_2_outlined),
        ),
        SizedBox(height: 16.h),
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
            onPressed: () {
              setState(() {
                securePassword = !securePassword;
              });
            },
            icon: Icon(
              securePassword ? Icons.visibility_off : Icons.visibility,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        CustomTextFormField(
          isSecure: secureConfirmPassword,
          validator: (input) {
            if (input == null || input.trim().isEmpty) {
              return "Plz, confirm password";
            }
            if (input != widget.passwordController.text) {
              return "Password doesn't match";
            }
            return null;
          },
          controller: widget.confirmPasswordController,
          hintText: appLocalizations.confirm_your_password,
          prefixIcon: const Icon(Icons.lock_clock_outlined),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                secureConfirmPassword = !secureConfirmPassword;
              });
            },
            icon: Icon(
              secureConfirmPassword ? Icons.visibility_off : Icons.visibility,
            ),
          ),
        ),
      ],
    );
  }
}
