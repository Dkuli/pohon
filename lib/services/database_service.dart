import 'package:hive/hive.dart';
import '../models/plant_identification.dart';

class DatabaseService {
  static const String _boxName = 'plant_identifications';

  static Future<void> saveIdentification(PlantIdentification identification) async {
    final box = await Hive.openBox<PlantIdentification>(_boxName);
    await box.add(identification);
  }

  static Future<List<PlantIdentification>> getIdentificationHistory() async {
    final box = await Hive.openBox<PlantIdentification>(_boxName);
    return box.values.toList().reversed.toList();
  }

  static Future<void> deleteIdentification(int index) async {
    final box = await Hive.openBox<PlantIdentification>(_boxName);
    await box.deleteAt(index);
  }

  static Future<void> clearHistory() async {
    final box = await Hive.openBox<PlantIdentification>(_boxName);
    await box.clear();
  }
}