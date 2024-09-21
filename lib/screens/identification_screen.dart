import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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

class _IdentificationScreenState extends State<IdentificationScreen> {
  List<PlantIdentification> _identifications = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _identifyPlant();
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

      if (_identifications.isNotEmpty) {
        await DatabaseService.saveIdentification(_identifications.first);
      }
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
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/images/Animation - 1726286806585.json',
                              width: 200,
                              height: 200,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Identifying plant...',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                      )
                    : _identifications.isEmpty
                        ? _buildNotIdentified()
                        : _buildResults(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotIdentified() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/images/Animation - 1726507844804.json',
            width: 150,
            height: 150,
          ),
          SizedBox(height: 20),
          Text(
            'Plant not identified',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          SizedBox(height: 10),
          Text(
            'We could not identify this plant.\nPlease try again or upload another image.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Go back to previous screen
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.teal[700], backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: Text(
              'Try Again',
              style: TextStyle(fontSize: 16),
            ),
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
                  showImage: false,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
