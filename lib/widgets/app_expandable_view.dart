import 'package:flutter/material.dart';

class AppExpandableView extends StatefulWidget {
  final Widget header;
  final Widget body;
  final bool initiallyExpanded;
  final Duration animationDuration;
  final Curve animationCurve;
  final Widget? trailingIcon;
  const AppExpandableView({
    super.key,
    required this.header,
    required this.body,
    required this.trailingIcon,
    this.initiallyExpanded = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<AppExpandableView> createState() => _AppExpandableViewState();
}

class _AppExpandableViewState extends State<AppExpandableView>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late AnimationController _controller;
  late Animation<double> _iconRotation;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _iconRotation = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.animationCurve,
      ),
    );
    if (_isExpanded) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _toggleExpansion,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.header,
              RotationTransition(
                turns: _iconRotation,
                child: widget.trailingIcon,
              ),
            ],
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: widget.body,
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: widget.animationDuration,
          firstCurve: widget.animationCurve,
          secondCurve: widget.animationCurve,
        ),
      ],
    );
  }
}
