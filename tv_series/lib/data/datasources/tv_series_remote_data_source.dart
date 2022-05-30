import 'dart:convert';
import 'package:core/core.dart';
import 'package:tv_series/data/models/tv_series_detail_model.dart';
import 'package:tv_series/data/models/tv_series_model.dart';
import 'package:tv_series/data/models/tv_series_response.dart';
import 'package:http/http.dart' as http;

abstract class TVSeriesRemoteDataSource {
  Future<List<TVSeriesModel>> getOnAirTVSeries();
  Future<List<TVSeriesModel>> getPopularTVSeries();
  Future<List<TVSeriesModel>> getTopRatedTVSeries();
  Future<TVSeriesDetailResponse> getTVSeriesDetail(int id);
  Future<List<TVSeriesModel>> getTVSeriesRecommendations(int id);
  Future<List<TVSeriesModel>> searchTVSeries(String query);
}

class TVSeriesRemoteDataSourceImpl implements TVSeriesRemoteDataSource {
  final http.Client client;

  TVSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TVSeriesModel>> getOnAirTVSeries() async {
    final response =
        await client.get(Uri.parse('$baseURL/tv/on_the_air?$apiKey'));

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TVSeriesDetailResponse> getTVSeriesDetail(int id) async {
    final response = await client.get(Uri.parse('$baseURL/tv/$id?$apiKey'));

    if (response.statusCode == 200) {
      return TVSeriesDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getTVSeriesRecommendations(int id) async {
    final response =
        await client.get(Uri.parse('$baseURL/tv/$id/recommendations?$apiKey'));

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getPopularTVSeries() async {
    final response = await client.get(Uri.parse('$baseURL/tv/popular?$apiKey'));

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getTopRatedTVSeries() async {
    final response =
        await client.get(Uri.parse('$baseURL/tv/top_rated?$apiKey'));

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> searchTVSeries(String query) async {
    final response =
        await client.get(Uri.parse('$baseURL/search/tv?$apiKey&query=$query'));

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }
}
