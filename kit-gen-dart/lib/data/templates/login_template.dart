import 'screen_template.dart';

const loginTemplate = ScreenTemplate(
  name: 'Login Screen',
  description:
      'Email + password login with remember me and forgot password',
  code: _part1 + _part2,
);

const _part1 = r"""
import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/top_app_bar.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';
import 'package:tagaddod_ui_kit/widgets/app_text_field.dart';
import 'package:tagaddod_ui_kit/widgets/button/app_filled_button.dart';
import 'package:tagaddod_ui_kit/widgets/button/app_text_button.dart';
import 'package:tagaddod_ui_kit/widgets/app_check_box.dart';
import 'package:tagaddod_ui_kit/widgets/app_logo.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/utils/button_type.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: AppText.bodyLgSemiBold(text: 'Login', textColor: TextColors.colorText),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
""";

const _part2 = r"""          children: [
            const Center(child: AppLogo(width: 120, height: 48)),
            const SizedBox(height: 32),
            AppText.headingSm(text: 'Welcome Back', textColor: TextColors.colorText),
            const SizedBox(height: 24),
            AppTextField.large(labelText: 'Email', hintText: 'Email', textEditingController: _emailCtrl, width: double.infinity),
            const SizedBox(height: 16),
            AppTextField.large(labelText: 'Password', hintText: 'Password', textEditingController: _passwordCtrl, obscureText: true, width: double.infinity),
            const SizedBox(height: 16),
            Row(children: [
              AppCheckBox(value: _rememberMe, onChanged: (v) => setState(() => _rememberMe = v ?? false)),
              const SizedBox(width: 8),
              AppText.bodySm(text: 'Remember me', textColor: TextColors.colorText),
              const Spacer(),
              AppTextButton.medium(btnText: 'Forgot Password?', onTap: () {}, buttonType: ButtonType.defaultButton),
            ]),
            const SizedBox(height: 24),
            AppFilledButton.large(btnText: 'Login', onTap: () {}, buttonType: ButtonType.defaultButton, width: double.infinity),
          ],
        ),
      ),
    );
  }
}
""";
