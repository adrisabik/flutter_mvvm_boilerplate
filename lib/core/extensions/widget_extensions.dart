import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Extensions on [Widget] for common transformations.
extension WidgetExtensions on Widget {
  // ═══════════════════════════════════════════════════════════════════════════
  // PADDING
  // ═══════════════════════════════════════════════════════════════════════════

  /// Add padding on all sides.
  ///
  /// Usage: `Text('Hello').padAll(16)`
  Widget padAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);

  /// Add symmetric padding.
  ///
  /// Usage: `Text('Hello').padSymmetric(h: 16, v: 8)`
  Widget padSymmetric({double h = 0, double v = 0}) => Padding(
    padding: EdgeInsets.symmetric(horizontal: h, vertical: v),
    child: this,
  );

  /// Add horizontal padding.
  ///
  /// Usage: `Text('Hello').padHorizontal(16)`
  Widget padHorizontal(double value) => Padding(
    padding: EdgeInsets.symmetric(horizontal: value),
    child: this,
  );

  /// Add vertical padding.
  ///
  /// Usage: `Text('Hello').padVertical(16)`
  Widget padVertical(double value) => Padding(
    padding: EdgeInsets.symmetric(vertical: value),
    child: this,
  );

  /// Add custom padding.
  ///
  /// Usage: `Text('Hello').padOnly(left: 8, top: 16)`
  Widget padOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) => Padding(
    padding: EdgeInsets.only(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    ),
    child: this,
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // MARGIN (CONTAINER)
  // ═══════════════════════════════════════════════════════════════════════════

  /// Add margin on all sides.
  ///
  /// Usage: `Text('Hello').marginAll(16)`
  Widget marginAll(double value) =>
      Container(margin: EdgeInsets.all(value), child: this);

  /// Add symmetric margin.
  ///
  /// Usage: `Text('Hello').marginSymmetric(h: 16, v: 8)`
  Widget marginSymmetric({double h = 0, double v = 0}) => Container(
    margin: EdgeInsets.symmetric(horizontal: h, vertical: v),
    child: this,
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // SIZING
  // ═══════════════════════════════════════════════════════════════════════════

  /// Set widget size.
  ///
  /// Usage: `Icon(Icons.star).sized(24, 24)`
  Widget sized(double width, double height) =>
      SizedBox(width: width, height: height, child: this);

  /// Set widget width.
  ///
  /// Usage: `Text('Hello').width(100)`
  Widget width(double width) => SizedBox(width: width, child: this);

  /// Set widget height.
  ///
  /// Usage: `Text('Hello').height(50)`
  Widget height(double height) => SizedBox(height: height, child: this);

  /// Expand widget to fill available space.
  ///
  /// Usage: `Text('Hello').expanded()`
  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);

  /// Make widget flexible.
  ///
  /// Usage: `Text('Hello').flexible()`
  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) =>
      Flexible(flex: flex, fit: fit, child: this);

  // ═══════════════════════════════════════════════════════════════════════════
  // ALIGNMENT
  // ═══════════════════════════════════════════════════════════════════════════

  /// Center widget.
  ///
  /// Usage: `Text('Hello').centered()`
  Widget centered() => Center(child: this);

  /// Align widget.
  ///
  /// Usage: `Text('Hello').aligned(Alignment.topRight)`
  Widget aligned(AlignmentGeometry alignment) =>
      Align(alignment: alignment, child: this);

  // ═══════════════════════════════════════════════════════════════════════════
  // VISIBILITY
  // ═══════════════════════════════════════════════════════════════════════════

  /// Conditionally show/hide widget.
  ///
  /// Usage: `Text('Hello').visible(isLoggedIn)`
  Widget visible(bool isVisible) => isVisible ? this : const SizedBox.shrink();

  /// Conditionally show/hide with Visibility widget.
  ///
  /// Maintains layout space when hidden.
  /// Usage: `Text('Hello').visibility(isLoggedIn, maintainSize: true)`
  Widget visibility(
    bool isVisible, {
    bool maintainSize = false,
    bool maintainAnimation = false,
    bool maintainState = false,
  }) => Visibility(
    visible: isVisible,
    maintainSize: maintainSize,
    maintainAnimation: maintainAnimation,
    maintainState: maintainState,
    child: this,
  );

  /// Show widget with opacity.
  ///
  /// Usage: `Text('Hello').opacity(0.5)`
  Widget opacity(double value) => Opacity(opacity: value, child: this);

  // ═══════════════════════════════════════════════════════════════════════════
  // INTERACTION
  // ═══════════════════════════════════════════════════════════════════════════

  /// Make widget tappable.
  ///
  /// Usage: `Text('Hello').onTap(() => print('Tapped'))`
  Widget onTap(VoidCallback? onTap) =>
      GestureDetector(onTap: onTap, child: this);

  /// Make widget tappable with ink effect.
  ///
  /// Usage: `Text('Hello').inkWell(() => print('Tapped'))`
  Widget inkWell({VoidCallback? onTap, BorderRadius? borderRadius}) =>
      InkWell(onTap: onTap, borderRadius: borderRadius, child: this);

  /// Ignore pointer events.
  ///
  /// Usage: `Text('Hello').ignorePointer()`
  Widget ignorePointer({bool ignoring = true}) =>
      IgnorePointer(ignoring: ignoring, child: this);

  /// Absorb pointer events.
  ///
  /// Usage: `Text('Hello').absorbPointer()`
  Widget absorbPointer({bool absorbing = true}) =>
      AbsorbPointer(absorbing: absorbing, child: this);

  // ═══════════════════════════════════════════════════════════════════════════
  // DECORATION
  // ═══════════════════════════════════════════════════════════════════════════

  /// Wrap in a decorated container.
  ///
  /// Usage: `Text('Hello').decorated(BoxDecoration(color: Colors.blue))`
  Widget decorated(BoxDecoration decoration) =>
      DecoratedBox(decoration: decoration, child: this);

  /// Add border radius.
  ///
  /// Usage: `Text('Hello').rounded(16)`
  Widget rounded(double radius) =>
      ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);

  /// Add card wrapper.
  ///
  /// Usage: `Text('Hello').card(elevation: 2)`
  Widget card({double elevation = 1, Color? color, ShapeBorder? shape}) =>
      Card(elevation: elevation, color: color, shape: shape, child: this);

  // ═══════════════════════════════════════════════════════════════════════════
  // SAFE AREA
  // ═══════════════════════════════════════════════════════════════════════════

  /// Wrap in SafeArea.
  ///
  /// Usage: `Text('Hello').safeArea()`
  Widget safeArea({
    bool top = true,
    bool bottom = true,
    bool left = true,
    bool right = true,
  }) =>
      SafeArea(top: top, bottom: bottom, left: left, right: right, child: this);

  // ═══════════════════════════════════════════════════════════════════════════
  // SLIVER
  // ═══════════════════════════════════════════════════════════════════════════

  /// Convert to SliverToBoxAdapter.
  ///
  /// Usage: `Text('Hello').sliver()`
  Widget sliver() => SliverToBoxAdapter(child: this);

  // ═══════════════════════════════════════════════════════════════════════════
  // ANIMATIONS (using flutter_animate)
  // ═══════════════════════════════════════════════════════════════════════════

  /// Add fade in animation.
  ///
  /// Usage: `Text('Hello').fadeIn()`
  Widget fadeIn({Duration duration = const Duration(milliseconds: 300)}) =>
      animate().fadeIn(duration: duration);

  /// Add slide up animation.
  ///
  /// Usage: `Text('Hello').slideUp()`
  Widget slideUp({
    Duration duration = const Duration(milliseconds: 300),
    double beginOffset = 0.2,
  }) => animate()
      .fadeIn(duration: duration)
      .slideY(begin: beginOffset, end: 0, duration: duration);

  /// Add scale animation.
  ///
  /// Usage: `Text('Hello').scaleIn()`
  Widget scaleIn({
    Duration duration = const Duration(milliseconds: 300),
    double begin = 0.8,
  }) => animate()
      .fadeIn(duration: duration)
      .scale(begin: Offset(begin, begin), duration: duration);
}
