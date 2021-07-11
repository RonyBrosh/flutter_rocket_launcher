import 'package:flutter_rocket_launcher/core/util/extension/boolean_extensions.dart';
import 'package:flutter_rocket_launcher/core/util/extension/string_extensions.dart';

class Launch {
  final String id;
  final String rocketId;
  final String name;
  final String imageUrl;
  final DateTime date;
  final bool isSuccessful;

  Launch._({
    required this.id,
    required this.rocketId,
    required this.name,
    required this.imageUrl,
    required this.date,
    required this.isSuccessful,
  });

  factory Launch.create({
    String? id,
    String? rocketId,
    String? name,
    String? imageUrl,
    DateTime? date,
    bool? isSuccessful,
  }) {
    return Launch._(
      id: id.orEmpty(),
      rocketId: rocketId.orEmpty(),
      name: name.orEmpty(),
      imageUrl: imageUrl.orEmpty(),
      date: date ?? DateTime.now(),
      isSuccessful: isSuccessful.orFalse(),
    );
  }

  @override
  bool operator ==(other) {
    return identical(this, other) ||
        other is Launch &&
            id == other.id &&
            rocketId == other.rocketId &&
            name == other.name &&
            imageUrl == other.imageUrl &&
            date.year == other.date.year &&
            date.month == other.date.month &&
            date.day == other.date.day &&
            isSuccessful == other.isSuccessful;
  }

  @override
  int get hashCode {
    return id.hashCode + rocketId.hashCode + name.hashCode + imageUrl.hashCode + date.year.hashCode + date.month.hashCode + date.day.hashCode + isSuccessful.hashCode;
  }
}
