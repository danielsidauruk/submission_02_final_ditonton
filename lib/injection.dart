import 'package:tv_series/tv_series.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/movie.dart';
import 'package:core/core.dart';

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(
        () => SearchMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => MovieDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => MovieRecommendationBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => MovieWatchlistBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
        () => MovieNowPlayingBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => MoviePopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => MovieTopRatedBloc(
      locator(),
    ),
  );

  // tv_series
  locator.registerFactory(
        () => SearchTVSeriesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TVSeriesDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TVSeriesRecommendationBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TVSeriesWatchlistBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
        () => TVSeriesOnAirBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TVSeriesPopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TVSeriesTopRatedBloc(
      locator(),
    ),
  );

  // use case

  // movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // tv_series
  locator.registerLazySingleton(() => GetOnAirTVSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTVSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTVSeries(locator()));
  locator.registerLazySingleton(() => GetTVSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTVSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTVSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTVSeriesStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTVSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTVSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTVSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TVSeriesRepository>(
    () => TVSeriesRepositoryImpl(
      tvSeriesRemoteDataSource: locator(),
      tvSeriesLocalDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TVSeriesRemoteDataSource>(
      () => TVSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVSeriesLocalDataSource>(
      () => TVSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<DatabaseHelperTVSeries>(
      () => DatabaseHelperTVSeries());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
