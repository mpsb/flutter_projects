import 'package:flutter/material.dart';
import 'package:movies_db/http_helper.dart';
import 'package:movies_db/movie_detail.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/41e/red-chairs-1215718.jpg';
  int moviesCount;
  List movies;
  String result;
  HttpHelper helper;
  Icon visibleIcon = Icon(Icons.search);
  Icon upcomingIcon = Icon(Icons.subscriptions);
  Widget searchBar = Text('Movies');

  Future search(text) async {
    movies = await helper.findMovies(text);
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  Future initialize() async {
    movies = List();
    movies = await helper.getUpcoming();
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;

    return Scaffold(
        appBar: AppBar(
          title: searchBar,
          actions: <Widget>[
            IconButton(icon: upcomingIcon, onPressed: () {
              setState(() {
                initialize();
              });
            }),
            IconButton(
              icon: visibleIcon,
              onPressed: () {
                setState(() {
                  if (this.visibleIcon.icon == Icons.search) {
                    this.visibleIcon = Icon(Icons.cancel);
                    this.searchBar = TextField(
                      textInputAction: TextInputAction.search,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      onSubmitted: (String text) {
                        search(text);
                      },
                    );
                  } else {
                    setState(() {
                      this.visibleIcon = Icon(Icons.search);
                      this.searchBar = Text('Movies');
                    });
                  }
                });
              },
            )
          ],
        ),
        body: ListView.builder(
            itemCount: (this.moviesCount == null) ? 0 : this.moviesCount,
            itemBuilder: (BuildContext context, int position) {
              if (movies[position].posterPath != null) {
                image = NetworkImage(iconBase + movies[position].posterPath);
              } else {
                image = NetworkImage(defaultImage);
              }
              return Card(
                color: Colors.white,
                elevation: 2.0,
                child: ListTile(
                  title: Text(movies[position].title),
                  subtitle: Text('Released: ' +
                      movies[position].releaseDate +
                      ' - Vote: ' +
                      movies[position].voteAverage.toString()),
                  leading: CircleAvatar(
                    backgroundImage: image,
                  ),
                  onTap: () {
                    MaterialPageRoute route = MaterialPageRoute(
                        builder: (_) => MovieDetail(movies[position]));
                    Navigator.push(context, route);
                  },
                ),
              );
            }));
  }
}
