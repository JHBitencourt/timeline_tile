import 'dart:core';

import 'package:flutter/foundation.dart';

/// Given an axis that has an object positioned somewhere between the start and
/// end point, this represents the different sizes and coordinates of this axis.
@immutable
class AxisPosition {
  const AxisPosition({
    required this.firstSpace,
    required this.objectSpace,
    required this.secondSpace,
  });

  final AxisCoordinates firstSpace;
  final AxisCoordinates objectSpace;
  final AxisCoordinates secondSpace;

  double get totalSize => firstSpace.size + objectSpace.size + secondSpace.size;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AxisPosition &&
          runtimeType == other.runtimeType &&
          firstSpace == other.firstSpace &&
          objectSpace == other.objectSpace &&
          secondSpace == other.secondSpace;

  @override
  int get hashCode =>
      firstSpace.hashCode ^ objectSpace.hashCode ^ secondSpace.hashCode;

  @override
  String toString() {
    return 'AxisPosition{'
        'firstSpace: $firstSpace, '
        'objectSpace: $objectSpace, '
        'secondSpace: $secondSpace}';
  }
}

/// The coordinates to position an object into an axis.
@immutable
class AxisCoordinates {
  const AxisCoordinates({
    required this.start,
    required this.end,
  })  : size = end - start,
        assert(
          end >= start,
          'The end coordinate must be bigger or equals than the start coordinate',
        );

  factory AxisCoordinates.zero() {
    return const AxisCoordinates(start: 0, end: 0);
  }

  /// The position it starts
  final double start;

  /// The position it ends
  final double end;

  /// The sum of space between [start] and [end]
  final double size;

  double get center => start + (size / 2);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AxisCoordinates &&
          runtimeType == other.runtimeType &&
          start == other.start &&
          end == other.end &&
          size == other.size;

  @override
  int get hashCode => start.hashCode ^ end.hashCode ^ size.hashCode;

  @override
  String toString() {
    return 'AxisCoordinates{start: $start, end: $end, size: $size}';
  }
}

/// Given an axis (x or y) of [totalSize], this will calculate how to position
/// an object in the axis based on its [objectSize] and the [axisPosition].
/// If the object exceed the [totalSize] at the top or the bottom, it will
/// be aligned at the start or at the end with [_alignObject].
AxisPosition calculateAxisPositioning({
  required double totalSize,
  required double objectSize,
  required double axisPosition,
}) {
  if (axisPosition < 0.0 || axisPosition > 1.0) {
    throw AssertionError('The axisPosition must be provided and must be a value'
        ' between 0.0 and 1.0 inclusive');
  }

  if (objectSize >= totalSize)
    return _alignObject(
      totalSize: totalSize,
      objectSize: objectSize,
      alignEnd: true,
      alignStart: true,
    );

  final objectCenter = totalSize * axisPosition;
  final objectHalfSize = objectSize / 2;

  final firstSize = objectCenter - objectHalfSize;
  if (firstSize < 0)
    return _alignObject(
      totalSize: totalSize,
      objectSize: objectSize,
      alignStart: true,
    );

  final secondSize = totalSize - objectCenter - objectHalfSize;
  if (secondSize < 0)
    return _alignObject(
      totalSize: totalSize,
      objectSize: objectSize,
      alignEnd: true,
    );

  return AxisPosition(
    firstSpace: AxisCoordinates(start: 0, end: firstSize),
    objectSpace: AxisCoordinates(start: firstSize, end: firstSize + objectSize),
    secondSpace: AxisCoordinates(start: firstSize + objectSize, end: totalSize),
  );
}

AxisPosition _alignObject({
  required double totalSize,
  required double objectSize,
  bool alignStart = false,
  bool alignEnd = false,
}) {
  if (alignStart == false && alignEnd == false)
    throw AssertionError('Either alignTop or alignBottom must be true');

  if (alignStart && alignEnd)
    return AxisPosition(
      firstSpace: AxisCoordinates.zero(),
      objectSpace: AxisCoordinates(start: 0, end: totalSize),
      secondSpace: AxisCoordinates.zero(),
    );

  return AxisPosition(
    firstSpace: alignStart
        ? AxisCoordinates.zero()
        : AxisCoordinates(start: 0, end: totalSize - objectSize),
    objectSpace: alignStart
        ? AxisCoordinates(start: 0, end: objectSize)
        : AxisCoordinates(start: totalSize - objectSize, end: totalSize),
    secondSpace: alignEnd
        ? AxisCoordinates(start: totalSize, end: totalSize)
        : AxisCoordinates(start: objectSize, end: totalSize),
  );
}
