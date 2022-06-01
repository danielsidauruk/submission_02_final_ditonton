import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:tv_series/tv_series.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:about/about.dart';
import 'package:core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HttpSSLPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviePopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVSeriesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTVSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVSeriesOnAirBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVSeriesPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVSeriesTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVSeriesWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVSeriesRecommendationBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: TVSeriesHomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case homeMovieRoute:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case detailMovieRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case popularMovieRoute:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case searchMovieRoute:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case topRatedMovieRoute:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case watchlistMovieRoute:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());

            case homeTVSeriesRoute:
              return MaterialPageRoute(builder: (_) => TVSeriesHomePage());
            case detailTVSeriesRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => TVSeriesDetailPage(id: id),
                  settings: settings);
            case onAirTVSeriesRoute:
              return MaterialPageRoute(builder: (_) => TVSeriesOnAirPage());
            case popularTVSeriesRoute:
              return MaterialPageRoute(builder: (_) => TVSeriesPopularPage());
            case searchTVSeriesRoute:
              return CupertinoPageRoute(builder: (_) => TVSeriesSearchPage());
            case topRatedTVSeriesRoute:
              return MaterialPageRoute(builder: (_) => TVSeriesTopRatedPage());
            case watchlistTVSeriesRoute:
              return MaterialPageRoute(builder: (_) => TVSeriesWatchlistPage());

            case watchlistRoute:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case aboutRoute:
              return MaterialPageRoute(builder: (_) => AboutPage());

            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
