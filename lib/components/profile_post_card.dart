import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media/data/models/post_model.dart';

class ProfilePostCard extends StatelessWidget {
  final PostModel post;
  const ProfilePostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          post.imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return SizedBox(
                width: 200,
                height: 200,
                //color: Colors.grey,
                child: Shimmer.fromColors(
                    baseColor: Colors.grey[800]!,
                    highlightColor: Colors.grey[700]!,
                    child: Container(
                      color: Colors.grey[800],
                    )));
          },
        ),
      ),
    ]);
  }
}
