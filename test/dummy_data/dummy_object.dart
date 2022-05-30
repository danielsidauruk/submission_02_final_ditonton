import 'package:tv_series/tv_series.dart';
import 'package:movie/movie.dart';
import 'package:core/core.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: const [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTVSeries = TVSeries(
  backdropPath: "/rcA17r3hfHtRrk3Xs3hXrgGeSGT.jpg",
  genreIds: const [18, 9648, 10765],
  id: 66732,
  name: 'Stranger Things',
  originalName: 'Stranger Things',
  overview:
      'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
  popularity: 3587.573,
  posterPath: '/x2LSRK2Cm7MZhjluni1msVJ3wDF.jpg',
  firstAirDate: '2016-07-15',
  voteAverage: 8.6,
  voteCount: 10177
);

final testTVSeriesList = [testTVSeries];

final testTVSeriesDetail = TVSeriesDetail(
  adult: false,
  backdropPath: '/path.jpg',
  episodeRunTime: const [60],
  firstAirDate: 'firstAirDate',
  genres: [Genre(id: 1, name: 'supernatural')],
  id: 1,
  lastAirDate: 'lastAirDate',
  name: 'name',
  numberOfEpisodes: 12,
  numberOfSeasons: 1,
  originalName: 'originalName',
  overview: 'overview',
  posterPath: '/path.jpg',
  seasons: const [
    Season(
      airDate: 'airDate',
      episodeCount: 16,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
    ),
  ],
  voteAverage: 1.0,
  voteCount: 1,
);

final testTVSeriesWatchlist = TVSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: '/path.jpg',
  overview: 'overview',
);

const testTVSeriesTable = TVSeriesTable(
  id: 1,
  name: 'name',
  posterPath: '/path.jpg',
  overview: 'overview',
);

final testTVSeriesMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': '/path.jpg',
  'name': 'name',
};
