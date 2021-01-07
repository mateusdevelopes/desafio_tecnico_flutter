import 'package:desafio_tecnico_flutter/models/genre_model.dart';

class GenresModel {
  List<Genre> genres;

  GenresModel({this.genres});

  GenresModel.fromJson(Map<String, dynamic> json) {
    if (json['genres'] != null) {
      genres = new List<Genre>();
      json['genres'].forEach((v) {
        genres.add(new Genre.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.genres != null) {
      data['genres'] = this.genres.map((v) => v.toJson()).toList();
    }
    return data;
  }
}