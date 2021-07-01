import 'package:flutter/material.dart';

import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;

  CardSwiper({ required this.peliculas });


  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;
    


    return Container(
        padding: EdgeInsets.only(top: 10.0),
        
        child: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: _screenSize.width * 0.5, // Para sacar el 70% del ancho del dispositivo
          itemHeight: _screenSize.height * 0.5, // Para sacar el 50% del alto del dispositivo
          itemBuilder: (BuildContext context,int index){
            
            /*return Hero(
              tag: peliculas[index].id!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage( peliculas[index].getPosterImg() ),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover
                ),
              ),
            );*/
            return _card(context, peliculas[index]);
          },
          itemCount: peliculas.length,
          //pagination: new SwiperPagination(),
          //control: new SwiperControl(),
        ),
    );
  }

  Widget _card(BuildContext context, Pelicula pelicula){

    pelicula.uniqueId = '${ pelicula.id }-tarjeta';
    
    final card = Container(
        margin: EdgeInsets.only( right: 15.0 ),
        child: Hero(
          tag: pelicula.uniqueId!,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage( pelicula.getPosterImg() ),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
              height: 130.0,
            ),
          ),
        )
    );

    return GestureDetector(
      child: card,
      onTap: (){

        //print('Nombre de la pelicula ${pelicula.title}');
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);

      },
    );
  }
}