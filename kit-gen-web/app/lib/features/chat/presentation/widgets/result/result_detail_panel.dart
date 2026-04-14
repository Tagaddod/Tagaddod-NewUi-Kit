import 'package:flutter/material.dart';
import '../../../domain/generation_payload.dart';
import 'result_detail_bodies.dart';

class ResultDetailPanel extends StatefulWidget {
  const ResultDetailPanel({super.key, required this.result});
  final GenerationPayload result;

  @override
  State<ResultDetailPanel> createState() => _State();
}

class _State extends State<ResultDetailPanel> {
  var _showCode = false;

  @override
  Widget build(BuildContext context) {
    final r = widget.result;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Color(0x0F000000), blurRadius: 32, offset: Offset(0, 12)),
        ],
      ),
      child: Column(
        children: [
          _PanelHeader(
            result: r,
            showCode: _showCode,
            onToggle: (v) => setState(() => _showCode = v),
          ),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _showCode
                  ? ResultDetailCodeBody(result: r)
                  : ResultDetailInfoBody(result: r),
            ),
          ),
        ],
      ),
    );
  }
}

class _PanelHeader extends StatelessWidget {
  const _PanelHeader({
    required this.result,
    required this.showCode,
    required this.onToggle,
  });

  final GenerationPayload result;
  final bool showCode;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ANALYSIS',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: const Color(0xFF9E9990),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  result.requirement,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SegmentedButton<bool>(
            showSelectedIcon: false,
            segments: const [
              ButtonSegment(value: false, label: Text('Details')),
              ButtonSegment(value: true, label: Text('Code')),
            ],
            selected: {showCode},
            onSelectionChanged: (s) => onToggle(s.first),
            style: const ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),
        ],
      ),
    );
  }
}
