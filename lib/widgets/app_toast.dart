import 'package:flutter/material.dart';

class AppToast {
  static OverlayEntry? _currentEntry;

  static void show(
    BuildContext context,
    String message, {
    bool isSuccess = true,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(milliseconds: 1800),
  }) {
    // Remove any active toast immediately
    _currentEntry?.remove();
    _currentEntry = null;

    final overlay = Overlay.maybeOf(context);
    if (overlay == null) return;

    final entry = OverlayEntry(
      builder: (ctx) => _ToastWidget(
        message: message,
        isSuccess: isSuccess,
        actionLabel: actionLabel,
        onAction: () {
          _currentEntry?.remove();
          _currentEntry = null;
          if (onAction != null) onAction();
        },
      ),
    );

    _currentEntry = entry;
    overlay.insert(entry);

    Future.delayed(duration, () {
      if (_currentEntry == entry) {
        entry.remove();
        _currentEntry = null;
      }
    });
  }
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final bool isSuccess;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _ToastWidget({
    required this.message,
    required this.isSuccess,
    this.actionLabel,
    this.onAction,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 20,
      right: 20,
      child: Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.topCenter,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 450),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: widget.isSuccess ? const Color(0xFF1E293B) : const Color(0xFFDC2626),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.isSuccess ? Icons.check_circle : Icons.info,
                      color: widget.isSuccess ? const Color(0xFF4ADE80) : Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        widget.message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (widget.actionLabel != null) ...[
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: widget.onAction,
                        child: Text(
                          widget.actionLabel!,
                          style: const TextStyle(
                            color: Color(0xFF60A5FA),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
