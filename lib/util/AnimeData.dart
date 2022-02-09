import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'Anime.dart';
import 'package:http/http.dart' as http;

class Animes extends ChangeNotifier {
  late List<Anime> _animes;
  int page = 1;

  Future<List<Anime>> initData() async {
    final response = await http.get(Uri.parse('https://api.aniapi.com/v1/anime?page=' + page.toString()));
    if (response.statusCode == 200) {
      _animes = getAnimesFromJson(response.body);
      notifyListeners();
      return _animes;
    } else {
      throw Exception('Failed to load Animes');
    }
  }

  List<Anime> get animes =>List.unmodifiable(_animes);

  getNextData() async {
    page++;
    final response = await http.get(Uri.parse('https://api.aniapi.com/v1/anime?page=' + page.toString()));
    if (response.statusCode == 200) {
      _animes = getAnimesFromJson(response.body);
    } else {
      throw Exception('Failed to load Animes');
    }
    notifyListeners();
    return _animes;
  }

  getRandomAnime() {
    notifyListeners();
    return _animes[Random().nextInt(_animes.length)];
  }
}