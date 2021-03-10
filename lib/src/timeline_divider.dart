import 'package:flutter/material.dart';
import 'package:timeline_tile/src/tile.dart';

/// This is a port from the original [Divider].
/// Except that this one allows to define the start and end
/// according to the width available, with percentage values
/// from 0.0 to 1.0
class TimelineDivider extends StatelessWidget {
  /// Creates a material design divider that can be used in conjunction to [TimelineTile].
  const TimelineDivider({
    Key? key,
    this.axis = TimelineAxis.horizontal,
    this.thickness = 2,
    this.begin = 0.0,
    this.end = 1.0,
    this.color = Colors.grey,
  })  : assert(thickness >= 0.0, 'The thickness must be a positive value'),
        assert(begin >= 0.0 && begin <= 1.0,
            'The begin value must be between 0.0 and 1.0'),
        assert(end >= 0.0 && end <= 1.0,
            'The end value must be between 0.0 and 1.0'),
        assert(end > begin, 'The end value must be bigger than the begin'),
        super(key: key);

  /// The axis used to render the line at the [TimelineAxis.vertical]
  /// or [TimelineAxis.horizontal]. Usually, the opposite axis from the tiles.
  /// It defaults to [TimelineAxis.horizontal].
  final TimelineAxis axis;

  /// The thickness of the line drawn within the divider.
  ///
  /// It must be a positive value. It defaults to 2.
  final double thickness;

  /// Where the line must start to be drawn.
  /// This represents a percentage from the available width.
  ///
  /// It must be less than [end] and defaults to 0.0.
  final double begin;

  /// Where the drawn from the line must end.
  /// This represents a percentage from the available width.
  ///
  /// It must be bigger than [begin] and defaults to 1.0.
  final double end;

  /// The color to use when painting the line.
  ///
  /// It defaults to [Colors.grey].
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double halfThickness = thickness / 2;

        EdgeInsetsDirectional margin;
        if (axis == TimelineAxis.horizontal) {
          final double width = constraints.maxWidth;
          final double beginX = width * begin;
          final double endX = width * end;

          margin = EdgeInsetsDirectional.only(
            start: beginX - halfThickness,
            end: width - endX - halfThickness,
          );
        } else {
          final double height = constraints.maxHeight;
          final double beginY = height * begin;
          final double endY = height * end;

          margin = EdgeInsetsDirectional.only(
            top: beginY - halfThickness,
            bottom: height - endY - halfThickness,
          );
        }

        return Container(
          height: thickness,
          margin: margin,
          decoration: BoxDecoration(
            border: Border(
              left: axis == TimelineAxis.vertical
                  ? BorderSide(
                      color: color,
                      width: thickness,
                    )
                  : BorderSide.none,
              bottom: axis == TimelineAxis.horizontal
                  ? BorderSide(
                      color: color,
                      width: thickness,
                    )
                  : BorderSide.none,
            ),
          ),
        );
      },
    );
  }
}
