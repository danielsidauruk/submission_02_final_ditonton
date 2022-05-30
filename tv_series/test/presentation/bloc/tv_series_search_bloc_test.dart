import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tv_series/tv_series.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import 'tv_series_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTVSeries])
void main() {
  late SearchTVSeriesBloc searchTVSeriesBloc;
  late MockSearchTVSeries mockSearchTVSeries;

  setUp(() {
    mockSearchTVSeries = MockSearchTVSeries();
    searchTVSeriesBloc = SearchTVSeriesBloc(mockSearchTVSeries);
  });

  final tTVSeriesModel = TVSeries(
    backdropPath: '/wvdWb5kTQipdMDqCclC6Y3zr4j3.jpg',
    genreIds: const [10759, 18, 10765],
    id: 1402,
    overview:
        'Sheriff\'s deputy Rick Grimes awakens from a coma to find a post-apocalyptic world dominated by flesh-eating zombies. He sets out to find his family and encounters many other survivors along the way.',
    popularity: 1832.419,
    posterPath: '/xf9wuDcqlUPWABZNeDKPbZUjWx0.jpg',
    firstAirDate: '2010-10-31',
    name: 'The Walking Dead',
    originalName: 'The Walking Dead',
    voteAverage: 8.1,
    voteCount: 12859,
  );
  final tTVSeriesList = <TVSeries>[tTVSeriesModel];
  const tQuery = 'the walking dead';

  test('initial state should be empty', () {
    expect(searchTVSeriesBloc.state, SearchEmpty());
  });

  blocTest<SearchTVSeriesBloc, SearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTVSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTVSeriesList));
      return searchTVSeriesBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchHasData(tTVSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchTVSeries.execute(tQuery));
    },
  );

  blocTest<SearchTVSeriesBloc, SearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTVSeries.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchTVSeriesBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      const SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTVSeries.execute(tQuery));
    },
  );
}
