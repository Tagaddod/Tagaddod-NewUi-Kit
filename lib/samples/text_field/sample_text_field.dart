import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/typography/semantics/body_styles.dart';
import 'package:tagaddod_ui_kit/widgets/app_text_field.dart';

class SampleAppTextField extends StatelessWidget {
  const SampleAppTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MediumTextFieldSample(),
          Divider(),
          LargeTextFieldSample(),
        ],
      ),
    );
  }
}

class MediumTextFieldSample extends StatefulWidget {
  const MediumTextFieldSample({
    super.key,
  });

  @override
  State<MediumTextFieldSample> createState() => _MediumTextFieldSampleState();
}

class _MediumTextFieldSampleState extends State<MediumTextFieldSample> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "App Text Field  Medium",
          style: TextStyle(fontSize: 20),
        ),
        AppTextField.medium(
          labelText: "Label",
          hintText: "Value",
          isOptionalEnabled: true,
          prefix: const Icon(
            Icons.search,
            color: Colors.grey,
            size: 16,
          ),
          suffix: const Icon(
            Icons.search,
            color: Colors.grey,
            size: 16,
          ),
          width: MediaQuery.sizeOf(context).width * 0.5,
        ),
        const SizedBox(
          height: 15,
        ),
        AppTextField.medium(
          labelText: "Rest Medium Text Field",
          hintText: "Value",
          prefix: Text(
            "Label",
            style: BodyStyles.bodySmSemiBold.copyWith(height: 2.5),
          ),
          width: MediaQuery.sizeOf(context).width * 0.5,
        ),
        const SizedBox(
          height: 15,
        ),
        //disabled
        AppTextField.medium(
          labelText: "Disabled Medium Text Field",
          hintText: "Value",
          width: MediaQuery.sizeOf(context).width * 0.5,
          isEnabled: false,
        ),
        const SizedBox(
          height: 15,
        ),
        //disabled
        Form(
          key: _formKey,
          child: AppTextField.medium(
            labelText: "Error  Text Field",
            hintText: "Value",
            autovalidateMode: AutovalidateMode.always,
            validator: (value) {
              return value == null || value.isEmpty
                  ? 'Please enter some text'
                  : null;
            },
            // errorText: "Error message",
            width: MediaQuery.sizeOf(context).width * 0.5,
          ),
        ),
        const SizedBox(
          height: 15,
        ),

        //read only
        AppTextField.medium(
          labelText: "Read Only Medium Text Field",
          hintText: "Value",
          width: MediaQuery.sizeOf(context).width * 0.5,
          readOnly: true,
        ),

        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}

class LargeTextFieldSample extends StatelessWidget {
  const LargeTextFieldSample({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "App Text Field  Large",
          style: TextStyle(fontSize: 20),
        ),
        AppTextField.large(
          labelText: "Rest Large Text Field",
          hintText: "Value",
          helperText: "Help Text",
          prefix: const Icon(
            Icons.search,
            size: 16,
            color: Colors.grey,
          ),
          suffix: const Icon(
            Icons.search,
            color: Colors.grey,
            size: 16,
          ),
          width: MediaQuery.sizeOf(context).width * 0.5,
        ),
        const SizedBox(
          height: 15,
        ),
        AppTextField.large(
          labelText: "Rest Medium Text Field",
          hintText: "Value",
          prefix: Text(
            "Labelyz",
            style: BodyStyles.bodyMdSemiBold.copyWith(height: 2.9),
          ),
          width: MediaQuery.sizeOf(context).width * 0.5,
        ),
        const SizedBox(
          height: 15,
        ),
        //disabled
        AppTextField.large(
          labelText: "Disabled Large Text Field",
          hintText: "Value",
          width: MediaQuery.sizeOf(context).width * 0.5,
          isEnabled: false,
        ),
        const SizedBox(
          height: 15,
        ),
        //disabled
        AppTextField.large(
          labelText: "Error  Text Field",
          hintText: "Value",
          width: MediaQuery.sizeOf(context).width * 0.5,
          autovalidateMode: AutovalidateMode.always,
          validator: (value) {
            return value == null || value.isEmpty
                ? 'Please enter some text'
                : null;
          },
        ),
        const SizedBox(
          height: 15,
        ),

        //read only
        AppTextField.large(
          labelText: "Read Only Large Text Field",
          hintText: "Value",
          width: MediaQuery.sizeOf(context).width * 0.5,
          readOnly: true,
        ),

        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
