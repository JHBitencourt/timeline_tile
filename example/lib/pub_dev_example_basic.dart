// Basic example of how to get started

import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: TimeLineTileExample()));
}

class TimeLineTileExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return TimelineTile(
          // Indicates this is the first item of the listview is the first item
          //  of the timeline. Removes line before this item.
          isFirst: index == 0,
          // Indicates this is the 4th item of the listview is the last item
          //  of the timeline. Removes line after this item.
          isLast: index == 3,
        );
      },
    );
  }
}
