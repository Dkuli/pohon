class PlantDetail {
  final String scientificName;
  final String author;
  final String family;
  final String genus;
  final List<String> commonNames;
  final String description;
  final String habitat;
  final String distribution;

  PlantDetail({
    required this.scientificName,
    required this.author,
    required this.family,
    required this.genus,
    required this.commonNames,
    required this.description,
    required this.habitat,
    required this.distribution,
  });

  factory PlantDetail.fromJson(Map<String, dynamic> json) {
    return PlantDetail(
      scientificName: json['scientificName'] ?? 'Unknown',
      author: json['author'] ?? 'Unknown',
      family: json['family'] ?? 'Unknown',
      genus: json['genus'] ?? 'Unknown',
      commonNames: (json['commonNames'] as List?)?.map((e) => e.toString()).toList() ?? [],
      description: json['description'] ?? 'No description available.',
      habitat: json['habitat'] ?? 'Habitat information not available.',
      distribution: json['distribution'] ?? 'Distribution information not available.',
    );
  }
}