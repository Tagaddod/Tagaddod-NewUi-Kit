import 'package:mason_logger/mason_logger.dart';

void printKitGenUsage(Logger logger) {
  logger.info('''
${lightCyan.wrap('Kit-Gen')} - AI-powered Flutter code generator

${styleBold.wrap('Usage:')}
  kit-gen <command> [options]

${styleBold.wrap('Commands:')}
  generate, gen    Generate Flutter code from requirement
  refine           Interactively refine a generated file
  template, tpl    Use a pre-built screen template
  config           Configure API key
  info             Show UI kit information
  manifest         Regenerate component manifest from source
  search           Search for components

${styleBold.wrap('Generate Options:')}
  -r  Requirement text         --arch      Clean architecture
  -o  Output file/directory    --verbose   Raw Gemini response
  -i  Interactive mode         --retry     Auto-retry on failure
  -c  Context screen path      --validate  Run dart analyze

${styleBold.wrap('Examples:')}
  kit-gen gen -r "Login screen" -o lib/screens/login.dart
  kit-gen gen -r "Dashboard" -o lib/features/dash/ --arch
  kit-gen gen -i --verbose --retry
  kit-gen refine -f lib/screens/login.dart
  kit-gen tpl -n login -o lib/screens/login.dart
''');
}
