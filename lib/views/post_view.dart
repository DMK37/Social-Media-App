import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostView extends StatelessWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        'https://t4.ftcdn.net/jpg/05/49/98/39/360_F_549983970_bRCkYfk0P6PP5fKbMhZMIb07mCJ6esXL.jpg'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "qwerty",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz_rounded))
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              child: Image.network(
                  'https://www.dpreview.com/files/p/articles/7961724650/Lesson-4-Yarra-Ranges-Road-Black-Spur-Mountain-Ash.jpeg',
                  fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_outline)),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "123",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        
                      },
                      icon: const Icon(FontAwesomeIcons.comment)),
                  Text(
                    "7",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.bookmark_border_outlined)),
                ],
              ),
            )
          ],
        ));
  }
}
