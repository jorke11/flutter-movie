import 'package:flutter/material.dart';
import 'package:flutter_movie/src/models/pelicula_model.dart';
import 'package:flutter_movie/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  final peliculasProvider = new PeliculasProviders();

  final peliculas = [
    'Spiderman',
    'Capitan america',
    'Aquaman',
    'Iron man',
    'Iron man 1',
    'Iron man 2',
    'Iron man 3',
    'Iron man 4',
    'Batman',
  ];

  String seleccion = "";

  final peliculasRecientes = ['Spiderman', 'Capitan america'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones del appbar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono izquierda de la appbar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults

    return Center(
      child: Container(
        height: 100,
        width: 100,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
        future: peliculasProvider.buscarPelicula(query),
        builder: (context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if (snapshot.hasData) {
            final peliculas = snapshot.data;
            return ListView(
              children: peliculas.map((pelicula) {
                return ListTile(
                  leading: FadeInImage(
                      placeholder: AssetImage("assets/loading.gif"),
                      image: NetworkImage(pelicula.getPosterImg()),
                      fit: BoxFit.contain
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: (){
                  close(context,null);
                  pelicula.uniqueId="";
                  Navigator.pushNamed(context, "detail",arguments: pelicula);
                },
                );
              }).toList()
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // TODO: implement buildSuggestions

  //   final listaSugerida = query.isEmpty
  //       ? peliculasRecientes
  //       : peliculas.where((p) => p.toLowerCase().startsWith(query)).toList();

  //   return ListView.builder(
  //       itemCount: listaSugerida.length,
  //       itemBuilder: (context, i) {
  //         return ListTile(
  //           leading: Icon(Icons.movie),
  //           title: Text(listaSugerida[i]),
  //           onTap: () {
  //             seleccion = listaSugerida[i];
  //             showResults(context);
  //           },
  //         );
  //       });
  // }
}
