import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tv_series/tv_series.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import '../../../../test/dummy_data/dummy_object.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTVSeriesDetail])
void main() {
  late TVSeriesDetailBloc tvSeriesDetailBloc;
  late MockGetTVSeriesDetail mockGetTVSeriesDetail;

  setUp(() {
    mockGetTVSeriesDetail = MockGetTVSeriesDetail();
    tvSeriesDetailBloc = TVSeriesDetailBloc(mockGetTVSeriesDetail);
  });

  const tId = 1;

  test('initial state should be empty', () {
    expect(tvSeriesDetailBloc.state, TVSeriesDetailEmpty());
  });

  blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
    'Should emit [TVSeriesDetailLoading, TVSeriesDetailHasData]  when detail data is gotten successfully',
    build: () {
      when(mockGetTVSeriesDetail.execute(tId))
          .thenAnswer((_) async => Right(testTVSeriesDetail));
      return tvSeriesDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchTVSeriesDetail(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TVSeriesDetailLoading(),
      TVSeriesDetailHasData(testTVSeriesDetail),
    ],
    verify: (bloc) {
      verify(mockGetTVSeriesDetail.execute(tId));
    },
  );

  blocTest<TVSeriesDetailBloc, TVSeriesDetailState>(
    'Should emit [TVSeriesDetailLoading, TVSeriesDetailError] when detail data is gotten unsuccessfully',
    build: () {
      when(mockGetTVSeriesDetail.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchTVSeriesDetail(tId)),
    expect: () => [
      TVSeriesDetailLoading(),
      const TVSeriesDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTVSeriesDetail.execute(tId));
    },
  );
}
