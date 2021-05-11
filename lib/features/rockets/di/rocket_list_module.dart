import 'package:flutter_rocket_launcher/core/data/mapper/error_mapper.dart';
import 'package:flutter_rocket_launcher/core/data/network/api/http_client.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/database/rockets_database_impl.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/network/api/rockets_http_client.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/network/mapper/rocket_json_to_domain_list_mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/repository/rockets_repository_impl.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/use_case/get_rockets_use_case_impl.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/presenter/rocket_list_presenter.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/presenter/rocket_list_presenter_impl.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/router/rocket_list_router_impl.dart';
import 'package:http/http.dart';

class RocketListModule {
  static RocketListPresenter provideRocketListPresenter() {
    return RocketListPresenterImpl(
      GetRocketsUseCaseImpl(
        RocketsRepositoryImpl(
          RocketsHttpClient(
            HttpClient(
              "api.spacexdata.com",
              Client(),
            ),
            RocketJsonToDomainListMapper(),
            ErrorMapper(),
          ),
          RocketsDatabaseImpl(),
        ),
      ),
      RocketListRouterImpl(),
    );
  }
}
