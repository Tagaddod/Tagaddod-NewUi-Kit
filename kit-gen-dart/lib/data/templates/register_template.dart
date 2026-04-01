import 'screen_template.dart';

const registerTemplate = ScreenTemplate(
  name: 'Register Screen',
  description:
      'Name, email, password, confirm password registration form',
  code: _part1 + _part2,
);

const _part1 = r"""
import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/top_app_bar.dart';
import 'package:tagaddod_ui_kit/widgets/app_text.dart';
import 'package:tagaddod_ui_kit/widgets/app_text_field.dart';
import 'package:tagaddod_ui_kit/widgets/button/app_filled_button.dart';
import 'package:tagaddod_ui_kit/widgets/app_icon.dart';
import 'package:tagaddod_ui_kit/colors/semantic/text_colors.dart';
import 'package:tagaddod_ui_kit/utils/button_type.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }
""";

const _part2 = r"""
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: AppText.bodyLgSemiBold(text: 'Create Account', textColor: TextColors.colorText),
        prefix: AppIcon(svgIconPath: 'assets/svg/back.svg', onTap: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField.large(labelText: 'Full Name', hintText: 'Name', textEditingController: _nameCtrl, width: double.infinity),
            const SizedBox(height: 16),
            AppTextField.large(labelText: 'Email', hintText: 'Email', textEditingController: _emailCtrl, keyboardType: TextInputType.emailAddress, width: double.infinity),
            const SizedBox(height: 16),
            AppTextField.large(labelText: 'Password', hintText: 'Password', textEditingController: _passwordCtrl, obscureText: true, width: double.infinity),
            const SizedBox(height: 16),
            AppTextField.large(labelText: 'Confirm Password', hintText: 'Confirm', textEditingController: _confirmCtrl, obscureText: true, width: double.infinity),
            const SizedBox(height: 24),
            AppFilledButton.large(btnText: 'Create Account', onTap: () {}, buttonType: ButtonType.defaultButton, width: double.infinity),
          ],
        ),
      ),
    );
  }
}
""";
