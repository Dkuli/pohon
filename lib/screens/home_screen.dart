import 'package:flutter/material.dart';
import '../widgets/image_input.dart';
import '../widgets/custom_app_bar.dart';
import 'identification_screen.dart';
import 'dart:io';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.teal[300]!, Colors.teal[700]!], // Matches light theme gradient
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(title: 'PlantPal'),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome to PlantPal',
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              color: Colors.white, // Matches gradient contrast
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Identify plants with just a photo!',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.white70, // Consistent text styling
                            ),
                          ),
                          SizedBox(height: 40),
                          _buildFeatureCard(
                            context,
                            icon: Icons.camera_alt,
                            title: 'Instant Plant Recognition',
                            description: 'Take a photo and get instant information about the plant.',
                          ),
                          SizedBox(height: 20),
                          _buildFeatureCard(
                            context,
                            icon: Icons.eco,
                            title: 'Extensive Plant Database',
                            description: 'Access a vast database of plant species and their details.',
                          ),
                          SizedBox(height: 20),
                          _buildFeatureCard(
                            context,
                            icon: Icons.history,
                            title: 'Identification History',
                            description: 'Keep track of all your previous plant identifications.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal, // Changed to teal to match the theme
        onPressed: () {
          _showImageInputBottomSheet(context);
        },
        child: Icon(Icons.camera_alt, color: Colors.white), // White icon on teal FAB
        tooltip: 'Identify Plant',
      ),
    );
  }

  void _showImageInputBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: ImageInput(
            onImageSelected: (File image) {
              Navigator.pop(context); // Close the bottom sheet
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IdentificationScreen(image: image),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildFeatureCard(BuildContext context, {required IconData icon, required String title, required String description}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Consistent with card theme
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 48, color: Colors.teal[600]), // Updated to use a teal shade for icons
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge, // Use titleLarge from theme
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium, // Use bodyMedium from theme
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
