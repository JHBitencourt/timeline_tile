import 'package:flutter/material.dart';

/// Used to customize the indicator from the line.
class IndicatorStyle {
  const IndicatorStyle({
    @required this.width,
    this.indicator,
    this.padding = const EdgeInsets.all(0),
    this.height = 20,
    this.color = Colors.grey,
    this.iconStyle,
    this.indicatorY = 0.5,
    this.drawGap = false,
  }) : assert(width != null && width >= 0,
            'The width must be provided and bigger than 0.0');

  /// The width from the indicator
  final double width;

  /// A custom widget to use as indicator. if not provided it will be rendered a
  /// default circle as indicator.
  final Widget indicator;

  /// The padding used with the indicator. It defaults to 0.
  final EdgeInsets padding;

  /// The height from the indicator. Ignored in case the default indicator is rendered.
  /// It defaults to 20.
  final double height;

  /// The color used to paint the default indicator. It defaults to ([Colors.grey]).
  final Color color;

  /// The style of the icon used inside the default indicator, if any.
  /// It will only be used with the default indicator, and ignored in case there
  /// is a custom indicator provided.
  final IconStyle iconStyle;

  /// Value from 0.0 to 1.0 indicating the percentage in which the indicator
  /// should be positioned on the line, starting from the top.
  /// For example, 0.2 means 20% from top to bottom. It defaults to 0.5.
  final double indicatorY;

  /// If the line must not be drawn behind the icon. If true, there will be a gap
  /// even if the vertical padding is 0. It defaults to false.
  final bool drawGap;
}

/// Used to customize the icon used with the default indicator.
class IconStyle {
  IconStyle({
    @required this.iconData,
    this.color = Colors.black,
    this.fontSize,
  }) : assert(iconData != null, 'The iconData must be provided');

  /// The icon to render.
  final IconData iconData;

  /// The color used to paint the icon. It defaults to ([Colors.black]).
  final Color color;

  /// The fontSize from the line. If not provided, it will try to adjust the
  /// icon size based on the default indicator size. According to ([IndicatorStyle.width]).
  final double fontSize;
}

/// Used to customize the line
class LineStyle {
  const LineStyle({
    this.color = Colors.grey,
    this.width = 4,
  });

  /// The color used to paint the line. It defaults to ([Colors.grey]).
  final Color color;

  /// The width from the line. It can't be bigger than ([IndicatorStyle.width])
  /// and defaults to 10.
  final double width;
}
