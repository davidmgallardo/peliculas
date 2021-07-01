import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';


class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal({ required this.peliculas, required this.siguientePagina });

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      
      //Para hacer el infiteScroll
      if( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200 ){
        //print('Cargar siguientes peliculas');
        siguientePagina();
      }

    });


   
    return Container(
      height: _screenSize.height * 0.25, // Esto hace más grande o más chico el tamaño
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: ( context, i ){
        
          return _tarjeta(context, peliculas[i]);
        },
        //children: _tarjetas(context),
      ),

    );

  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula){

    pelicula.uniqueId = '${ pelicula.id }-poster';
    
    final tarjeta = Container(
        margin: EdgeInsets.only( right: 15.0 ),
        child: Column(
          children: [
            Hero(
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
            ),
            SizedBox( height: 5.0),
            Text(
              pelicula.title.toString(),
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
            
          ],
        ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: (){

        //print('Nombre de la pelicula ${pelicula.title}');
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);

      },
    );
  }

  List<Widget> _tarjetas(BuildContext context){ //Este no se está usando 

    return peliculas.map( (pelicula) {

      return Container(
        margin: EdgeInsets.only( right: 15.0 ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage( pelicula.getPosterImg() ),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 130.0,
              ),
            ),
            SizedBox( height: 5.0),
            Text(
              pelicula.title.toString(),
              overflow: TextOverflow.ellipsis, // Para que ponga ... si el nombre de la película no entra
              style: Theme.of(context).textTheme.caption,
            ),
            
          ],
        ),
      );

    }).toList();

  }
}