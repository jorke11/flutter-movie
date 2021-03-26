import 'dart:async';
import 'dart:convert';

import 'package:flutter_movie/src/models/actores_model.dart';
import 'package:flutter_movie/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProviders {
  String _apiKey = '2f5eef0ad79f794aea094cbc6e762481';
  String _url = "api.themoviedb.org";
  String _languege = "es-ES";

  int _populares_page = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();

  final _popularesStremController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStremController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStremController.stream;

  void disposeStreams() {
    _popularesStremController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodeData["results"]);
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, "3/movie/now_playing",
        {'api_key': _apiKey, 'language': _languege});

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];

    _cargando = true;
    _populares_page++;

    final url = Uri.https(_url, "3/movie/popular", {
      'api_key': _apiKey,
      'language': _languege,
      'page': _populares_page.toString()
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);

    popularesSink(_populares);

    _cargando = false;

    return resp;
  }

  Future<List<Actor>> getActores(String pelicula_id) async {
    final url = Uri.https(_url, "3/movie/$pelicula_id/credits",
        {'api_key': _apiKey, 'language': _languege});

    return await _procesarRespuestaActor(url);
  }

  Future<List<Actor>> _procesarRespuestaActor(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final cast = new Cast.fromJsonList(decodeData["cast"]);
    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, "3/search/movie",
        {'api_key': _apiKey, 'language': _languege, 'query': query});

    return await _procesarRespuesta(url);
  }
}
