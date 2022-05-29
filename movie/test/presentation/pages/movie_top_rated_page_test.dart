import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';

import '../../../../test/dummy_data/dummy_object.dart';

class MockMovieTopRatedBloc
    extends MockBloc<MovieTopRatedEvent, MovieTopRatedState>
    implements MovieTopRatedBloc {}

class MovieTopRatedEventFake extends Fake implements MovieTopRatedEvent {}

class MovieTopRatedStateFake extends Fake implements MovieTopRatedState {}

@GenerateMocks([MovieTopRatedBloc])
void main() {
  late MockMovieTopRatedBloc mockMovieTopRatedBloc;

  setUpAll(() {
    registerFallbackValue(MovieTopRatedEventFake());
    registerFallbackValue(MovieTopRatedStateFake());
  });

  setUp(() {
    mockMovieTopRatedBloc = MockMovieTopRatedBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieTopRatedBloc>.value(
      value: mockMovieTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
          (WidgetTester tester) async {
        when(() => mockMovieTopRatedBloc.state).thenReturn(MovieTopRatedLoading());

        final progressFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressFinder, findsOneWidget);
      });

  testWidgets('Page should display when data is loaded',
          (WidgetTester tester) async {
        when(() => mockMovieTopRatedBloc.state)
            .thenReturn(MovieTopRatedHasData(testMovieList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        when(() => mockMovieTopRatedBloc.state)
            .thenReturn(const MovieTopRatedError('Error Message'));

        final textFinder = find.byKey(const Key('error_message'));

        await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

        expect(textFinder, findsOneWidget);
      });
}
