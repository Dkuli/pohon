import 'package:flutter/material.dart';
import 'dart:io';
import '../models/plant_identification.dart';

class PlantCard extends StatelessWidget {
  final PlantIdentification identification;
  final bool showImage;
  final VoidCallback onTap;

  PlantCard({
    required this.identification,
    required this.onTap,
    this.showImage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showImage && identification.imagePath.isNotEmpty)
              // Pembungkus gambar dengan Container dan BoxDecoration
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 0,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: AspectRatio(
                    aspectRatio: 16 / 9, // Menjaga proporsi gambar
                    child: Image.file(
                      File(identification.imagePath),
                      width: double.infinity,
                      fit: BoxFit.cover, // Mencegah gambar terpotong
                    ),
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(12), // Padding lebih kecil
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    identification.species,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18, // Ukuran teks lebih kecil
                        ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Family: ${identification.family}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 8),
                  // Probability Bar UI Enhancement
                  _buildProbabilityBar(context, identification.probability),
                  SizedBox(height: 8),
                  // Common names sebagai Chip
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: identification.commonNames
                        .map((name) => Chip(
                              label: Text(name),
                              backgroundColor: Theme.of(context).primaryColorLight,
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProbabilityBar(BuildContext context, double probability) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Probability:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
            ),
            Text(
              '${(probability * 100).toStringAsFixed(2)}%',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: _getProbabilityColor(probability),
                  ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Stack(
          children: [
            Container(
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[300],
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: 10,
              width: probability * MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                  colors: [
                    Colors.red,
                    Colors.orange,
                    Colors.green,
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              _getProbabilityIcon(probability),
              color: _getProbabilityColor(probability),
              size: 16,
            ),
            SizedBox(width: 4),
            Text(
              _getProbabilityLabel(probability),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _getProbabilityColor(probability),
                  ),
            ),
          ],
        ),
      ],
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

  IconData _getProbabilityIcon(double probability) {
    if (probability < 0.3) {
      return Icons.warning_rounded;
    } else if (probability < 0.7) {
      return Icons.help_outline;
    } else {
      return Icons.check_circle_outline;
    }
  }

  String _getProbabilityLabel(double probability) {
    if (probability < 0.3) {
      return 'Low';
    } else if (probability < 0.7) {
      return 'Medium';
    } else {
      return 'High';
    }
  }
}
