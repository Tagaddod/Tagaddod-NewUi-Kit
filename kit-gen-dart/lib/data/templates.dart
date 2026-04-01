export 'templates/screen_template.dart';

import 'templates/screen_template.dart';
import 'templates/login_template.dart';
import 'templates/register_template.dart';
import 'templates/settings_template.dart';
import 'templates/list_detail_template.dart';
import 'templates/empty_state_template.dart';

const screenTemplates = <String, ScreenTemplate>{
  'login': loginTemplate,
  'register': registerTemplate,
  'settings': settingsTemplate,
  'list_detail': listDetailTemplate,
  'empty_state': emptyStateTemplate,
};
