import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:movies_app/src/models/actors_model.dart';
import 'package:movies_app/src/models/movie_model.dart';

class MoviesProvider {
  // API data
  String _apiKey = '4a8f61dda738fdb193850e7635cd8594';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-ES';
  int _mostViewedPage = 0;

  List<Movie> _mostViewed = new List();
  bool _isLoading = false;

  // Streams
  final _mostViewedStreamCtllr = StreamController<List<Movie>>.broadcast();
  Function(List<Movie>) get mostViewedSink => _mostViewedStreamCtllr.sink.add;
  Stream<List<Movie>> get mostViewedStream => _mostViewedStreamCtllr.stream;

  void disposeStreams() {
    _mostViewedStreamCtllr?.close();
  }

  Future<List<Movie>> _processResponse(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final movies = Movies.fromJsonList(decodedData['results']);
    return movies.moviesList;
  }

  Future<List<Movie>> getNowInCinemas() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'languaje': _languaje});

    return await _processResponse(url);
  }

  Future<List<Movie>> getMostViewedMovies() async {
    if (_isLoading) {
      return [];
    }

    _isLoading = true;

    _mostViewedPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'languaje': _languaje,
      'page': _mostViewedPage.toString()
    });

    final List<Movie> response = await _processResponse(url);

    _mostViewed.addAll(response);
    mostViewedSink(_mostViewed);
    _isLoading = false;

    return response;
  }

  Future<List<Actor>> getCast(String movieId) async {
    final url = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key': _apiKey,
      'languaje': _languaje,
    });

    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);
    return cast.actors;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apiKey, 'languaje': _languaje, 'query': query});

    return await _processResponse(url);
  }
}
