import 'package:flutter/material.dart';
import '../models/plant_identification.dart';

class PlantCard extends StatelessWidget {
  final PlantIdentification identification;
  final VoidCallback onTap;

  PlantCard({required this.identification, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                identification.species,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8),
              Text(
                'Family: ${identification.family}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 16),
              Text(
                'Probability',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 4),
              LinearProgressIndicator(
                value: identification.probability,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getProbabilityColor(identification.probability),
                ),
              ),
              SizedBox(height: 4),
              Text(
                '${(identification.probability * 100).toStringAsFixed(2)}%',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: identification.commonNames.map((name) => Chip(
                  label: Text(name),
                  backgroundColor: Theme.of(context).primaryColorLight,
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getProbabilityColor(double probability) {
    if (probability < 0.3) {
      return Colors.red;
    } else if (probability < 0.7) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }
}