import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';
import 'dart:convert';

import '../../../../core/test/json_reader.dart';

void main() {
  const tTVSeriesModel = TVSeriesModel(
    backdropPath: '/path.jpg',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    voteAverage: 1.0,
    voteCount: 1,
  );

  const tTVSeriesResponseModel =
      TVSeriesResponse(tvSeriesList: <TVSeriesModel>[tTVSeriesModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_series/tv_series_on_air.json'));
      // act
      final result = TVSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTVSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTVSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "first_air_date": "firstAirDate",
            'genre_ids': [1, 2, 3],
            "id": 1,
            "name": "name",
            "original_name": "originalName",
            "overview": "overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "vote_average": 1.0,
            "vote_count": 1,
          }
        ]
      };
      expect(result, expectedJsonMap);
    });
  });
}

