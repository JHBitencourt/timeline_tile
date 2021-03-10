## [2.0.0]

*** Breaking Changes ***

Stable null-safety support.

## [1.0.0]

*** Breaking Changes ***

API changes to support both vertical and horizontal timeline.

1. `TimelineAlign` changes:
- `TimelineAlign.left` renamed to `TimelineAlign.start`
- `TimelineAlign.right` renamed to `TimelineAlign.end`

2. Added `TimelineAxis` to control the `axis`.

3. `TimelineTile` changes:
* new parameter `TimelineAxis` axis
* `rightChild` renamed to `endChild`
* `leftChild` renamed to `startChild`
* `lineX` renamed to `lineXY`
* `topLineStyle` renamed to `beforeLineStyle`
* `bottomLineStyle` renamed to `afterLineStyle`

4. `LineStyle` changes:
* `width` renamed to `thickness`

5. `IndicatorStyle` changes:
* `indicatorY` renamed to `indicatorXY`

6. `TimelineDivider` changes:
* added parameter `axis` to support both axis 

## [0.1.2]

* Fixed assets from example 8


## [0.1.1]

* Health changes to the package


## [0.1.0]

* Initial release
