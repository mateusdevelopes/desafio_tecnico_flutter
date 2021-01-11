import 'package:desafio_tecnico_flutter/models/credits_model.dart';
import 'package:desafio_tecnico_flutter/models/genre_model.dart';
import 'package:desafio_tecnico_flutter/models/production_companies_model.dart';

class Movie {
  int id;
  int runtime;
  int budget;
  String title;
  String originalTitle;
  String releaseDate;
  String backPoster;
  String poster;
  String overview;
  double voteAverage;
  List<Genre> genres;
  List<ProductionCompanies> productionCompanies;
  Credits credits;

  Movie(
      this.id,
      this.runtime,
      this.budget,
      this.title,
      this.originalTitle,
      this.releaseDate,
      this.backPoster,
      this.poster,
      this.overview,
      this.voteAverage,
      this.genres,
      this.productionCompanies,
      this.credits);

  Movie.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    runtime = json["runtime"];
    budget = json["budget"];
    title = json["title"];
    originalTitle = json["original_title"];
    releaseDate = json["release_date"];
    backPoster = json["backdrop_path"];
    poster = json["poster_path"];
    overview = json["overview"];
    voteAverage = json["vote_average"].toDouble();
    if (json['genres'] != null) {
      genres = new List<Genre>();
      json['genres'].forEach((v) {
        genres.add(new Genre.fromJson(v));
      });
    }
    if (json['production_companies'] != null) {
      productionCompanies = new List<ProductionCompanies>();
      json['production_companies'].forEach((v) {
        productionCompanies.add(new ProductionCompanies.fromJson(v));
      });
    }
    credits =
        json['credits'] != null ? new Credits.fromJson(json['credits']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['runtime'] = this.runtime;
    data['budget'] = this.budget;
    data['title'] = this.title;
    data['original_title'] = this.originalTitle;
    data['release_date'] = this.releaseDate;
    data['overview'] = this.overview;
    data['poster_path'] = this.backPoster;
    data['vote_average'] = this.voteAverage;
    if (this.genres != null) {
      data['genres'] = this.genres.map((v) => v.toJson()).toList();
    }
    if (this.productionCompanies != null) {
      data['production_companies'] =
          this.productionCompanies.map((v) => v.toJson()).toList();
    }
    if (this.credits != null) {
      data['credits'] = this.credits.toJson();
    }
    return data;
  }
}
