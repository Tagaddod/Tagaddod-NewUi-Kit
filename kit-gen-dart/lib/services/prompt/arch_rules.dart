const archRules = '''## Clean Architecture Output

Generate 3 files for the feature using Cubit + Clean Architecture:

1. **screen file** (e.g. `login_screen.dart`) — the UI widget that uses BlocBuilder/BlocProvider
2. **cubit file** (e.g. `cubit/login_cubit.dart`) — the Cubit class with methods
3. **state file** (e.g. `cubit/login_state.dart`) — the state class (use freezed-style manual copyWith)

Import `flutter_bloc` for BlocBuilder, BlocProvider, Cubit.
Keep each file under 90 lines. Each file must have complete imports.

## Response

Return JSON:
{
  "files": [
    { "path": "feature_screen.dart", "code": "..." },
    { "path": "cubit/feature_cubit.dart", "code": "..." },
    { "path": "cubit/feature_state.dart", "code": "..." }
  ],
  "kit_gaps": []
}''';
