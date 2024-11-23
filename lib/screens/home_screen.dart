import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:locket/data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedName = 'Hoang'; // Default name
  late List<String> selectedImageUrls; // List of image URLs
  late String selectedMessage; // Declare message variable
  List<String> names = []; // List of names
  int currentIndex = 0; // Track current image index for PageView

  @override
  void initState() {
    super.initState();
    // Initialize names, selectedImageUrls, and selectedMessage
    names = imageUrls.keys.toList(); // List of names
    selectedImageUrls = imageUrls[selectedName]!; // List of corresponding URLs
    selectedMessage = messages[selectedName]!; // Corresponding message
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Stack(
        children: [
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton<String>(
                      value: selectedName,
                      items: names.map((String name) {
                        return DropdownMenuItem<String>(
                          value: name,
                          child: Text(name, style: const TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedName = newValue!;
                          selectedImageUrls = imageUrls[selectedName]!; // Update list of URLs
                          selectedMessage = messages[selectedName]!; // Update corresponding message
                          currentIndex = 0; // Reset index when switching users
                        });
                      },
                      dropdownColor: Colors.grey[800],
                    ),
                    const Icon(Icons.notifications, color: Colors.white),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.zero,
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: PageView.builder(
                              scrollDirection: Axis.vertical,
                              onPageChanged: (index) {
                                setState(() {
                                  currentIndex = index; // Update the index on page change
                                });
                              },
                              itemCount: selectedImageUrls.length, // Number of images
                              itemBuilder: (context, index) {
                                return Image.network(
                                  selectedImageUrls[index], // Display corresponding image URL
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                selectedMessage, // Display corresponding message
                                style: const TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                selectedName, // Display corresponding name outside the image
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                margin: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Send message...',
                          hintStyle: const TextStyle(color: Colors.white54),
                          filled: true,
                          fillColor: Colors.grey[700],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.yellow),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}