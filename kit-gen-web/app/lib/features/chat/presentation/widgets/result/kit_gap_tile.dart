import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../../domain/generation_payload.dart';
import 'status_chip.dart';

class KitGapTile extends StatefulWidget {
  const KitGapTile({super.key, required this.gap});
  final GenerationKitGap gap;

  @override
  State<KitGapTile> createState() => _KitGapTileState();
}

class _KitGapTileState extends State<KitGapTile> {
  bool _loading = false;
  String? _prUrl;
  String? _error;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F0),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0D0A0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  widget.gap.suggestedComponentName ?? widget.gap.widgetName,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (widget.gap.priority != null) ...[
                const SizedBox(width: 8),
                StatusChip(
                  label: 'P${widget.gap.priority}',
                  color: const Color(0xFFF8D8A7),
                  foreground: const Color(0xFF3F2B18),
                ),
              ],
            ],
          ),
          const SizedBox(height: 5),
          Text(widget.gap.description, style: theme.textTheme.bodySmall),
          if ((widget.gap.reason ?? '').isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              widget.gap.reason!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: const Color(0xFF6B7280),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          const SizedBox(height: 8),
          _ActionRow(
            loading: _loading,
            prUrl: _prUrl,
            error: _error,
            onPropose: _propose,
          ),
        ],
      ),
    );
  }

  Future<void> _propose() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final res = await http.post(
        Uri.parse('http://localhost:8080/api/kit-gaps/pr'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode({'gaps': [widget.gap.toJson()]}),
      );
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      if (res.statusCode == 200 && data['prUrl'] != null) {
        setState(() => _prUrl = data['prUrl'] as String);
      } else {
        setState(() => _error = data['error'] as String? ?? 'PR creation failed');
      }
    } catch (e) {
      setState(() => _error = '$e');
    } finally {
      setState(() => _loading = false);
    }
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.loading,
    required this.prUrl,
    required this.error,
    required this.onPropose,
  });

  final bool loading;
  final String? prUrl;
  final String? error;
  final VoidCallback onPropose;

  @override
  Widget build(BuildContext context) {
    if (prUrl != null) {
      return TextButton.icon(
        onPressed: () => launchUrl(Uri.parse(prUrl!)),
        icon: const Icon(Icons.open_in_new, size: 14),
        label: const Text('PR created — View on GitHub'),
        style: TextButton.styleFrom(
          foregroundColor: const Color(0xFF2952CC),
          padding: EdgeInsets.zero,
          textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      );
    }
    if (error != null) {
      return Text(
        'Error: $error',
        style: const TextStyle(fontSize: 11, color: Color(0xFFB91C1C)),
      );
    }
    return TextButton.icon(
      onPressed: loading ? null : onPropose,
      icon: loading
          ? const SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(strokeWidth: 1.5),
            )
          : const Icon(Icons.send_outlined, size: 14),
      label: Text(loading ? 'Creating PR…' : 'Propose to Kit →'),
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFFC07020),
        padding: EdgeInsets.zero,
        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}
