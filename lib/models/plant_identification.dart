import 'package:hive/hive.dart';

part 'plant_identification.g.dart';

@HiveType(typeId: 0)
class PlantIdentification extends HiveObject {
  @HiveField(0)
  final String species;

  @HiveField(1)
  final String family;

  @HiveField(2)
  final List<String> commonNames;

  @HiveField(3)
  final double probability;

  @HiveField(4)
  final String gbifId;

  @HiveField(5)
  final DateTime identificationDate;

  @HiveField(6)
  final String imagePath;

  PlantIdentification({
    required this.species,
    required this.family,
    required this.commonNames,
    required this.probability,
    required this.gbifId,
    required this.identificationDate,
    required this.imagePath,
  });

  factory PlantIdentification.fromJson(Map<String, dynamic> json, String imagePath) {
    return PlantIdentification(
      species: json['species']['scientificNameWithoutAuthor'] ?? 'Unknown',
      family: json['species']['family']['scientificNameWithoutAuthor'] ?? 'Unknown',
      commonNames: (json['species']['commonNames'] as List?)?.map((e) => e.toString()).toList() ?? [],
      probability: json['score'] ?? 0.0,
      gbifId: json['gbif']['id']?.toString() ?? 'Unknown',
      identificationDate: DateTime.now(),
      imagePath: imagePath,
    );
  }
}