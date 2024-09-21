import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Pastikan Anda menambahkan Lottie
import '../models/plant_identification.dart';
import '../models/plant_detail.dart';
import '../services/plant_api_service.dart';
import '../widgets/custom_app_bar.dart';

class PlantDetailScreen extends StatefulWidget {
  final PlantIdentification identification;

  PlantDetailScreen({required this.identification});

  @override
  _PlantDetailScreenState createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  PlantDetail? _plantDetail;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchPlantDetails();
  }

  Future<void> _fetchPlantDetails() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final detail = await PlantApiService.getPlantDetails(widget.identification.gbifId);
      setState(() {
        _plantDetail = detail;
        _isLoading = false;
      });
    } catch (e) {
      print('Error occurred: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch plant details. Please try again.')),
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
              CustomAppBar(title: widget.identification.species),
              Expanded(
                child: _isLoading
                    ? Center(
                        // Ganti CircularProgressIndicator dengan Lottie animasi loading
                        child: Lottie.asset(
                          'assets/images/Animation - 1726286806585.json', // Pastikan path animasi benar
                          width: 150,
                          height: 150,
                        ),
                      )
                    : _plantDetail == null
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  'assets/images/Animation - 1726507954618.json', // Animasi jika data tidak tersedia
                                  width: 150,
                                  height: 150,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'No details available',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildHeader(),
                                  _buildDetailSection('Scientific Name', _plantDetail!.scientificName),
                                  _buildDetailSection('Family', _plantDetail!.family),
                                  _buildDetailSection('Common Names', _plantDetail!.commonNames.join(', ')),
                                  _buildDetailSection('Description', _plantDetail!.description),
                                  _buildDetailSection('Habitat', _plantDetail!.habitat),
                                  _buildDetailSection('Distribution', _plantDetail!.distribution),
                                ],
                              ),
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.identification.species,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold, color: Colors.teal[800]),
          ),
          SizedBox(height: 8),
          Text(
            'Family: ${widget.identification.family}',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.teal[600]),
          ),
          SizedBox(height: 8),
          Text(
            'Probability: ${(widget.identification.probability * 100).toStringAsFixed(2)}%',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.teal[800]),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String title, String content) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.teal[800], fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
