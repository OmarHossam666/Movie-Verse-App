import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:movie_verse/core/constants/app_colors.dart';

class EfficientShimmer extends StatelessWidget {
  const EfficientShimmer({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
    this.period,
    this.enabled = true,
  });

  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration? period;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;

    return Shimmer.fromColors(
      baseColor: baseColor ?? AppColors.cardBackground,
      highlightColor: highlightColor ?? AppColors.borderLight,
      period: period ?? const Duration(milliseconds: 1200),
      child: child,
    );
  }
}

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.color,
  });

  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? AppColors.cardBackground,
        borderRadius: borderRadius ?? BorderRadius.circular(4),
      ),
    );
  }
}
