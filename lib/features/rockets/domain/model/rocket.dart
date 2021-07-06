import 'package:flutter_rocket_launcher/core/util/extension/boolean_extensions.dart';
import 'package:flutter_rocket_launcher/core/util/extension/integer_extensions.dart';
import 'package:flutter_rocket_launcher/core/util/extension/string_extensions.dart';

class Rocket {
  Rocket._(this.id, this.name, this.country, this.description, this.imageUrl, this.enginesCount, this.isActive);

  final String id;
  final String name;
  final String country;
  final String description;
  final String imageUrl;
  final int enginesCount;
  final bool isActive;

  factory Rocket.create({
    String? id = "",
    String? name = "",
    String? country = "",
    String? description = "",
    String? imageUrl = "",
    int? enginesCount = 0,
    bool? isActive = false,
  }) {
    return Rocket._(
      id.orEmpty(),
      name.orEmpty(),
      country.orEmpty(),
      description.orEmpty(),
      imageUrl.orEmpty(),
      enginesCount.orZero(),
      isActive.orFalse(),
    );
  }

  @override
  bool operator ==(other) {
    return identical(this, other) || other is Rocket && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
