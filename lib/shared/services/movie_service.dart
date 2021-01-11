import 'package:desafio_tecnico_flutter/models/genres_response_model.dart';
import 'package:desafio_tecnico_flutter/models/movie_model.dart';
import 'package:desafio_tecnico_flutter/models/movie_response_model.dart';
import 'package:desafio_tecnico_flutter/shared/config/http_config.dart';
import 'package:dio/dio.dart';

class MovieService {
  final Dio _dio = Dio();

  var _urlGetMoviesByGenre = "${HttpConfig.apiUrl}/discover/movie";
  var _urlGetGenres = "${HttpConfig.apiUrl}/genre/movie/list";
  var _urlGetMovieDetails = "${HttpConfig.apiUrl}/movie";

  Future<MovieResponseModel> getMoviesByGenre(String genreId) async {
    var params = {
      "api_key": HttpConfig.apiKey,
      "language": "pt-BR",
      "page": 1,
      "with_genres": genreId
    };
    try {
      Response response =
          await _dio.get(_urlGetMoviesByGenre, queryParameters: params);
      return MovieResponseModel.fromJson(response.data);
    } catch (e) {
      print(e);
    }
  }

  Future<Movie> getMovieDetails(int movieId) async {
    var params = {
      "api_key": HttpConfig.apiKey,
      "language": "pt-BR",
      "append_to_response": "credits"
    };
    try {
      Response response = await _dio.get("$_urlGetMovieDetails/$movieId",
          queryParameters: params);
      return Movie.fromJson(response.data);
    } catch (e) {
      print(e);
    }
  }

  Future<GenresResponseModel> getGenres() async {
    var params = {"api_key": HttpConfig.apiKey, "language": "pt-BR"};
    try {
      Response response =
          await _dio.get(_urlGetGenres, queryParameters: params);
      return GenresResponseModel.fromJson(response.data);
    } catch (e) {
      print(e);
    }
  }
}

final MovieService movieService = MovieService();
