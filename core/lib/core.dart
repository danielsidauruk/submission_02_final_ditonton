library core;

// common
export 'common/utils.dart';

// data -> model
export 'data/models/season_model.dart';
export 'data/models/genre_model.dart';

// domain -> entities
export 'domain/entities/genre.dart';
export 'domain/entities/season.dart';

// presentation -> pages
export 'presentation/pages/watchlist_page.dart';

//presentation -> widgets
export 'presentation/widgets/app_drawer.dart';
export 'presentation/widgets/horizontal_card_list.dart';
export 'presentation/widgets/season_card_list.dart';
export 'presentation/widgets/sub_heading.dart';

//styles
export 'styles/colors.dart';
export 'styles/text_styles.dart';

//utils
export 'utils/constants.dart';
export 'utils/exception.dart';
export 'utils/failure.dart';
export 'utils/state_enum.dart';
export 'utils/routes.dart';