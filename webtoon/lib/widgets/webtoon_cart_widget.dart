import 'package:flutter/material.dart';

class WebtoonCard extends StatelessWidget {
  final String title, thumb, id;

  const WebtoonCard({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 250,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                offset: const Offset(10, 10),
                color: Colors.black.withOpacity(0.5),
              ),
            ],
          ),
          child: Image.network(thumb),
        ),
        const SizedBox(
          height: 10,
        ),
        Material(
          color: Colors.white.withOpacity(0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w200,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
