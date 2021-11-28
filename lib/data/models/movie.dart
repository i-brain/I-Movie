class Movie {
  Movie({
    required this.imageUrl,
    required this.name,
    required this.genre,
    required this.imdb,
    required this.date,
    required this.story,
    required this.runtime,
    this.timeStamp,
    this.isFavorite = false,
  });

  final String name;
  final String genre;
  final String imdb;
  final String date;
  final String imageUrl;
  final String story;
  final String runtime;
  final bool isFavorite;
  final dynamic timeStamp;

  factory Movie.fromApiJson(Map<String, dynamic> data) {
    return Movie(
      name: data['Title'],
      genre: data['Genre'],
      imdb: data['imdbRating'],
      date: data['Year'],
      imageUrl: data['Poster'],
      story: data['Plot'],
      runtime: data['Runtime'],
    );
  }

  factory Movie.fromFirstoreJson(data) {
    return Movie(
      name: data['name'],
      genre: data['genre'],
      imdb: data['imdb'],
      date: data['date'],
      imageUrl: data['imageUrl'],
      story: data['story'],
      runtime: data['runtime'],
      timeStamp: data['timeStamp'],
      isFavorite: true,
    );
  }
}
