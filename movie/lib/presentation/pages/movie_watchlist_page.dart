import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:core/core.dart';

class WatchlistMoviesPage extends StatefulWidget {
  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<MovieWatchlistBloc>(context, listen: false)
          .add(FetchMovieWatchlist());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    BlocProvider.of<MovieWatchlistBloc>(context, listen: false)
        .add(FetchMovieWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
      builder: (context, state) {
        if (state is MovieWatchlistLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieWatchlistHasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final watchlistMovie = state.result[index];
              return MovieCard(item: watchlistMovie);
            },
            itemCount: state.result.length,
          );
        } else if (state is MovieWatchlistError) {
          return Center(
            key: const Key('error_message'),
            child: Text(state.message),
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}