import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';
import 'package:core/core.dart';

import '../../../../core/test/helpers/test_helper.mocks.dart';
import '../../../../core/test/json_reader.dart';

void main() {
  late TVSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TVSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get On Air TVSeries', () {
    final tOnAirList = TVSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series/tv_series_on_air.json')))
        .tvSeriesList;

    test('should return list of tv Series Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_series/tv_series_on_air.json'), 200));
      // act
      final result = await dataSource.getOnAirTVSeries();
      // assert
      expect(result, equals(tOnAirList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getOnAirTVSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular TVSeries', () {
    final tPopularList = TVSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series/tv_series_popular.json')))
        .tvSeriesList;

    test('should return list of TVSeries when response is success (200)',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series/tv_series_popular.json'), 200));
      // act
      final result = await dataSource.getPopularTVSeries();
      // assert
      expect(result, tPopularList);
    });

    test('should return list of TVSeries when response is success (200)',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series/tv_series_popular.json'), 200));
      // act
      final result = await dataSource.getPopularTVSeries();
      // assert
      expect(result, tPopularList);
    });
  });

  group('get Top Rated TVSeries', () {
    final tTopRatedList = TVSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series/tv_series_top_rated.json')))
        .tvSeriesList;

    test('should return list of tv when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series/tv_series_top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedTVSeries();
      // assert
      expect(result, tTopRatedList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTVSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get TVSeries detail', () {
    const tId = 1;
    final tDetail = TVSeriesDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_series/tv_series_detail.json')));

    test('should return tv detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_series/tv_series_detail.json'), 200));
      // act
      final result = await dataSource.getTVSeriesDetail(tId);
      // assert
      expect(result, equals(tDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTVSeriesDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  // group('get tv detail', () {
  //   const tId = 1;
  //   final tTvDetail = TVSeriesDetailResponse.fromJson(
  //       json.decode(readJson('dummy_data/tv_detail.json')));
  //
  //   test('should return tv detail when the response code is 200', () async {
  //     // arrange
  //     when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
  //         .thenAnswer((_) async =>
  //         http.Response(readJson('dummy_data/tv_detail.json'), 200));
  //     // act
  //     final result = await dataSource.getTVSeriesDetail(tId);
  //     // assert
  //     expect(result, equals(tTvDetail));
  //   });
  //
  //   test('should throw Server Exception when the response code is 404 or other',
  //           () async {
  //         // arrange
  //         when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
  //             .thenAnswer((_) async => http.Response('Not Found', 404));
  //         // act
  //         final call = dataSource.getTVSeriesDetail(tId);
  //         // assert
  //         expect(() => call, throwsA(isA<ServerException>()));
  //       });
  // });

  group('get TVSeries recommendations', () {
    final tRecommendationsList = TVSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series/tv_series_recommendations.json')))
        .tvSeriesList;
    const tId = 1;

    test('should return list of TVSeries Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series/tv_series_recommendations.json'), 200));
      // act
      final result = await dataSource.getTVSeriesRecommendations(tId);
      // assert
      expect(result, equals(tRecommendationsList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTVSeriesRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search TVSeries', () {
    final tSearchResult = TVSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tv_series/tv_series_search_arcane.json')))
        .tvSeriesList;
    const tQuery = 'Arcane';

    test('should return list of TVSeries when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_series/tv_series_search_arcane.json'), 200));
      // act
      final result = await dataSource.searchTVSeries(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTVSeries(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
