import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

/// Image source type.
enum ImageSource {
  /// Network URL.
  network,

  /// Asset path.
  asset,

  /// File path.
  file,

  /// SVG asset.
  svg,
}

/// Unified image widget with automatic source detection and loading states.
///
/// Features:
/// - Auto-detects image source (network/asset/file/SVG)
/// - Placeholder shimmer while loading
/// - Error state with fallback
/// - Caching for network images
///
/// Usage:
/// ```dart
/// AppImage(
///   source: 'https://example.com/image.jpg',
///   width: 100,
///   height: 100,
/// )
///
/// AppImage.asset('assets/images/logo.png')
/// AppImage.svg('assets/icons/home.svg')
/// AppImage.network('https://example.com/image.jpg')
/// ```
class AppImage extends StatelessWidget {
  /// Create an AppImage with automatic source detection.
  const AppImage({
    required this.source,
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.borderRadius,
    this.color,
    this.colorBlendMode,
    this.semanticLabel,
  }) : _sourceType = null;

  /// Create an AppImage from a network URL.
  const AppImage.network(
    this.source, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.borderRadius,
    this.color,
    this.colorBlendMode,
    this.semanticLabel,
  }) : _sourceType = ImageSource.network;

  /// Create an AppImage from an asset path.
  const AppImage.asset(
    this.source, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.borderRadius,
    this.color,
    this.colorBlendMode,
    this.semanticLabel,
  }) : _sourceType = ImageSource.asset;

  /// Create an AppImage from a file path.
  const AppImage.file(
    this.source, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.borderRadius,
    this.color,
    this.colorBlendMode,
    this.semanticLabel,
  }) : _sourceType = ImageSource.file;

  /// Create an AppImage from an SVG asset.
  const AppImage.svg(
    this.source, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.placeholder,
    this.errorWidget,
    this.borderRadius,
    this.color,
    this.colorBlendMode,
    this.semanticLabel,
  }) : _sourceType = ImageSource.svg;

  /// Image source (URL, asset path, or file path).
  final String source;

  /// Image width.
  final double? width;

  /// Image height.
  final double? height;

  /// How the image should be inscribed into the box.
  final BoxFit fit;

  /// Widget to show while loading.
  final Widget? placeholder;

  /// Widget to show on error.
  final Widget? errorWidget;

  /// Border radius for the image.
  final BorderRadius? borderRadius;

  /// Color to blend with the image.
  final Color? color;

  /// Blend mode for the color.
  final BlendMode? colorBlendMode;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  /// Forced source type (null = auto-detect).
  final ImageSource? _sourceType;

  @override
  Widget build(BuildContext context) {
    final type = _sourceType ?? _detectSourceType(source);

    Widget image = switch (type) {
      ImageSource.network => _buildNetworkImage(),
      ImageSource.asset => _buildAssetImage(),
      ImageSource.file => _buildFileImage(),
      ImageSource.svg => _buildSvgImage(),
    };

    if (borderRadius != null) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }

    return Semantics(label: semanticLabel, image: true, child: image);
  }

  ImageSource _detectSourceType(String source) {
    if (source.startsWith('http://') || source.startsWith('https://')) {
      return ImageSource.network;
    }
    if (source.endsWith('.svg')) {
      return ImageSource.svg;
    }
    if (source.startsWith('/') || source.startsWith('file://')) {
      return ImageSource.file;
    }
    return ImageSource.asset;
  }

  Widget _buildNetworkImage() {
    return CachedNetworkImage(
      imageUrl: source,
      width: width,
      height: height,
      fit: fit,
      color: color,
      colorBlendMode: colorBlendMode,
      placeholder: (context, url) => placeholder ?? _buildPlaceholder(),
      errorWidget: (context, url, error) => errorWidget ?? _buildErrorWidget(),
    );
  }

  Widget _buildAssetImage() {
    return Image.asset(
      source,
      width: width,
      height: height,
      fit: fit,
      color: color,
      colorBlendMode: colorBlendMode,
      errorBuilder: (context, error, stackTrace) =>
          errorWidget ?? _buildErrorWidget(),
    );
  }

  Widget _buildFileImage() {
    final path = source.replaceFirst('file://', '');
    return Image.file(
      File(path),
      width: width,
      height: height,
      fit: fit,
      color: color,
      colorBlendMode: colorBlendMode,
      errorBuilder: (context, error, stackTrace) =>
          errorWidget ?? _buildErrorWidget(),
    );
  }

  Widget _buildSvgImage() {
    return SvgPicture.asset(
      source,
      width: width,
      height: height,
      fit: fit,
      colorFilter: color != null
          ? ColorFilter.mode(color!, colorBlendMode ?? BlendMode.srcIn)
          : null,
      placeholderBuilder: (context) => placeholder ?? _buildPlaceholder(),
    );
  }

  Widget _buildPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(width: width, height: height, color: Colors.white),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[200],
      child: const Icon(Icons.broken_image_outlined, color: Colors.grey),
    );
  }
}

/// Avatar image widget with circular shape and initials fallback.
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size = 40,
    this.backgroundColor,
    this.foregroundColor,
  });

  /// URL of the avatar image.
  final String? imageUrl;

  /// Name for initials fallback.
  final String? name;

  /// Size of the avatar.
  final double size;

  /// Background color for initials.
  final Color? backgroundColor;

  /// Foreground color for initials.
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor ?? theme.colorScheme.primaryContainer;
    final fgColor = foregroundColor ?? theme.colorScheme.onPrimaryContainer;

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return ClipOval(
        child: AppImage.network(
          imageUrl!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorWidget: _buildInitials(bgColor, fgColor),
        ),
      );
    }

    return _buildInitials(bgColor, fgColor);
  }

  Widget _buildInitials(Color bgColor, Color fgColor) {
    final initials = _getInitials(name);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          color: fgColor,
          fontSize: size * 0.4,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return '?';
    final parts = name.trim().split(' ');
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    }
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }
}
