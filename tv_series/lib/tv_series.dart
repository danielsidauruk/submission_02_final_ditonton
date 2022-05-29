library tv_series;

// data -> datasources -> database
export 'data/datasources/database/database_helper_tv_series.dart';

// data -> datasources
export 'data/datasources/tv_series_local_data_source.dart';
export 'data/datasources/tv_series_remote_data_source.dart';

// data -> models
export 'data/models/tv_series_detail_model.dart';
export 'data/models/tv_series_model.dart';
export 'data/models/tv_series_response.dart';
export 'data/models/tv_series_table.dart';

// data -> repositories
export 'data/repositories/tv_series_repository_impl.dart';

// domain -> entities
export 'domain/entities/tv_series.dart';
export 'domain/entities/tv_series_detail.dart';

// domain -> repositories
export 'domain/repositories/tv_series_repository.dart';

// domain -> usecases
export 'domain/usecases/get_on_air_tv_series.dart';
export 'domain/usecases/get_popular_tv_series.dart';
export 'domain/usecases/get_top_rated_tv_series.dart';
export 'domain/usecases/get_tv_series_detail.dart';
export 'domain/usecases/get_tv_series_recommendations.dart';
export 'domain/usecases/get_watchlist_tv_series.dart';
export 'domain/usecases/get_watchlist_tv_series_status.dart';
export 'domain/usecases/remove_watchlist_tv_series.dart';
export 'domain/usecases/save_watchlist_tv_series.dart';
export 'domain/usecases/search_tv_series.dart';

// presentation -> pages
export 'presentation/pages/tv_series_home_page.dart';
export 'presentation/pages/tv_series_on_air_page.dart';
export 'presentation/pages/tv_series_popular_page.dart';
export 'presentation/pages/tv_series_top_rated_page.dart';
export 'presentation/pages/tv_series_detail_page.dart';
export 'presentation/pages/tv_series_search_page.dart';
export 'presentation/pages/watchlist_tv_series_page.dart';

// presentation -> bloc
export 'presentation/bloc/tv_series_detail_bloc/tv_series_detail_bloc.dart';
export 'presentation/bloc/tv_series_on_air_bloc/tv_series_on_air_bloc.dart';
export 'presentation/bloc/tv_series_popular_bloc/tv_series_popular_bloc.dart';
export 'presentation/bloc/tv_series_recommendation_bloc/tv_series_recommendation_bloc.dart';
export 'presentation/bloc/tv_series_search_bloc/tv_series_search_bloc.dart';
export 'presentation/bloc/tv_series_top_rated_bloc/tv_series_top_rated_bloc.dart';
export 'presentation/bloc/tv_series_watchlist_bloc/tv_series_watchlist_bloc.dart';

// presentation -> widgets
export 'presentation/widgets/tv_series_card_list.dart';
export 'presentation/widgets/tv_series_list.dart';