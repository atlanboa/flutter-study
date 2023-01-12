import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon/models/webtoon.dart';
import 'package:webtoon/models/webtoon_detail.dart';
import 'package:webtoon/models/webtoon_episode.dart';

class ApiService {
  static String baseUrl = 'https://webtoon-crawler.nomadcoders.workers.dev';
  static String today = "today";

  static Future<List<WebtoonModel>> getTodaysToon() async {
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      final parsedWebtoons =
          webtoons.map((webtoon) => WebtoonModel.fromJson(webtoon)).toList();
      return parsedWebtoons;
    } else {
      throw Error();
    }
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final dynamic webtoon = jsonDecode(response.body);
      final parsedWebtoons = WebtoonDetailModel.fromJson(webtoon);
      return parsedWebtoons;
    } else {
      throw Error();
    }
  }

  static Future<List<WebtoonEpisodeModel>> getToonEpisodesById(
      String id) async {
    final url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      final parsedWebtoons = webtoons
          .map((webtoon) => WebtoonEpisodeModel.fromJson(webtoon))
          .toList();
      return parsedWebtoons;
    } else {
      throw Error();
    }
  }
}
