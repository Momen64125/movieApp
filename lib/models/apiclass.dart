class Filmclass{
  late String ?backdrop_path;
  late String ?poster_path;
  late String ?overview;
  late String ?origin_country;
  late String ?original_language;
  late var vote_count;
  Filmclass({required this.overview,required this.origin_country,required this.backdrop_path,
    required this.poster_path,required this.original_language,required this.vote_count});
  factory Filmclass.fromJson(Map<String,dynamic>json){
    return  Filmclass(overview:json['title'],
      origin_country:json['publishedAt'],
      backdrop_path:json['backdrop_path'],
      poster_path:json['backdrop_pat'],
      original_language:json['original_language'],
      vote_count:json['vote_count'],

    );
  }

}