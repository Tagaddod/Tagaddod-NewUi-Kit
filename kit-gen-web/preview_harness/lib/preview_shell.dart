import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'generated/generated_preview_screen.dart';

class PreviewShell extends StatelessWidget {
  const PreviewShell({super.key});

  static final _device = Devices.ios.iPhone13;

  @override
  Widget build(BuildContext context) {
    // Override Flutter's default error widget so runtime crashes surface a
    // readable message instead of a blank white screen.
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return _RuntimeErrorScreen(message: details.exceptionAsString());
    };

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      home: Scaffold(
        backgroundColor: const Color(0xFF0C0C10),
        body: Center(
          child: DeviceFrameTheme(
            style: DeviceFrameStyle.dark(),
            child: FittedBox(
              fit: BoxFit.contain,
              child: DeviceFrame(
                device: _device,
                isFrameVisible: true,
                orientation: Orientation.portrait,
                screen: _ScreenWithUtil(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ThemeData _buildTheme() => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD97742),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFAF9F6),
        useMaterial3: true,
      );
}

/// Initialises ScreenUtil INSIDE the DeviceFrame so it reads the correct
/// device dimensions (390×844) instead of the outer browser viewport.
class _ScreenWithUtil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (_, __) => const _SafeScreen(),
    );
  }
}

/// Wraps GeneratedPreviewScreen in a build-time error boundary.
/// Catches exceptions thrown during widget construction/layout and shows
/// a friendly error card instead of a blank screen.
class _SafeScreen extends StatefulWidget {
  const _SafeScreen();

  @override
  State<_SafeScreen> createState() => _SafeScreenState();
}

class _SafeScreenState extends State<_SafeScreen> {
  Object? _error;

  @override
  Widget build(BuildContext context) {
    if (_error != null) return _RuntimeErrorScreen(message: _error.toString());
    try {
      return const GeneratedPreviewScreen();
    } catch (e) {
      // Synchronous constructor errors are caught here.
      _error = e;
      return _RuntimeErrorScreen(message: e.toString());
    }
  }
}

class _RuntimeErrorScreen extends StatelessWidget {
  const _RuntimeErrorScreen({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final short = message.length > 300 ? '${message.substring(0, 300)}…' : message;
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.warning_amber_rounded,
                color: Color(0xFFD97742), size: 40),
            const SizedBox(height: 16),
            const Text(
              'Runtime error',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'The generated screen crashed at runtime. '
              'Check the Code tab for the full error.',
              style: TextStyle(fontSize: 13, color: Color(0xFF666666), height: 1.5),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEEE8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                short,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF7A2E00),
                  fontFamily: 'monospace',
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
