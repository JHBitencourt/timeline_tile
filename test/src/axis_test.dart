import 'package:flutter_test/flutter_test.dart';
import 'package:timeline_tile/src/axis.dart';

void main() {
  group(
    'Must trow assert error with invalid axisPosition',
    () {
      test('Negative position', () {
        expect(
          () => calculateAxisPositioning(
            totalSize: 100,
            objectSize: 110,
            axisPosition: -0.5,
          ),
          throwsAssertionError,
        );
      });

      test('Bigger than 1 position', () {
        expect(
          () => calculateAxisPositioning(
            totalSize: 100,
            objectSize: 110,
            axisPosition: 1.2,
          ),
          throwsAssertionError,
        );
      });
    },
  );

  test('Exceeded object size must fit the total size', () {
    final positioning = calculateAxisPositioning(
      totalSize: 100,
      objectSize: 110,
      axisPosition: 0.5,
    );

    assertPositioning(
      positioning,
      totalSize: 100,
      expectedPositioning: AxisPosition(
        firstSpace: AxisCoordinates.zero(),
        objectSpace: const AxisCoordinates(start: 0, end: 100),
        secondSpace: AxisCoordinates.zero(),
      ),
    );
  });

  test('Must align object to the start if exceeds the size', () {
    final positioning = calculateAxisPositioning(
      totalSize: 88.6,
      objectSize: 23.3,
      axisPosition: 0.1,
    );

    assertPositioning(
      positioning,
      totalSize: 88.6,
      expectedPositioning: AxisPosition(
        firstSpace: AxisCoordinates.zero(),
        objectSpace: const AxisCoordinates(start: 0, end: 23.3),
        secondSpace: const AxisCoordinates(start: 23.3, end: 88.6),
      ),
    );
  });

  test('Must align object to the end if exceeds the size', () {
    final positioning = calculateAxisPositioning(
      totalSize: 88.6,
      objectSize: 23.3,
      axisPosition: 0.9,
    );

    assertPositioning(
      positioning,
      totalSize: 88.6,
      expectedPositioning: const AxisPosition(
        firstSpace: AxisCoordinates(start: 0, end: 65.3),
        objectSpace: AxisCoordinates(start: 65.3, end: 88.6),
        secondSpace: AxisCoordinates(start: 88.6, end: 88.6),
      ),
    );
  });

  test('Must divide equally when object size is zero', () {
    final positioning = calculateAxisPositioning(
      totalSize: 88.6,
      objectSize: 0,
      axisPosition: 0.5,
    );

    assertPositioning(
      positioning,
      totalSize: 88.6,
      expectedPositioning: const AxisPosition(
        firstSpace: AxisCoordinates(start: 0, end: 44.3),
        objectSpace: AxisCoordinates(start: 44.3, end: 44.3),
        secondSpace: AxisCoordinates(start: 44.3, end: 88.6),
      ),
    );
  });

  group(
    'Random positioning calculations',
    () {
      test('1', () {
        final positioning = calculateAxisPositioning(
          totalSize: 100,
          objectSize: 25,
          axisPosition: 0.5,
        );

        assertPositioning(
          positioning,
          totalSize: 100,
          expectedPositioning: const AxisPosition(
            firstSpace: AxisCoordinates(start: 0, end: 37.5),
            objectSpace: AxisCoordinates(start: 37.5, end: 62.5),
            secondSpace: AxisCoordinates(start: 62.5, end: 100),
          ),
        );
      });

      test('2', () {
        final positioning = calculateAxisPositioning(
          totalSize: 100,
          objectSize: 25,
          axisPosition: 0.7,
        );

        assertPositioning(
          positioning,
          totalSize: 100,
          expectedPositioning: const AxisPosition(
            firstSpace: AxisCoordinates(start: 0, end: 57.5),
            objectSpace: AxisCoordinates(start: 57.5, end: 82.5),
            secondSpace: AxisCoordinates(start: 82.5, end: 100),
          ),
        );
      });

      test('3', () {
        final positioning = calculateAxisPositioning(
          totalSize: 143.65,
          objectSize: 13.77,
          axisPosition: 0.2,
        );

        assertPositioning(
          positioning,
          totalSize: 143.65,
          expectedPositioning: const AxisPosition(
            firstSpace: AxisCoordinates(start: 0, end: 21.845000000000006),
            objectSpace: AxisCoordinates(
                start: 21.845000000000006, end: 35.61500000000001),
            secondSpace: AxisCoordinates(start: 35.61500000000001, end: 143.65),
          ),
        );
      });
    },
  );
}

void assertPositioning(
  AxisPosition positioning, {
  double totalSize,
  AxisPosition expectedPositioning,
}) {
  expect(totalSize, expectedPositioning.totalSize);
  expect(positioning, expectedPositioning);
}
