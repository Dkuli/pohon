import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:io';
import 'identification_screen.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/image_input.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal[300]!, Colors.teal[700]!],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(title: 'PlantPal'),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome to PlantPal',
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Identify plants with just a photo!',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 40),
                      Center(
                        child: Lottie.asset(
                          'assets/images/Animation - 1726507913530.json',
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 40),
                      _buildFeatureCard(
                        context,
                        title: 'Instant Plant Recognition',
                        description: 'Take a photo and get instant information about the plant.',
                      ),
                      SizedBox(height: 20),
                      _buildFeatureCard(
                        context,
                        title: 'Extensive Plant Database',
                        description: 'Access a vast database of plant species and their details.',
                      ),
                      SizedBox(height: 20),
                      _buildFeatureCard(
                        context,
                        title: 'Identification History',
                        description: 'Keep track of all your previous plant identifications.',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ImageInput(
        onImageSelected: (File imageFile) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IdentificationScreen(image: imageFile),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildFeatureCard(BuildContext context, {required String title, required String description}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withOpacity(0.3), // Slightly increased opacity for better text visibility
        border: Border.all(color: Colors.white54),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
