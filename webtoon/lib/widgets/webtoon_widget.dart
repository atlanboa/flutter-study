import 'package:flutter/material.dart';
import 'package:webtoon/screens/detail_screen.dart';
import 'package:webtoon/widgets/webtoon_cart_widget.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              thumb: thumb,
              id: id,
            ),
          ),
        );
      },
      child: Hero(
        tag: id,
        child: WebtoonCard(
          title: title,
          thumb: thumb,
          id: id,
        ),
      ),
    );
  }
}
