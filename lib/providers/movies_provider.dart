import 'package:flutter/widgets.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:movies_app/models/models.dart';

import '../models/popular_response.dart';

//esta clase contendra la info que obtenemos al hacer el llamado a la API mediante el metodo getOnDisplayMovies
class MoviesProvider extends ChangeNotifier {
  String baseURL = 'api.themoviedb.org';
  String apiKey = '75b099443d532c163b7920c7b733b9d5';
  String language = 'es-ES';
  String page = '1';

  //creamos un array de Peliculas donde se almacenarán las que yo necesite
  List<Movie> onDisplayMovies = [];

  //creamos un array de Peliculas donde se almacenarán las que yo necesite
  List<Movie> popularMovies = [];

  //Lista con el numero de peli y el cast de cada una
  Map<int, List<Cast>> casting = {};

  List<Cast> actores = [];

  MoviesProvider() {
    print('Movies Provider initializat!');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

//Metodo que hace la llamada a la API para obtener la info de las pelis
  getOnDisplayMovies() async {
    //creo una variable que almacenará el URL que se pasará a la API yq de la cual obtendremos su información
    var url = Uri.https(baseURL, '3/movie/now_playing',
        {'api_key': apiKey, 'language': language, 'page': page});

//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------PETICION QUE VENÍA ORIGINALMENTE-------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

    //creo una variable que almacenará el resultado de la petición a la API: GET(lo que se hace en este caso), PULL, PUSH, ETC
    /* var response = await http.get(url);
    if (response.statusCode == 200) {
      //convertimos lo que devuelve el servidor en una variable mapeada de tipo JSON
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var itemCount = jsonResponse['results'];
      print('Number of books about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    } */

//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------PETICION NUEVA QUE CREAMOS-------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
    final result = await http.get(
        url); //final que almacena el contenido de la peticion a la API en formato JSON
    print('result getmovies');
    print(result);

    final nowPlayingResponse = NowPlayingResponse.fromJson(result
        .body); //final que almacena el body de la peticion hecha usando la estructura de la clase NowPlayingResponse

    onDisplayMovies = nowPlayingResponse
        .results; //añadimos a la lista que creamos antes la información del body en formato objeto

    //aunque la lista se relleno nosotros la pasamos al home screen inicialmente vacia y si no nos encargamos de notificar el cambio de valores la lista estará vacia siempre, pro ello:
    notifyListeners();
  }

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//Metodo que hace la llamada a la API para obtener la info de las pelis populares
  getPopularMovies() async {
    //creo una variable que almacenará el URL que se pasará a la API yq de la cual obtendremos su información
    var url = Uri.https(baseURL, '3/movie/popular',
        {'api_key': apiKey, 'language': language, 'page': page});

    final result = await http.get(url);
    //final que almacena el contenido de la peticion a la API en formato JSON
    print('result popmovies');
    print(result);

    final popularResponse = PopularResponse.fromJson(result.body);
    //final que almacena el body de la peticion hecha usando la estructura de la clase NowPlayingResponse

    popularMovies = popularResponse.results;
    //añadimos a la lista que creamos antes la información del body en formato objeto

    //aunque la lista se relleno nosotros la pasamos al home screen inicialmente vacia y si no nos encargamos de notificar el cambio de valores la lista estará vacia siempre, pro ello:
    notifyListeners();
  }

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  //Metodo que hace la llamada a la API para que la variable actores (lista de cast) obtenga todos los actores de la peli
  getActores(/* int idMovie */) async {
    

    //creo una variable que almacenará el URL que se pasará a la API yq de la cual obtendremos su información    $idMovie
    var url = Uri.https(baseURL, '3/movie/505642/credits',
        {'api_key': apiKey, 'language': language});
        
    //EL PROBLEMA ESTA AQUIIIIIIIIII!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    final result = await http.get(url);
    //final que almacena el contenido de la peticion a la API en formato JSON
    print('result getactores');
print(result);

    final newCreditsResponse = CreditsResponse.fromJson(result.body);
    //final que almacena el body de la peticion hecha usando la estructura de la clase NowPlayingResponse
print('prueba newcreditresponse');
    
    actores =  newCreditsResponse.cast;
    //añadimos a la lista que creamos antes la información del body en formato objeto

    print(actores);
    print('prueba actores');
    //aunque la lista se relleno nosotros la pasamos al home screen inicialmente vacia y si no nos encargamos de notificar el cambio de valores la lista estará vacia siempre, pro ello:
    notifyListeners();
  }
}



/* METODO CON FUTURE (RETURN)
//Metodo que hace la llamada a la API para obtener el cast de las pelis
  Future<Map<int, List<Cast>>> getCast(int idMovie) async {
    print('getCast');

    //creo una variable que almacenará el URL que se pasará a la API yq de la cual obtendremos su información
    var url = Uri.https(baseURL, '3/movie/$idMovie/credits',
        {'api_key': apiKey, 'language': language});

//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------PETICION NUEVA QUE CREAMOS-------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
    final result = await http.get(url);
    //final que almacena el contenido de la peticion a la API en formato JSON

    final newCreditsResponse = CreditsResponse.fromJson(result.body);
    //final que almacena el body de la peticion hecha usando la estructura de la clase NowPlayingResponse

    casting[idMovie] = newCreditsResponse.cast;
    //añadimos a la lista que creamos antes la información del body en formato objeto correspondiente al ID de la peli
    
    /* //aunque la lista se relleno nosotros la pasamos al home screen inicialmente vacia y si no nos encargamos de notificar el cambio de valores la lista estará vacia siempre, pro ello:
    notifyListeners(); */

    return casting;
  } */
