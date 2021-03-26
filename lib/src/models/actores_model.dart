import 'package:flutter_movie/src/models/pelicula_model.dart';

class Cast{
  List<Actor> actores = new List();

  Cast.fromJsonList(List<dynamic> jsonList){
    if (jsonList==null) return ;

    jsonList.forEach((item){
      final Actor actor = Actor.fromJSonMap(item);
      actores.add(actor);
    });

    
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJSonMap(Map<String,dynamic> json){
    castId = json["cast_id"];
    character = json["character"];
    creditId = json["credit_id"];
    gender = json["gender"];
    id = json["id"];
    name = json["name"];
    order = json["order"];
    profilePath = json["profile_path"];
  }

    getPhoto() {
    if (profilePath == null) {
      return 'https://image.shutterstock.com/image-vector/no-image-available-sign-absence-600w-373243873.jpg';
    } else {
      return 'http://image.tmdb.org/t/p/w500/${profilePath}';
    }
  }
}
