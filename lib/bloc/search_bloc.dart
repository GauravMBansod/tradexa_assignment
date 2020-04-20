import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tradexaassignment/model/search_model.dart';
import 'package:tradexaassignment/model/search_result.dart';

class SearchBloc extends ChangeNotifier {
  List<Search> _searchedMovies = new List(0);

  get searchedMovies => _searchedMovies;

  void searchMovie({@required String movieName}) async {
    Map<String, String> headers = {
      "x-rapidapi-hos": "movie-database-imdb-alternative.p.rapidapi.com",
      "x-rapidapi-key": "3bed8d0e83mshb1d1d49d36bba71p1ed45ajsn8268607cd187"
    };
    Map<String, String> queryParameters = {
      "page": "1",
      "r": "json",
      "s": movieName
    };

    /*Response response = await http.get(
        "https://movie-database-imdb-alternative.p.rapidapi.com/?page=1&r=json&s=Avengers%20Endgame",
        headers: headers);*/
    var uri = Uri.https(
        'movie-database-imdb-alternative.p.rapidapi.com', '/', queryParameters);
    Response response = await http.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      Map searchResultMap = jsonDecode(response.body);
      SearchResult searchResult = SearchResult.fromJson(searchResultMap);

      if (searchResult != null && searchResult.searchList != null) {
        _searchedMovies = searchResult.searchList;
        notifyListeners();
      }

      print(response.body);
    }
  }
}
