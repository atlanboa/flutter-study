import 'package:flutter/material.dart';
import 'package:instagram/instagram_list.dart';

class InstaBody extends StatelessWidget {
  const InstaBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Flexible(child: InstaList()),
      ],
    );
  }
}
