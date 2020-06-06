# TimelineTile

A package to help build customisable timelines in Flutter.

---

## Example

- You can access the [example](https://github.com/JHBitencourt/timeline_tile/tree/master/example) project for a Timeline Showcase.
- The [Beautiful Timelines]() contains real world design examples.
- Or try the [web demo]()

Some use cases:

<div style="text-align: center">
    <table>
        <tr>
            <td style="text-align: center">
                <img src="https://raw.githubusercontent.com/JHBitencourt/timeline_tile/master/screenshots/gifs/showcase_timeline.gif" width="200"/>
      </br><b>Timeline Showcase</b>
            </td>            
            <td style="text-align: center">
                <img src="https://raw.githubusercontent.com/JHBitencourt/timeline_tile/master/screenshots/gifs/football_timeline.gif" width="200"/>
      </br><b>Football Timeline</b>
            </td>
            <td style="text-align: center">
                <img src="https://raw.githubusercontent.com/JHBitencourt/timeline_tile/master/screenshots/gifs/activity_timeline.gif" width="200"/>
      </br><b>Activity Timeline</b>
            </td>
        </tr>
        <tr>
            <td style="text-align: center">
                <img src="https://raw.githubusercontent.com/JHBitencourt/timeline_tile/master/screenshots/gifs/success_timeline.gif" width="200"/>
      </br><b>Success Timeline</b>
            </td>
            <td style="text-align: center">
                <img src="https://raw.githubusercontent.com/JHBitencourt/timeline_tile/master/screenshots/delivery_timeline.png" width="200"/>
  </br><b>Delivery Timeline</b>
            </td>
            <td style="text-align: center">
                <img src="https://raw.githubusercontent.com/JHBitencourt/timeline_tile/master/screenshots/weather_timeline.png" width="200"/>
  </br><b>Weather Timeline</b>
            </td>
        </tr>
    </table>
</div>

## Getting Started

A Timeline consists in a group of TimelineTiles. To build a tile you can simply use:

```dart
TimelineTile()
```

This will build a default tile that aligns to the left, with a `height` of 100:

![Simple Timeline](https://raw.githubusercontent.com/JHBitencourt/timeline_tile/master/screenshots/simple_timeline.png)

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

![Centered Tile](https://raw.githubusercontent.com/JHBitencourt/timeline_tile/master/screenshots/centered_tile_with_children.png)

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

![Manual align indicator](https://raw.githubusercontent.com/JHBitencourt/timeline_tile/master/screenshots/manual_align_indicator.png)

### Is it the first or the last?

You can decide if a tile is the first os the last in a timeline. This way you control whether a top or bottom line must be rendered.

![First and last](https://raw.githubusercontent.com/JHBitencourt/timeline_tile/master/screenshots/first_and_last.png)

[See the implementation here]

### Start to make a timeline

You can finally start to combine some tiles to make a Timeline. The flag `hasIndicator` can control whether an indicator should or shouldn't be rendered.

![Timelien](https://raw.githubusercontent.com/JHBitencourt/timeline_tile/master/screenshots/start_to_make_timeline.png)

[See the implementation here]

### Customize the indicator as you wish

The default indicator is a circle, and you can customize it as you wish. With `IndicatorStyle` you can change the color, the Y position based on values from 0.0 to 1.0 or give it a padding. You must explicitly provide its width though.

![Custom indicator](https://raw.githubusercontent.com/JHBitencourt/timeline_tile/master/screenshots/customize_indicator.png)

[See the implementation here]

### Give an icon to the indicator

With `IconStyle` you can provide an Icon to be rendered inside the default indicator.

![Icon indicator](https://raw.githubusercontent.com/JHBitencourt/timeline_tile/master/screenshots/indicator_icon.png)

[See the implementation here]

### Or provide your custom indicator

With the indicator parameter you can customize the tile with your own indicator. However, you must control its size through both width and height parameters.

![Custom indicator](https://raw.githubusercontent.com/JHBitencourt/timeline_tile/master/screenshots/custom_indicator.png)

[See the implementation here]

### Customize the tile's line

With `LineStyle` you can customize both topLine and bottomLine.

![Custom line](https://raw.githubusercontent.com/JHBitencourt/timeline_tile/master/screenshots/custom_line.png)

[See the implementation here]

### Connect tiles with TimelineDivider

The `TimelineDivider` widget allows you to connect tiles that are aligned in different X axis, when combined with `TimelineAlign.manual`.

![Timeline divider](https://raw.githubusercontent.com/JHBitencourt/timeline_tile/master/screenshots/timeline_divider.png)

[See the implementation here]
