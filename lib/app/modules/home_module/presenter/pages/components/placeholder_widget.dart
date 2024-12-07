import 'package:flutter/material.dart';

class PlaceholderWidget extends StatelessWidget {
  const PlaceholderWidget({
    super.key,
    required this.color,
    this.label,
    this.radius = 100,
    this.height,
    this.width,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    this.border,
    this.onTap,
    this.child,
  });

  final Color color;
  final Widget? child;
  final String? label;
  final double radius;
  final double? height;
  final double? width;
  final EdgeInsets padding;
  final Border? border;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: border,
      ),
      height: height,
      width: width,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: label != null
                ? Center(
                    child: Text(label!),
                  )
                : child,
          ),
        ),
      ),
    );
  }
}
