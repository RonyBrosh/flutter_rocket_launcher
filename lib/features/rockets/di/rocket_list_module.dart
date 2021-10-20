import 'package:flutter/foundation.dart';
import 'package:flutter_rocket_launcher/core/data/mapper/error_mapper.dart';
import 'package:flutter_rocket_launcher/core/data/network/api/http_client.dart';
import 'package:flutter_rocket_launcher/core/presentation/router/router_service_locator.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/network/api/rockets_http_client.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/network/mapper/launches_json_to_domain_list_mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/network/mapper/rocket_id_to_get_launches_request_mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/network/mapper/rocket_json_to_domain_list_mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/repository/rockets_repository_impl.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rocket_launcher_database.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rockets/rockets_database.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rockets/rockets_database_sqflite.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rockets/rockets_database_web.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/mapper/rockets_to_table_mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/mapper/table_to_rockets_mapper.dart';
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
            ErrorMapper(),
            RocketJsonToDomainListMapper(),
            LaunchesJsonToDomainListMapper(),
            RocketIdToGetLaunchesRequestMapper(),
          ),
          _getDatabase(),
        ),
      ),
      RocketListRouterImpl(RouterServiceLocator.getInstance().navigatorKey.currentState!),
    );
  }

  static RocketsDatabase _getDatabase() {
    if (kIsWeb) {
      return RocketsDatabaseWeb();
    } else {
      return RocketsDatabaseSqflite(
        RocketLauncherDatabase.instance.getDatabase(),
        ErrorMapper(),
        RocketsToTableMapper(),
        TableToRocketsMapper(),
      );
    }
  }
}
