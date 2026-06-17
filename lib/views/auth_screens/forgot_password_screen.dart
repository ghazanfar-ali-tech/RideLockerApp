import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_locker_app/components/custom_text_field.dart';
import 'package:ride_locker_app/components/round_button.dart';
import 'package:ride_locker_app/core/app_colors.dart';
import 'package:ride_locker_app/providers/auth_providers/forgot_password_provider.dart';
import 'package:ride_locker_app/views/auth_screens/components/form_heading_text.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double sh = MediaQuery.of(context).size.height;
    final double sw = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (_) => ForgotPasswordProvider(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: sh * 0.04),

                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: sw * 0.04,
                        ),
                        Text(
                          'Back',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: sw * 0.038,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: sh * 0.08),

                Container(
                  height: sw * 0.18,
                  width: sw * 0.18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.splashLogoShadowColor.withOpacity(0.15),
                    border: Border.all(
                      color: AppColors.splashLogoShadowColor,
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    Icons.lock_reset_outlined,
                    color: AppColors.splashLogoShadowColor,
                    size: sw * 0.08,
                  ),
                ),

                SizedBox(height: sh * 0.03),

                FormHeadingText(heading: 'Forget Password'),

                SizedBox(height: sh * 0.012),

                Text(
                  'Enter your email address to receive a password \nreset link.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: sw * 0.035,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: sh * 0.06),

                Consumer<ForgotPasswordProvider>(
                  builder: (context, provider, _) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: sw * 0.038,
                            ),
                          ),
                          SizedBox(height: sh * 0.01),
                          customTextFormField(
                            controller: provider.emailController,
                            hint: 'Enter email',
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            errorText: provider.emailError,
                          ),

                          SizedBox(height: sh * 0.05),

                          Center(
                            child: RoundedButton(
                              text: 'Continue',
                              isLoading: provider.isLoading,
                              onTap: () =>
                                  provider.sendResetEmail(context, _formKey),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                SizedBox(height: sh * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
