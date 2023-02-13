import 'package:flutter/material.dart';
import 'package:movies_app/models/movies.dart';


class MovieSlider extends StatelessWidget {


  final List<Movie> popMovies;

  //constructor para la variable
  const MovieSlider({Key? key, required this.popMovies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Populars',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (context, index) =>
                    _MoviePoster(popmovie: popMovies,indice: index )),
            
          )
          
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
 

  final List<Movie> popmovie;
  final int indice;


  const _MoviePoster(
      {Key? key,required this.popmovie, required this.indice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final popmovieInd= popmovie[indice];
    /* final Movie peli =
        popmovieInd as Movie; */
    
    return Container(
      width: 130,
      height: 190,
      /* color: Colors.green, */
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
/* //variable que almacena la movie individual
            final popmovie= popMovies[index];
            print(popmovie.posterPath); */

        children: [
          /* //variable que almacena la movie individual
            final popmovie= popMovies[index];
            print(popmovie.posterPath); */

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments: popmovieInd),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(popmovieInd.fullPosterPath),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            popmovieInd.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
