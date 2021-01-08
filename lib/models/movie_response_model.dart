import 'package:desafio_tecnico_flutter/models/movie_model.dart';

class MovieResponseModel {
  final List<Movie> movies;
  final String error;

  MovieResponseModel(this.movies, this.error);

  MovieResponseModel.fromJson(Map<String, dynamic> json)
      : movies = (json["results"] as List)
            .map((i) => new Movie.fromJson(i))
            .toList(),
        error = "";

  MovieResponseModel.withError(String errorValue)
      : movies = List(),
        error = errorValue;
}
