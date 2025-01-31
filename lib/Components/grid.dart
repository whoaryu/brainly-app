
import 'package:flutter/material.dart';

import 'tile.dart';

class Grid extends StatelessWidget {
  const Grid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(36, 20, 36, 20),
      itemCount: 30,
      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          ),
      itemBuilder: (context, index) {
        return (Tile(index: index,));
    
      },
    );
  }
}
