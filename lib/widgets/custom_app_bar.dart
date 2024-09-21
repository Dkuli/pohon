import 'package:flutter/material.dart';
import 'package:pohon/screens/identification_history_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
    
      centerTitle: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          icon: Icon(Icons.history, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IdentificationHistoryScreen(),
              ),
            );
          },
        ),
      ],
      
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}