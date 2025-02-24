import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/widgets/app_bottom_sheet.dart';

class SampleAppBottomSheet extends StatelessWidget {
  const SampleAppBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        TextButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (_) => AppBottomSheet(
                          body: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("hello"),
                            Text("hello"),
                            Text("hello"),
                            Text("hello"),
                            Text("hello"),
                            Text("hello"),
                            Text("hello"),
                            Text("hello"),
                            Text("hello"),
                            Text("hello"),
                            Text("hello"),
                            Text("hello"),
                            Text("hello"),
                            Text("hello"),
                            Text("hello"),
                            Text("hello"),
                            Text("hello"),
                            Text("hello"),
                            Text("hello"),
                            Text("hello"),
                            Text("hello"),
                            Text("hello"),
                          ],
                        ),
                      )));
            },
            child: Text("Show bottom sheet With drag handler")),
        SizedBox(
          height: 20,
        ),
        TextButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (_) => AppBottomSheet(
                      showDragHandler: false,
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("hello"),
                        ],
                      )));
            },
            child: Text("Show bottom sheet Without drag handler")),
      ],
    );
  }
}
