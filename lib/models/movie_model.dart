class Movie {
  final int id;
  final double popularity;
  final String title;
  final String backPoster;
  final String poster;
  final String overview;
  final double rating;
  final List<int> genreIds;

  Movie(this.id, this.popularity, this.title, this.backPoster, this.poster,
      this.overview, this.rating, this.genreIds);

  Movie.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        popularity = json["popularity"],
        title = json["title"],
        backPoster = json["backdrop_path"],
        poster = json["poster_path"],
        overview = json["overview"],
        rating = json["vote_average"].toDouble(),
        genreIds = json['genre_ids'].cast<int>();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.backPoster;
    data['vote_average'] = this.rating;
    data['genre_ids'] = this.genreIds;
    return data;
  }
}
