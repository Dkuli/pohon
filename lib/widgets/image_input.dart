import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatelessWidget {
  final Function(File) onImageSelected;

  ImageInput({required this.onImageSelected});

  // Show bottom sheet to choose between camera and gallery
  Future<void> _showImageSourceBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Choose Image Source',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildImageSourceButton(
                    context,
                    icon: Icons.camera_alt,
                    label: 'Camera',
                    source: ImageSource.camera,
                  ),
                  _buildImageSourceButton(
                    context,
                    icon: Icons.photo_library,
                    label: 'Gallery',
                    source: ImageSource.gallery,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Button for choosing image source
  Widget _buildImageSourceButton(BuildContext context, {required IconData icon, required String label, required ImageSource source}) {
    return Column(
      children: [
        IconButton(
          iconSize: 48,
          icon: Icon(icon, color: Colors.teal[800]),
          onPressed: () {
            Navigator.pop(context); // Close the bottom sheet
            _pickImage(context, source); // Pick image from the selected source
          },
        ),
        Text(label, style: TextStyle(color: Colors.teal[800])),
      ],
    );
  }

  // Image picker function with source option
  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      onImageSelected(imageFile); // Callback to pass selected image to parent widget
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => _showImageSourceBottomSheet(context),
      icon: Icon(Icons.camera_alt, color: Colors.white),
      label: Text('Identify Plant', style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.teal[800],
    );
  }
}
