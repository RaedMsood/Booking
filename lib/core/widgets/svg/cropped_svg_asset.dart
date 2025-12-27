import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';

/// Renders an SVG asset but with a custom viewBox, which effectively "crops"
/// empty padding inside the original SVG canvas.
///
/// Why this exists:
/// Some exported SVGs use a huge canvas (e.g. viewBox 0 0 1024 1024) while the
/// drawing occupies only a small part of it. When stacked vertically, this
/// looks like a big gap even if your widgets are close.
class CroppedSvgAsset extends StatelessWidget {
  const CroppedSvgAsset({
    super.key,
    required this.assetPath,
    required this.viewBox,
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
  });

  /// e.g. AppIcons.logo1
  final String assetPath;

  /// Example: "0 240 1024 560" (minX minY width height)
  final String viewBox;

  final double? height;
  final double? width;
  final Color? color;
  final BoxFit fit;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: rootBundle.loadString(assetPath),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(width: width, height: height);
        }

        final raw = snapshot.data!;

        // Replace the first viewBox occurrence.
        // This is intentionally simple and works for typical Illustrator exports.
        final updated = raw.replaceFirst(
          RegExp(r'viewBox\s*=\s*"[^"]*"', caseSensitive: false),
          'viewBox="$viewBox"',
        );

        return SvgPicture.string(
          updated,
          height: height,
          width: width,
          fit: fit,
          alignment: alignment,
          colorFilter: color == null
              ? null
              : ColorFilter.mode(color!, BlendMode.srcIn),
        );
      },
    );
  }
}

