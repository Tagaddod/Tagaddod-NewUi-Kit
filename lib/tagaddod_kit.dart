import 'package:flutter/material.dart';
import 'package:tagaddod_ui_kit/app_drawer.dart';

class TagaddodKit extends StatefulWidget {
  const TagaddodKit({super.key});

  @override
  State<TagaddodKit> createState() => _TagaddodKitState();
}

class _TagaddodKitState extends State<TagaddodKit> {
  Widget _selectedWidget = const PlaceholderWidget();

  void _updateWidget(Widget widget) {
    setState(() {
      _selectedWidget = widget;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'tajawal'),
      home: Scaffold(
        appBar: AppBar(),
        drawer: AppDrawer(
          onSelectWidget: _updateWidget,
        ),
        body: Center(child: _selectedWidget),
      ),
    );
  }
}
