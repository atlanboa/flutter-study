import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/webtoon_episode.dart';

class Episode extends StatelessWidget {
  const Episode({
    Key? key,
    required this.episode,
    required this.webtoonId,
  }) : super(key: key);

  final WebtoonEpisodeModel episode;
  final String webtoonId;

  onButtonTap() async {
    final url = Uri.parse(
        'https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}');
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.green[700],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 0.5,
              offset: const Offset(2, 2),
              blurStyle: BlurStyle.normal,
              color: Colors.black.withOpacity(0.5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                episode.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
