import 'dart:convert';
import 'package:http/http.dart' as http;

/// Thin wrapper around the GitHub REST API v3.
class GitHubApiClient {
  static const _base = 'https://api.github.com';

  final String token;
  final String owner;
  final String repo;

  GitHubApiClient({
    required this.token,
    required this.owner,
    required this.repo,
  });

  Map<String, String> get _headers => {
        'Authorization': 'Bearer $token',
        'Accept': 'application/vnd.github+json',
        'X-GitHub-Api-Version': '2022-11-28',
        'content-type': 'application/json',
      };

  Future<Map<String, dynamic>> get(String path) async {
    final res = await http.get(Uri.parse('$_base$path'), headers: _headers);
    _check(res);
    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> post(
      String path, Map<String, dynamic> body) async {
    final res = await http.post(
      Uri.parse('$_base$path'),
      headers: _headers,
      body: jsonEncode(body),
    );
    _check(res);
    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> put(
      String path, Map<String, dynamic> body) async {
    final res = await http.put(
      Uri.parse('$_base$path'),
      headers: _headers,
      body: jsonEncode(body),
    );
    _check(res);
    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  void _check(http.Response res) {
    if (res.statusCode >= 400) {
      throw Exception('GitHub API ${res.statusCode}: ${res.body}');
    }
  }
}
