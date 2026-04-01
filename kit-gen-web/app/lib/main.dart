import 'package:flutter/material.dart';
import 'features/chat/presentation/pages/chat_page.dart';
import 'core/theme/app_theme.dart';

void main() => runApp(const KitGenWebApp());

class KitGenWebApp extends StatelessWidget {
  const KitGenWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kit-Gen Web',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const ChatPage(),
    );
  }
}
