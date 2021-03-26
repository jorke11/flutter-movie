import 'package:flutter/material.dart';
import 'package:flutter_movie/src/models/pelicula_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  const CardSwiper({Key key, @required this.peliculas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10),
      child: new Swiper(
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {

          peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta';

          return  ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'detail',
                      arguments: peliculas[index]),
                  child: FadeInImage(
                      placeholder: AssetImage("assets/loading.gif"),
                      fit: BoxFit.cover,
                      image: NetworkImage(peliculas[index].getPosterImg())),
                ));
          
        },
        itemCount: 3,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
