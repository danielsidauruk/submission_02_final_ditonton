import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'dart:io';

import '../../../../core/test/helpers/test_helper.mocks.dart';
import '../../../../test/dummy_data/dummy_object.dart';

void main() {
  late TVSeriesRepositoryImpl repository;
  late MockTVSeriesRemoteDataSource mockTVSeriesRemoteDataSource;
  late MockTVSeriesLocalDataSource mockTVSeriesLocalDataSource;

  setUp(() {
    mockTVSeriesRemoteDataSource = MockTVSeriesRemoteDataSource();
    mockTVSeriesLocalDataSource = MockTVSeriesLocalDataSource();
    repository = TVSeriesRepositoryImpl(
      tvSeriesRemoteDataSource: mockTVSeriesRemoteDataSource,
      tvSeriesLocalDataSource: mockTVSeriesLocalDataSource,
    );
  });

  const tTVSeriesModel = TVSeriesModel(
    backdropPath: '/rcA17r3hfHtRrk3Xs3hXrgGeSGT.jpg',
    firstAirDate: '2016-07-15',
    genreIds: [18, 9648, 10765],
    id: 66732,
    name: 'Stranger Things',
    originalName: 'Stranger Things',
    overview:
        'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
    popularity: 3587.573,
    posterPath: '/x2LSRK2Cm7MZhjluni1msVJ3wDF.jpg',
    voteAverage: 8.6,
    voteCount: 10177
  );

  final tTVSeries = TVSeries(
    backdropPath: '/rcA17r3hfHtRrk3Xs3hXrgGeSGT.jpg',
    firstAirDate: '2016-07-15',
    genreIds: const [18, 9648, 10765],
    id: 66732,
    name: 'Stranger Things',
    originalName: 'Stranger Things',
    overview:
        'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
    popularity: 3587.573,
    posterPath: '/x2LSRK2Cm7MZhjluni1msVJ3wDF.jpg',
    voteAverage: 8.6,
    voteCount: 10177,
  );

  final tTVSeriesModelList = <TVSeriesModel>[tTVSeriesModel];
  final tTVSeriesList = <TVSeries>[tTVSeries];

  group('Now Playing TVSeries', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getOnAirTVSeries())
          .thenAnswer((_) async => tTVSeriesModelList);
      // act
      final result = await repository.getOnAirTVSeries();
      // assert
      verify(mockTVSeriesRemoteDataSource.getOnAirTVSeries());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getOnAirTVSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getOnAirTVSeries();
      // assert
      verify(mockTVSeriesRemoteDataSource.getOnAirTVSeries());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getOnAirTVSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getOnAirTVSeries();
      // assert
      verify(mockTVSeriesRemoteDataSource.getOnAirTVSeries());
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular TVSeries', () {
    test('should return tvSeries list when call to data source is success',
        () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getPopularTVSeries())
          .thenAnswer((_) async => tTVSeriesModelList);
      // act
      final result = await repository.getPopularTVSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVSeriesList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getPopularTVSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTVSeries();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getPopularTVSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTVSeries();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated TVSeries', () {
    test('should return tvSeries list when call to data source is successful',
        () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getTopRatedTVSeries())
          .thenAnswer((_) async => tTVSeriesModelList);
      // act
      final result = await repository.getTopRatedTVSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getTopRatedTVSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTVSeries();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getTopRatedTVSeries())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTVSeries();
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get TVSeries Detail', () {
    const tId = 1;
    const tTVSeriesResponse = TVSeriesDetailResponse(
      adult: false,
      backdropPath: '/path.jpg',
      episodeRunTime: [60],
      firstAirDate: 'firstAirDate',
      genres: [GenreModel(id: 1, name: 'supernatural')],
      id: 1,
      lastAirDate: 'lastAirDate',
      name: 'name',
      numberOfEpisodes: 12,
      numberOfSeasons: 1,
      originalName: 'originalName',
      overview: 'overview',
      posterPath: '/path.jpg',
      seasons: [
        SeasonModel(
          airDate: 'airDate',
          episodeCount: 16,
          id: 1,
          name: 'name',
          overview: 'overview',
          posterPath: 'posterPath',
          seasonNumber: 1,
        )
      ],
      voteAverage: 1.0,
      voteCount: 1,
    );

    test(
        'should return TVSeries data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getTVSeriesDetail(tId))
          .thenAnswer((_) async => tTVSeriesResponse);
      // act
      final result = await repository.getTVSeriesDetail(tId);
      // assert
      verify(mockTVSeriesRemoteDataSource.getTVSeriesDetail(tId));
      expect(result, equals(Right(testTVSeriesDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getTVSeriesDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTVSeriesDetail(tId);
      // assert
      verify(mockTVSeriesRemoteDataSource.getTVSeriesDetail(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getTVSeriesDetail(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVSeriesDetail(tId);
      // assert
      verify(mockTVSeriesRemoteDataSource.getTVSeriesDetail(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TVSeries Recommendations', () {
    final tTVSeriesList = <TVSeriesModel>[];
    const tId = 1;

    test('should return data (TVSeries list) when the call is successful',
        () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getTVSeriesRecommendations(tId))
          .thenAnswer((_) async => tTVSeriesList);
      // act
      final result = await repository.getTVSeriesRecommendations(tId);
      // assert
      verify(mockTVSeriesRemoteDataSource.getTVSeriesRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTVSeriesList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getTVSeriesRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTVSeriesRecommendations(tId);
      // assert build runner
      verify(mockTVSeriesRemoteDataSource.getTVSeriesRecommendations(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.getTVSeriesRecommendations(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVSeriesRecommendations(tId);
      // assert
      verify(mockTVSeriesRemoteDataSource.getTVSeriesRecommendations(tId));
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search TVSeries', () {
    const tQuery = 'Stranger Things';

    test('should return TVSeries list when call to data source is successful',
        () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.searchTVSeries(tQuery))
          .thenAnswer((_) async => tTVSeriesModelList);
      // act
      final result = await repository.searchTVSeries(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.searchTVSeries(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTVSeries(tQuery);
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTVSeriesRemoteDataSource.searchTVSeries(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTVSeries(tQuery);
      // assert
      expect(result,
          const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockTVSeriesLocalDataSource.insertWatchlist(testTVSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTVSeriesDetail);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockTVSeriesLocalDataSource.insertWatchlist(testTVSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTVSeriesDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockTVSeriesLocalDataSource.removeWatchlist(testTVSeriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTVSeriesDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockTVSeriesLocalDataSource.removeWatchlist(testTVSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTVSeriesDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(mockTVSeriesLocalDataSource.getTVSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist TVSeries', () {
    test('should return list of TVSeries', () async {
      // arrange
      when(mockTVSeriesLocalDataSource.getWatchlistTVSeries())
          .thenAnswer((_) async => [testTVSeriesTable]);
      // act
      final result = await repository.getWatchlistTVSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testTVSeriesWatchlist]);
    });
  });
}
