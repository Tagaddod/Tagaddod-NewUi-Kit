import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/component_item.dart';

class CatalogRepository {
  CatalogRepository({required this.baseUrl});
  final String baseUrl;

  Future<List<ComponentItem>> fetchComponents() async {
    final uri = Uri.parse('$baseUrl/api/manifest');
    final res = await http.get(uri);
    if (res.statusCode != 200) throw Exception('Manifest request failed');
    final map = jsonDecode(res.body) as Map<String, dynamic>;
    final widgets = map['widgets'] as List<dynamic>;
    return widgets.map((e) => ComponentItem.fromJson(e)).toList();
  }
}
