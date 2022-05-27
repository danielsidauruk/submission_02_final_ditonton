import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:tv_series/data/models/tv_series_table.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';

final testTv = TVSeries(
  backdropPath: '/q8eejQcg1bAqImEV8jh8RtBD4uH.jpg',
  firstAirDate: '2021-11-06',
  genreIds: const [
    16,
    10765,
    10759,
    18,
  ],
  id: 94605,
  name: 'Arcane',
  originalName: 'Arcane',
  overview:
      'Amid the stark discord of twin cities Piltover and Zaun, two sisters fight on rival sides of a war between magic technologies and clashing convictions.',
  popularity: 218.007,
  posterPath: '/fqldf2t8ztc9aiwn3k6mlX3tvRT.jpg',
  voteAverage: 9.1,
  voteCount: 1869,
);

final testTVSeriesList = [testTv];

final testTVSeriesDetail = TVSeriesDetail(
  adult: false,
  backdropPath: '/path.jpg',
  episodeRunTime: const [60],
  firstAirDate: 'firstAirDate',
  genres: [Genre(id: 1, name: 'Action')],
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
      episodeCount: 12,
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
