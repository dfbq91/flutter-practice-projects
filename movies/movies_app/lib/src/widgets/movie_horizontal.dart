import 'package:flutter/material.dart';

import 'package:movies_app/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;
  final Function nextPage;

  MovieHorizontal({@required this.movies, @required this.nextPage});

  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.25);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.height;

    _pageController.addListener(() {
      if (_pageController.position.pixels ==
          _pageController.position.maxScrollExtent) {
        nextPage();
      }
    });

    return Container(
      height: screenSize * 0.2,
      child: PageView.builder(
        controller: _pageController,
        pageSnapping: false,
        itemCount: movies.length,
        // children: _movieCards(context),
        itemBuilder: (context, index) {
          return _movieCard(context, movies[index]);
        },
      ),
    );
  }

  Widget _movieCard(BuildContext context, Movie movie) {
    movie.uniqueId = '${movie.id}-poster';

    final _movieCard = Container(
      child: Column(
        children: [
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movie.getMovieImage()),
                height: 110.0,
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption),
        ],
      ),
    );

    return GestureDetector(
      child: _movieCard,
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
    );
  }

  List<Widget> _movieCards(BuildContext context) {
    return movies.map((movie) {
      return Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movie.getMovieImage()),
                height: 110.0,
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(movie.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption),
          ],
        ),
      );
    }).toList();
  }
}
