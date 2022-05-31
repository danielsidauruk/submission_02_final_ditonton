import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:core/core.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<MovieNowPlayingBloc>(context, listen: false)
          .add(FetchMovieNowPlaying());
      BlocProvider.of<MovieTopRatedBloc>(context, listen: false)
          .add(FetchMovieTopRated());
      BlocProvider.of<MoviePopularBloc>(context, listen: false)
          .add(FetchMoviePopular());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(
        route: homeMovieRoute,
      ),
      appBar: AppBar(
        title: const Text('Ditonton | Movie'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchMovieRoute);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
                  builder: (context, state) {
                    if (state is MovieNowPlayingLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MovieNowPlayingHasData) {
                      final nowPlayingList = state.result;
                      return MovieList(list: nowPlayingList);
                    } else if (state is MovieNowPlayingError) {
                      return Text(state.message);
                    } else {
                      return const Center();
                    }
                  }),
              SubHeading(
                title: 'Popular Movie',
                onTap: () =>
                    Navigator.pushNamed(context, popularMovieRoute),
              ),
              BlocBuilder<MoviePopularBloc, MoviePopularState>(
                  builder: (context, state) {
                    if (state is MovieNowPlayingLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MoviePopularHasData) {
                      final popularList = state.result;
                      return MovieList(list: popularList);
                    } else if (state is MoviePopularError) {
                      return Text(state.message);
                    } else {
                      return const Center();
                    }
                  }),
              SubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, topRatedMovieRoute),
              ),
              BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
                  builder: (context, state) {
                    if (state is MovieTopRatedLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MovieTopRatedHasData) {
                      final topRatedList = state.result;
                      return MovieList(list: topRatedList);
                    } else if (state is MovieTopRatedError) {
                      return Text(state.message);
                    } else {
                      return const Center();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
