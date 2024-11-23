import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locket/screens/camera_screen.dart';

Future<void> navigateToCamera(BuildContext context) async {
  try {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    final String? imagePath = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraScreen(camera: cameras.first),
      ),
    );

    // Handle the captured image path
    if (imagePath != null) {
      // Here you can handle the captured image
      // For example, you could upload it to a server
      // or add it to your local posts
      print('Image captured at: $imagePath');
    }
  } catch (e) {
    print('Error accessing camera: $e');
    // Show error message to user
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Failed to access camera'),
      ),
    );
  }
}