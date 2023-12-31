import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_media/components/post_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image(
          image: AssetImage("images/photocraft.png"),
          height: 50,
          width: 50,
        ),
      ),
      body: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 20,
        itemBuilder: (context, index) {
          return const PostCard();
        },
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final int index;
  final double extent;

  Tile({required this.index, required this.extent});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: SizedBox(
        height: extent,
        width: extent,
        child: Center(
          child: Text(
            'Tile $index',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
