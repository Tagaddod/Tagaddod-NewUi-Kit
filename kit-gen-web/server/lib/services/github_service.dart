import 'dart:convert';
import 'dart:io';
import '../models/kit_gap.dart';
import 'github_api_client.dart';
import 'github_pr_builder.dart';

/// Creates GitHub pull requests for Kit Gap proposals identified by the LLM.
/// Set env var GITHUB_TOKEN to enable; silently skips if absent.
class GitHubService {
  static const _owner = 'Tagaddod';
  static const _repo = 'Tagaddod-NewUi-Kit';
  static const _defaultBranch = 'main';

  static String? get _token => Platform.environment['GITHUB_TOKEN'];

  /// Creates a PR for [gaps] and returns the PR URL, or null if skipped.
  static Future<String?> createKitGapPR(List<KitGap> gaps) async {
    final token = _token;
    if (token == null || token.isEmpty) {
      print('[GitHub] GITHUB_TOKEN not set — skipping Kit Gap PR');
      return null;
    }
    if (gaps.isEmpty) return null;

    try {
      final client =
          GitHubApiClient(token: token, owner: _owner, repo: _repo);
      final branch = GitHubPrBuilder.branchName(gaps);

      final baseSha = await _getMainSha(client);
      await _createBranch(client, branch, baseSha);
      await _pushGapFiles(client, branch, baseSha, gaps);

      final pr = await client.post(
        '/repos/$_owner/$_repo/pulls',
        {
          'title': GitHubPrBuilder.prTitle(gaps),
          'body': GitHubPrBuilder.prBody(gaps),
          'head': branch,
          'base': _defaultBranch,
          'draft': false,
        },
      );

      final url = pr['html_url'] as String;
      print('[GitHub] Kit Gap PR created: $url');
      return url;
    } catch (e) {
      print('[GitHub] PR creation failed: $e');
      return null;
    }
  }

  static Future<String> _getMainSha(GitHubApiClient client) async {
    final ref =
        await client.get('/repos/$_owner/$_repo/git/refs/heads/$_defaultBranch');
    return ref['object']['sha'] as String;
  }

  static Future<void> _createBranch(
      GitHubApiClient client, String branch, String sha) async {
    await client.post('/repos/$_owner/$_repo/git/refs', {
      'ref': 'refs/heads/$branch',
      'sha': sha,
    });
  }

  static Future<void> _pushGapFiles(
    GitHubApiClient client,
    String branch,
    String baseSha,
    List<KitGap> gaps,
  ) async {
    for (final gap in gaps) {
      final name = gap.suggestedComponentName ?? gap.widgetName;
      final snake = GitHubPrBuilder.toSnakeCase(name);

      // Markdown description file
      await client.put(
        '/repos/$_owner/$_repo/contents/docs/kit-gaps/$snake.md',
        {
          'message': 'kit-gap: add $name proposal',
          'content': base64.encode(utf8.encode(GitHubPrBuilder.gapMarkdown(gap))),
          'branch': branch,
        },
      );

      // Proposed Dart implementation (if provided)
      if (gap.proposedImplementation != null &&
          gap.proposedImplementation!.trim().isNotEmpty) {
        await client.put(
          '/repos/$_owner/$_repo/contents/lib/widgets/proposed/$snake.dart',
          {
            'message': 'kit-gap: add proposed $name implementation',
            'content': base64.encode(utf8.encode(gap.proposedImplementation!)),
            'branch': branch,
          },
        );
      }
    }
  }
}
