import 'package:flutter/material.dart';
import 'generated/generated_preview_screen.dart';

class PreviewShell extends StatelessWidget {
  const PreviewShell({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      home: Scaffold(
        backgroundColor: const Color(0xFFF5F1E8),
        body: Center(
          child: Container(
            width: 460,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1E1A),
              borderRadius: BorderRadius.circular(48),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x24000000),
                  blurRadius: 48,
                  offset: Offset(0, 24),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(34),
              child: SizedBox(
                width: 390,
                height: 844,
                child: MediaQuery(
                  data: const MediaQueryData(
                    size: Size(390, 844),
                    devicePixelRatio: 1,
                    textScaler: TextScaler.noScaling,
                  ),
                  child: const GeneratedPreviewScreen(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ThemeData _buildTheme() {
    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFFD97742),
      brightness: Brightness.light,
    );

    return ThemeData(
      colorScheme: scheme,
      scaffoldBackgroundColor: const Color(0xFFF5F1E8),
      useMaterial3: true,
    );
  }
}
