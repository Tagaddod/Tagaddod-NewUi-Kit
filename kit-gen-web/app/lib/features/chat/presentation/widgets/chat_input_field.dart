import 'package:flutter/material.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    super.key,
    required this.controller,
    required this.onSend,
    required this.isLoading,
    required this.archMode,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isLoading;
  final bool archMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE2D7CB)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 6),
            child: TextField(
              controller: controller,
              enabled: !isLoading,
              minLines: 3,
              maxLines: 8,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
              decoration: InputDecoration(
                hintText: 'Describe the screen you want to build…',
                hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFFB0A898),
                  height: 1.5,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 4, 14, 14),
            child: Row(
              children: [
                _ModePill(archMode: archMode),
                const Spacer(),
                _SendButton(onSend: onSend, isLoading: isLoading),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ModePill extends StatelessWidget {
  const _ModePill({required this.archMode});

  final bool archMode;

  @override
  Widget build(BuildContext context) {
    final isArch = archMode;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isArch ? const Color(0xFFEAE8F8) : const Color(0xFFF3E6D9),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isArch ? Icons.account_tree_outlined : Icons.phone_iphone_rounded,
            size: 13,
            color: isArch ? const Color(0xFF3D3680) : const Color(0xFFB85D2D),
          ),
          const SizedBox(width: 5),
          Text(
            isArch ? 'Architecture' : 'Screen mode',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: isArch ? const Color(0xFF3D3680) : const Color(0xFFB85D2D),
            ),
          ),
        ],
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({required this.onSend, required this.isLoading});

  final VoidCallback onSend;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: isLoading ? null : onSend,
      icon: isLoading
          ? const SizedBox(
              height: 14,
              width: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : const Icon(Icons.arrow_forward_rounded, size: 16),
      label: Text(isLoading ? 'Building…' : 'Generate'),
      style: FilledButton.styleFrom(
        backgroundColor: const Color(0xFF18201A),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.w700),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
