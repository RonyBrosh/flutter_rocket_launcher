import 'package:flutter_rocket_launcher/core/data/mapper/error_mapper.dart';
import 'package:flutter_rocket_launcher/core/data/network/api/http_client.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/network/api/rockets_http_client.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/network/mapper/launches_json_to_domain_list_mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/network/mapper/rocket_id_to_get_launches_request_mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/network/mapper/rocket_json_to_domain_list_mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/repository/launches_repository_impl.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rocket_launcher_database.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/database/rockets/launches_database_sqflite.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/mapper/launches_to_table_mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/storage/mapper/table_to_launches_mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/data/use_case/get_launches_use_case_impl.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/presenter/rocket_launches_presenter.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/presenter/rocket_launches_presenter_impl.dart';
import 'package:http/http.dart';

class RocketLaunchesModule {
  static RocketLaunchesPresenter provideRocketLaunchesPresenter() {
    return RocketLaunchesPresenterImpl(
      GetLaunchesUseCaseImpl(
        LaunchesRepositoryImpl(
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
          LaunchesDatabaseSqflite(
            RocketLauncherDatabase.instance.getDatabase(),
            ErrorMapper(),
            LaunchesToTableMapper(),
            TableToLaunchesMapper(),
          ),
        ),
      ),
    );
  }
}
