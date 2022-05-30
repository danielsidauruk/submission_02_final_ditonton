import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';

import '../../../../test/dummy_data/dummy_object.dart';

class MockTVSeriesPopularBloc
    extends MockBloc<TVSeriesPopularEvent, TVSeriesPopularState>
    implements TVSeriesPopularBloc {}

class TVSeriesPopularEventFake extends Fake implements TVSeriesPopularEvent {}

class TVSeriesPopularStateFake extends Fake implements TVSeriesPopularState {}

@GenerateMocks([TVSeriesPopularBloc])
void main() {
  late MockTVSeriesPopularBloc mockTVSeriesPopularBloc;

  setUpAll(() {
    registerFallbackValue(TVSeriesPopularEventFake());
    registerFallbackValue(TVSeriesPopularStateFake());
  });

  setUp(() {
    mockTVSeriesPopularBloc = MockTVSeriesPopularBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TVSeriesPopularBloc>.value(
      value: mockTVSeriesPopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTVSeriesPopularBloc.state)
        .thenReturn(TVSeriesPopularLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TVSeriesPopularPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTVSeriesPopularBloc.state)
        .thenReturn(TVSeriesPopularHasData(testTVSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TVSeriesPopularPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTVSeriesPopularBloc.state)
        .thenReturn(const TVSeriesPopularError('Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TVSeriesPopularPage()));

    expect(textFinder, findsOneWidget);
  });
}
