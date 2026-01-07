import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Avatar size variants
enum AppAvatarSize { xs, small, medium, large, xl }

/// Avatar shape variants
enum AppAvatarShape { circle, rounded }

/// A dynamic avatar component with configurable size, shape, and fallback.
class AppAvatar extends StatelessWidget {

  const AppAvatar({
    this.imageUrl,
    this.name,
    this.size = AppAvatarSize.medium,
    this.shape = AppAvatarShape.circle,
    this.fallbackIcon,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
    this.badge,
    this.semanticLabel,
    super.key,
  });
  final String? imageUrl;
  final String? name;
  final AppAvatarSize size;
  final AppAvatarShape shape;
  final IconData? fallbackIcon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onTap;
  final Widget? badge;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bgColor = backgroundColor ?? colorScheme.primaryContainer;
    final fgColor = foregroundColor ?? colorScheme.onPrimaryContainer;

    Widget avatar = Semantics(
      label: semanticLabel ?? name ?? 'User avatar',
      image: imageUrl != null,
      child: Container(
        width: _size,
        height: _size,
        decoration: BoxDecoration(
          color: bgColor,
          shape: shape == AppAvatarShape.circle
              ? BoxShape.circle
              : BoxShape.rectangle,
          borderRadius: shape == AppAvatarShape.rounded
              ? BorderRadius.circular(_size * 0.25)
              : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: _buildContent(fgColor),
      ),
    );

    if (onTap != null) {
      avatar = GestureDetector(onTap: onTap, child: avatar);
    }

    if (badge != null) {
      avatar = Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          Positioned(right: 0, bottom: 0, child: badge!),
        ],
      );
    }

    return avatar;
  }

  double get _size {
    switch (size) {
      case AppAvatarSize.xs:
        return 24.w;
      case AppAvatarSize.small:
        return 32.w;
      case AppAvatarSize.medium:
        return 48.w;
      case AppAvatarSize.large:
        return 64.w;
      case AppAvatarSize.xl:
        return 96.w;
    }
  }

  double get _fontSize {
    switch (size) {
      case AppAvatarSize.xs:
        return 10.sp;
      case AppAvatarSize.small:
        return 12.sp;
      case AppAvatarSize.medium:
        return 18.sp;
      case AppAvatarSize.large:
        return 24.sp;
      case AppAvatarSize.xl:
        return 36.sp;
    }
  }

  double get _iconSize {
    switch (size) {
      case AppAvatarSize.xs:
        return 14.w;
      case AppAvatarSize.small:
        return 18.w;
      case AppAvatarSize.medium:
        return 24.w;
      case AppAvatarSize.large:
        return 32.w;
      case AppAvatarSize.xl:
        return 48.w;
    }
  }

  Widget _buildContent(Color fgColor) {
    // Network image
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
        placeholder: (_, __) => _buildPlaceholder(fgColor),
        errorWidget: (_, __, ___) => _buildPlaceholder(fgColor),
      );
    }

    return _buildPlaceholder(fgColor);
  }

  Widget _buildPlaceholder(Color fgColor) {
    // Name initials
    if (name != null && name!.isNotEmpty) {
      final initials = _getInitials(name!);
      return Center(
        child: Text(
          initials,
          style: TextStyle(
            color: fgColor,
            fontSize: _fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    // Fallback icon
    return Center(
      child: Icon(
        fallbackIcon ?? Icons.person,
        size: _iconSize,
        color: fgColor,
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return parts.first
        .substring(0, parts.first.length >= 2 ? 2 : 1)
        .toUpperCase();
  }
}
