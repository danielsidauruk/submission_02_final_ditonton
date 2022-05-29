import 'package:movie/movie.dart';
import 'package:tv_series/tv_series.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  TVSeriesRepository,
  TVSeriesRemoteDataSource,
  TVSeriesLocalDataSource,
  DatabaseHelperTVSeries,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
