import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class CastingCards extends StatelessWidget {
  final List<Cast> actors;
  /* final List<Cast> casting; */

  const CastingCards( {super.key,  required this.actors}/*  this.casting */);
    

  @override
  Widget build(BuildContext context) {
    /*final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getActores();
    print('prueba Castingcards');
    print(moviesProvider.actores); 
    */ 

    return Container(
            margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            // color: Colors.red,
            child: ListView.builder(
                itemCount: actors.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context,
                        int index) /* {
                return _CastCard(casting[index]);
              }, */
                    =>
                     _CastCard(/* casting[index] */  actors[index]/* ,   index */)),
          );
        }

    /* FutureBuilder(
        future: moviesProvider.getCast(idPeli),
        builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          final casting = snapshot.data!;

          return Container(
            margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            // color: Colors.red,
            child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context,
                        int index) /* {
                return _CastCard(casting[index]);
              }, */
                    =>
                    _CastCard(casting[index])),
          );
        }); */

    /* final casting = snapshot.data!;

    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      width: double.infinity,
      height: 180,
      // color: Colors.red,
      child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) =>
              _CastCard(casting[index])),
    );*/
  }
 
/* } */

class _CastCard extends StatelessWidget {
  final Cast   cast;
  /* final int index; */
  
  const 
  _CastCard(this.cast/* , this.index */);

  @override
  Widget build(BuildContext context) {
    /* final castInd= cast[index];
    print('prueba _MoviePoster');    */

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      // color: Colors.green,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(cast.fullProfilePath /* 'assets/no-image.jpg' */),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            cast.name /* 'actor' */,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
