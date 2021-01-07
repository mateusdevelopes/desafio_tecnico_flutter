import 'package:desafio_tecnico_flutter/models/movie_response_model.dart';
import 'package:desafio_tecnico_flutter/shared/config/http_config.dart';
import 'package:dio/dio.dart';
// import 'package:dio/dio.dart' as _dio;

class MovieService {
  final Dio _dio = Dio();
  final String apiKey = "3e2072000c4b87a8fa99e871dc24db80";
  var _urlGetMoviesByGenre = "${HttpConfig.apiUrl}/discover/movie";
  var _urlGetMovieDetails = "${HttpConfig.apiUrl}/movie";

  Future<MovieResponse> getMoviesByGenre(String genreId) async {
    var params = {
      "api_key": apiKey,
      "language": "pt-BR",
      "page": 1,
      "with_genres": genreId
    };
    try {
      Response response =
          await _dio.get(_urlGetMoviesByGenre, queryParameters: params);
      return MovieResponse.fromJson(response.data);
      // var list = (response.data as List).map((item) {
      //   return MovieResponse.fromJson(item);
      // }).toList();
    } on DioError catch (e) {
      print(e);
    }
  }
}

final MovieService movieService = MovieService();
