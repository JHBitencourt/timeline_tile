import 'package:flutter/material.dart';
import 'package:timeline_tile/src/tile.dart';

/// Used to customize the indicator from the line.
class IndicatorStyle {
  const IndicatorStyle({
    this.width = 20,
    this.height = 20,
    this.indicator,
    this.padding = const EdgeInsets.all(0),
    this.color = Colors.grey,
    this.iconStyle,
    this.indicatorXY = 0.5,
    this.drawGap = false,
  })  : assert(width >= 0,
            'The width must be provided and bigger than 0.0'),
        assert(height >= 0,
            'The height must be provided and bigger than 0.0');

  /// The width from the indicator.
  /// It defaults to 20.
  /// Ignored in case the default indicator is rendered and the tile axis
  /// is [TimelineAxis.horizontal].
  final double width;

  /// The height from the indicator.
  /// It defaults to 20.
  /// Ignored in case the default indicator is rendered and the tile axis
  /// is [TimelineAxis.vertical].
  final double height;

  /// A custom widget to use as indicator. if not provided it will be rendered a
  /// default circle as indicator.
  final Widget? indicator;

  /// The padding used with the indicator. It defaults to 0.
  final EdgeInsets padding;

  /// The color used to paint the default indicator. It defaults to ([Colors.grey]).
  final Color color;

  /// The style of the icon used inside the default indicator, if any.
  /// It will only be used with the default indicator, and ignored in case there
  /// is a custom indicator provided.
  final IconStyle? iconStyle;

  /// Value from 0.0 to 1.0 indicating the percentage in which the indicator
  /// should be positioned on the line, either on Y if [TimelineAxis.vertical]
  /// or X if [TimelineAxis.horizontal].
  /// For example, 0.2 means 20% from start to end. It defaults to 0.5.
  final double indicatorXY;

  /// If the line must not be drawn behind the icon. If true, there will be a gap
  /// even if the vertical/horizontal padding is 0. It defaults to false.
  final bool drawGap;

  /// The total indicator height, including padding.
  double get totalHeight => height + padding.top + padding.bottom;

  /// The total indicator width, including padding.
  double get totalWidth => width + padding.left + padding.right;
}

/// Used to customize the icon used with the default indicator.
class IconStyle {
  IconStyle({
    required this.iconData,
    this.color = Colors.black,
    this.fontSize,
  });

  /// The icon to render.
  final IconData iconData;

  /// The color used to paint the icon. It defaults to ([Colors.black]).
  final Color color;

  /// The fontSize from the line. If not provided, it will try to adjust the
  /// icon size based on the default indicator size. According to ([IndicatorStyle.width]).
  final double? fontSize;
}

/// Used to customize the line
class LineStyle {
  const LineStyle({
    this.color = Colors.grey,
    this.thickness = 4,
  });

  /// The color used to paint the line. It defaults to ([Colors.grey]).
  final Color color;

  /// The thickness from the line. It can't be bigger than ([IndicatorStyle.width])
  /// and defaults to 4.
  final double thickness;
}
