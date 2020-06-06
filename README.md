# TimelineTile

A package to help build customisable timelines in Flutter.

---

## Getting Started

A Timeline consists in a group of TimelineTiles. To build a tile you can simply use:

```dart
TimelineTile()
```

This will build a default tile that aligns to the left, with a `height` of 100:

[img 1]

There are 4 types of alignment.
- `TimelineAlign.left`
- `TimelineAlign.right`
- `TimelineAlign.center`
- `TimelineAlign.manual`

The `left` and `right` alignment allows a child in their opposite sides. On the other hand, both `center` and `manual` allows children on both sides. For example, one tile widh alignment to the center:

```dart
TimelineTile(
  alignment: TimelineAlign.center,
  rightChild: Container(
    constraints: const BoxConstraints(
      minHeight: 120,
    ),
    color: Colors.lightGreenAccent,
  ),
  leftChild: Container(
    color: Colors.amberAccent,
  ),
);
```

When providing children to the tile the height will be as minimum as possible, so you can control it with a height constraint (at least minHeight). This way the tile knows how to size it properly.

[img 2]

### Manual aligning the idicator

With TimelineAlign.manual you can provide the lineX, which allows you to specify a value from 0.0 to 1.0, that represents a widht percentage. For example, aligning at 30% of the widht:

```dart
TimelineTile(
  alignment: TimelineAlign.manual,
  lineX: 0.3,
  rightChild: Container(
    constraints: const BoxConstraints(
      minHeight: 120,
    ),
    color: Colors.lightGreenAccent,
  ),
  leftChild: Container(
    color: Colors.amberAccent,
  ),
);
```

[img3]

### Is it the first or the last?

You can decide if a tile is the first os the last in a timeline. This way you control whether a top or bottom line must be rendered.

[img]

[See the implementation here]

### Start to make a timeline

You can finally start to combine some tiles to make a Timeline. The flag `hasIndicator` can control whether an indicator should or shouldn't be rendered.

[img4]

[See the implementation here]

### Customize the indicator as you wish

The default indicator is a circle, and you can customize it as you wish. With `IndicatorStyle` you can change the color, the Y position based on values from 0.0 to 1.0 or give it a padding. You must explicitly provide its width though.

[img]

[See the implementation here]

### Give an icon to the indicator

With `IconStyle` you can provide an Icon to be rendered inside the default indicator.

[img]

[See the implementation here]

### Or provide your custom indicator

With the indicator parameter you can customize the tile with your own indicator. However, you must control its size through both width and height parameters.

[img]

[See the implementation here]

### Customize the tile's line

With `LineStyle` you can customize both topLine and bottomLine.

[img]

[See the implementation here]

### Connect tiles with TimelineDivider

The `TimelineDivider` widget allows you to connect tiles that are aligned in different X axis, when combined with `TimelineAlign.manual`.

[img]

[See the implementation here]