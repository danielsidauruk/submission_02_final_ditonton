import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';

class TVSeriesWatchlistPage extends StatefulWidget {
  const TVSeriesWatchlistPage({Key? key}) : super(key: key);

  @override
  _TVSeriesWatchlistPageState createState() => _TVSeriesWatchlistPageState();
}

class _TVSeriesWatchlistPageState extends State<TVSeriesWatchlistPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TVSeriesWatchlistBloc>(context, listen: false)
          .add(FetchWatchlistTVSeries());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    BlocProvider.of<TVSeriesWatchlistBloc>(context, listen: false)
        .add(FetchWatchlistTVSeries());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TVSeriesWatchlistBloc, TVSeriesWatchlistState>(
      builder: (context, state) {
        if (state is TVSeriesWatchlistLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TVSeriesWatchlistHasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final watchlistTVSeries = state.result[index];
              return TVSeriesCard(item: watchlistTVSeries);
            },
            itemCount: state.result.length,
          );
        } else if (state is TVSeriesWatchlistError) {
          return Center(
            key: const Key('error_message'),
            child: Text(state.message),
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
