import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {

  final peliculasProvider = new PeliculasProvider();


  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Películas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton( 
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch( // Para realizar las búsquedas
                context: context, 
                delegate: DataSearch(),
                //query: 'Hola'
              );
            }
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // Esto es para que haya espacio entre los componentes
          children: [
            _swiperTarjetas(),
            _footer(context)
          ],
        )
      ),
      
    );
  }


  Widget _swiperTarjetas(){

    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if ( snapshot.hasData ) {
          return CardSwiper( peliculas: snapshot.data );
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }

        
      },
    );

  }

  Widget _footer(BuildContext context){

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Para poner al principio. Se usa crossaxisaligment al ser una columna
        children: [
          Container( // se mete el texto dentro de un contenedor para darle formato. Por ejemplo separarlo del borde 20.0 pixeles
            padding: EdgeInsets.only( left: 20.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subtitle1 )
          ),
          SizedBox( height: 5.0),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              //snapshot.data?.forEach((p) => print(p.title)); //Para imprimir todos los nombres de películas que devuelve el método getPopulares. La ? es para indicar que se haga el forEach si existe data
              if( snapshot.hasData ){
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              } else {
                return Center(child: CircularProgressIndicator()); // Se envuelve dentro de un Center para que el progressindicator aparezca en el medio
              }
            },
          ),
        ],
      ),
    );

  }

}