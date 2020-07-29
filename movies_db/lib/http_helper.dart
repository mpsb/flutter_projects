import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

import 'package:movies_db/movie.dart';

class HttpHelper {
  final String urlKey = 'api_key=abd9090ade0ce3e6a5a93b706f27fffb';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlUpcoming = '/upcoming?';
  final String urlLanguage = '&language=en-US';

  Future<List> getUpcoming() async {
    final String upcoming = urlBase + urlUpcoming + urlKey + urlLanguage;

    http.Response result = await http.get(upcoming);

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    }
    else {
      return null;
    }
  }
}