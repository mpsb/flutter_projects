import 'package:flutter/material.dart';
import 'movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;

  MovieDetail(this.movie);

  final String imgPath = 'https://image.tmdb.org/t/p/w500/';
  final String defaultImgPath = 'https://images.freeimages.com/images/large-previews/41e/red-chairs-1215718.jpg';

  @override
  Widget build(BuildContext context) {
    String path;
    double height = MediaQuery.of(context).size.height;

    if (movie.posterPath != null) {
      path = imgPath + movie.posterPath;
    }
    else {
      path = defaultImgPath;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(16),
                height: height/1.5,
                child: Image.network(path),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Text(movie.overview),
              )
            ],
          ),
        ),
      ),
    );
  }
}
