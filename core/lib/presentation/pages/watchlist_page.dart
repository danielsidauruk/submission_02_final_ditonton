import 'package:tv_series/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:core/core.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: const Text('Watchlist'),
              pinned: true,
              floating: true,
              bottom: TabBar(
                indicatorColor: kMikadoYellow,
                tabs: [
                  _tabBarItem('Movies', Icons.movie_creation_outlined),
                  _tabBarItem('TV Series', Icons.live_tv_rounded),
                ],
              ),
            ),
          ];
        },
        body: const TabBarView(
          children: <Widget>[
            WatchlistMoviesPage(),
            TVSeriesWatchlistPage(),
          ],
        ),
      )),
    );
  }

  Widget _tabBarItem(String title, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData),
          const SizedBox(
            width: 14.0,
          ),
          Text(title),
        ],
      ),
    );
  }
}
