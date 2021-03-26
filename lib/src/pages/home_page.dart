import 'package:flutter/material.dart';
import 'package:flutter_movie/src/providers/peliculas_provider.dart';
import 'package:flutter_movie/src/search/search_delegate.dart';
import 'package:flutter_movie/src/widgets/card_swiper_widget.dart';
import 'package:flutter_movie/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final providers = new PeliculasProviders();

  @override
  Widget build(BuildContext context) {

    providers.getPopulares();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Peliculas en Cine"),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {
            showSearch(context: context, delegate: DataSearch(),
            // query: 'Hola'
            );
          })
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[_swiperTarjetas(), _footer(context)],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
        future: providers.getEnCines(),
        builder: (context, AsyncSnapshot<List> asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            return CardSwiper(peliculas: asyncSnapshot.data);
          } else {
            return Container(
                height: 400, child: Center(child: CircularProgressIndicator()));
          }
        });
  }

  Widget _footer(context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Populares",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          SizedBox(height: 10,),
          _listPopulares()
        ],
      ),
    );
  }

  _listPopulares() {
    return StreamBuilder(
      stream: providers.popularesStream,
      
      builder: (context,AsyncSnapshot<List> asyncSnapshot){

        if(asyncSnapshot.hasData){
          return MovieHorizontal(peliculas: asyncSnapshot.data,siguientePagina: providers.getPopulares);
        }else{
          return Center(child: CircularProgressIndicator());
        }
        
    });
  }
}
