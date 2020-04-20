import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bloc/search_bloc.dart';
import 'model/search_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchBloc>.value(
      value: SearchBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'IMDB Search'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  SearchBloc _searchBloc;
  TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    _searchBloc = Provider.of<SearchBloc>(context);
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  // Here is key idea
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      Icons.search,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      _searchBloc.searchMovie(movieName: searchController.text);
                    },
                  ),
                  hintStyle: TextStyle(color: Colors.black, fontSize: 18.0),
                  filled: true,
                  fillColor: Colors.white70,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: _searchBloc.searchedMovies.length,
                    itemBuilder: (BuildContext context, int index) {
                      Search searchedMovie = _searchBloc.searchedMovies[index];
                      return movieHolder(
                          searchedMovie: searchedMovie, width: width);
                    }),
              ),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget movieHolder({@required Search searchedMovie, double width}) {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 30.0,
            child: SizedBox(
              width: width * 0.90,
              child: Card(
                elevation: 8.0,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 120.0, right: 8.0, top: 8.0, bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        searchedMovie.title,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Type : ${searchedMovie.type}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        'Year : ${searchedMovie.year}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      ratingStarBar()
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              child: Column(
            children: <Widget>[
              SizedBox(
                height: 120,
                width: 90,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Card(
                    elevation: 8.0,
                    color: Colors.blue,
                    child: FittedBox(
                      child: Image.network(
                        searchedMovie.poster,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 45,
                width: 90,
              ),
            ],
          ))
        ],
      ),
    );
  }

  Widget ratingStarBar({int rating = 3}) {
    Random random = new Random();
    rating = random.nextInt(10);
    rating = rating < 5 ? rating + 5 : rating;

    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            rating.toDouble().toString(),
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
          ),
        ),
        ratingStar(index: 1, rating: rating),
        ratingStar(index: 2, rating: rating),
        ratingStar(index: 3, rating: rating),
        ratingStar(index: 4, rating: rating),
        ratingStar(index: 5, rating: rating),
      ],
    );
  }

  Widget ratingStar({@required index, int rating}) {
    return Icon(
      // Based on passwordVisible state choose the icon
      Icons.star,
      color: index <= (rating / 2) ? Colors.yellow.shade900 : Colors.grey,
    );
  }
}
