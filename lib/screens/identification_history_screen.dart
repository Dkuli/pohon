import 'package:flutter/material.dart';
import '../models/plant_identification.dart';
import '../widgets/plant_card.dart';
import '../widgets/custom_app_bar.dart';
import '../services/database_service.dart';
import 'plant_detail_screen.dart';

class IdentificationHistoryScreen extends StatelessWidget {
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
              CustomAppBar(title: 'Identification History'),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: FutureBuilder<List<PlantIdentification>>(
                    future: DatabaseService.getIdentificationHistory(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.history, size: 64, color: Colors.grey),
                              SizedBox(height: 16),
                              Text(
                                'No identification history',
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return ListView.builder(
                          padding: EdgeInsets.all(16),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return PlantCard(
                              identification: snapshot.data![index],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlantDetailScreen(
                                      identification: snapshot.data![index],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}