import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tv_series/tv_series.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_object.dart';

class MockTVSeriesTopRatedBloc
    extends MockBloc<TVSeriesTopRatedEvent, TVSeriesTopRatedState>
    implements TVSeriesTopRatedBloc {}

class TVSeriesTopRatedEventFake extends Fake implements TVSeriesTopRatedEvent {}

class TVSeriesTopRatedStateFake extends Fake implements TVSeriesTopRatedState {}

@GenerateMocks([TVSeriesTopRatedBloc])
void main() {
  late MockTVSeriesTopRatedBloc mockTVSeriesTopRatedBloc;

  setUpAll(() {
    registerFallbackValue(TVSeriesTopRatedEventFake());
    registerFallbackValue(TVSeriesTopRatedStateFake());
  });

  setUp(() {
    mockTVSeriesTopRatedBloc = MockTVSeriesTopRatedBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TVSeriesTopRatedBloc>.value(
      value: mockTVSeriesTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTVSeriesTopRatedBloc.state)
        .thenReturn(TVSeriesTopRatedLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TVSeriesTopRatedPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTVSeriesTopRatedBloc.state)
        .thenReturn(TVSeriesTopRatedHasData(testTVSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TVSeriesTopRatedPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTVSeriesTopRatedBloc.state)
        .thenReturn(const TVSeriesTopRatedError('Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TVSeriesTopRatedPage()));

    expect(textFinder, findsOneWidget);
  });
}
