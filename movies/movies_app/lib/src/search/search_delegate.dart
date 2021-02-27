import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movie_model.dart';
import 'package:movies_app/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {
  final moviesProvider = new MoviesProvider();
  String selected = '';
  final movies = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Shazam!',
    'Ironman',
    'Capitan America',
    'Superman',
    'Ironman 2',
    'Ironman 3',
    'Ironman 4',
    'Ironman 5'
  ];

  final recentMovies = ['Spiderman', 'Capitan America'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // The actions in the appBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // The icon on the right, next to the appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Creates results of the search
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions in the searchbar

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: moviesProvider.searchMovies(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;
          return ListView(
              children: movies.map((movie) {
            return ListTile(
              leading: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.contain,
                image: NetworkImage(movie.getMovieImage()),
              ),
              title: Text(movie.title),
              subtitle: Text(movie.originalTitle),
              onTap: () {
                close(context, null);
                movie.uniqueId = ''; // Because it can't be null
                Navigator.pushNamed(context, 'detail', arguments: movie);
              },
            );
          }).toList());
        }
        return Center(child: CircularProgressIndicator());
      },
    );

    // final suggestedList = (query.isEmpty)
    //     ? recentMovies
    //     : movies.where((m) => m.toLowerCase().startsWith(query)).toList();
    // return ListView.builder(
    //   itemCount: suggestedList.length,
    //   itemBuilder: (context, index) {
    //     return ListTile(
    //       title: Text(suggestedList[index]),
    //       leading: Icon(Icons.movie),
    //     );
    //   },
    // );
  }
}
