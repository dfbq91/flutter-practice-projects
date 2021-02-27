class Movies {
  List<Movie> moviesList = List();

  Movies(); // Constructor

  Movies.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) {
      return;
    }

    for (var item in jsonList) {
      final movie = new Movie.fromJsonMap(item);
      moviesList.add(movie);
    }
  }
}

class Movie {
  String uniqueId;

  int voteCount;
  int id;
  bool video;
  String title;
  double popularity;
  double voteAverage;
  bool adult;
  String backdropPath;
  int budget;
  List<int> genres;
  String homepage;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;

  String posterPath;
  String releaseDate;
  int revenue;
  int runtime;
  String status;
  String tagline;

  Movie({
    this.adult,
    this.backdropPath,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  Movie.fromJsonMap(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    budget = json['budget'];
    genres = json['genres'];
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'] / 1;
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    revenue = json['revenue'];
    runtime = json['runtime'];
    status = json['status'];
    tagline = json['tagline'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'] / 1;
    voteCount = json['vote_count'];
  }

  getMovieImage() {
    if (posterPath == null) {
      return 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png';
    }
    return 'https://image.tmdb.org/t/p/w500/$posterPath';
  }

  getBackgroundImage() {
    if (posterPath == null) {
      return 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png';
    }
    return 'https://image.tmdb.org/t/p/w200/$backdropPath';
  }
}
