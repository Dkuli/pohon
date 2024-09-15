import 'package:flutter/material.dart';
import 'dart:io';
import '../services/plant_api_service.dart';
import '../models/plant_identification.dart';
import '../widgets/plant_card.dart';
import '../widgets/custom_app_bar.dart';
import 'plant_detail_screen.dart';
import '../services/database_service.dart';

class IdentificationScreen extends StatefulWidget {
  final File image;

  IdentificationScreen({required this.image});

  @override
  _IdentificationScreenState createState() => _IdentificationScreenState();
}

class _IdentificationScreenState extends State<IdentificationScreen> with SingleTickerProviderStateMixin {
  List<PlantIdentification> _identifications = [];
  bool _isLoading = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _identifyPlant();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _identifyPlant() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final results = await PlantApiService.identifyPlant(widget.image);
      setState(() {
        _identifications = results;
        _isLoading = false;
      });
      
      // Save identification to local database
      await DatabaseService.saveIdentification(results.first);
    } catch (e) {
      print('Error occurred: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to identify plant. Please try again.')),
      );
    }
  }

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
            children: [
              CustomAppBar(title: 'Identification Results'),
              Expanded(
                child: _isLoading
                    ? _buildLoadingIndicator()
                    : _buildResults(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (_, child) {
              return Transform.rotate(
                angle: _controller.value * 2 * 3.14,
                child: Icon(Icons.eco, size: 60, color: Colors.white),
              );
            },
          ),
          SizedBox(height: 20),
          Text(
            'Identifying plant...',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildResults() {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.file(widget.image, fit: BoxFit.cover),
          ),
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _identifications.length,
              itemBuilder: (context, index) {
                return PlantCard(
                  identification: _identifications[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlantDetailScreen(
                          identification: _identifications[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}