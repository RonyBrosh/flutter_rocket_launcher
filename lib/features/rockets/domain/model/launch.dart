import 'package:flutter_rocket_launcher/core/util/extension/boolean_extensions.dart';
import 'package:flutter_rocket_launcher/core/util/extension/string_extensions.dart';

class Launch {
  final String id;
  final String name;
  final String imageUrl;
  final DateTime date;
  final bool isSuccessful;

  Launch._({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.date,
    required this.isSuccessful,
  });

  factory Launch.create({
    String? id,
    String? name,
    String? imageUrl,
    DateTime? date,
    bool? isSuccessful,
  }) {
    return Launch._(
      id: id.orEmpty(),
      name: name.orEmpty(),
      imageUrl: imageUrl.orEmpty(),
      date: date ?? DateTime.now(),
      isSuccessful: isSuccessful.orFalse(),
    );
  }
}
