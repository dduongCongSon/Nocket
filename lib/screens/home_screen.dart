import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:locket/common_widgets/everyone_post_grid.dart';
import 'package:locket/common_widgets/my_post_grid.dart';
import 'package:locket/features/users/data.dart';
import 'package:locket/features/users/member.dart';
import 'package:locket/providers/user_provider.dart';
import 'package:locket/utils/auth_utils.dart';
import 'package:locket/utils/colors.dart';
import 'package:locket/utils/date_time.dart';
import 'package:locket/utils/utils.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Member selectedMember;
  List<Member> userList = [];
  int currentIndex = 0;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;
  final Dio _dio = Dio();
  final String _jwtToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOiIwMTkzY2U4ZS0yODI4LTdkNDMtODFlOS0xYjIyMWZkODIwOTgiLCJlbWFpbCI6InZ5QGdtYWlsLmNvbSIsInN1YiI6InZ5QGdtYWlsLmNvbSIsImV4cCI6MTczNjk1Mjg0MX0.ofbA2zlb77wb-rn5PCwc5cmZF6b3dw3TvX-gOYmOTPc';

  Future<void> _takePicture() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1980,
        maxHeight: 1080,
        imageQuality: 100,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      _showSnackBar('Error taking picture: $e', isError: true);
    }
  }

  // Upload image to backend
  Future<void> _uploadImage() async {
    if (_imageFile == null) {
      _showSnackBar('Please take a photo first', isError: true);
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      // Get the base URL dynamically
      String baseUrl = getBaseUrl() ?? 'http://default-url.com'; // Provide a default URL if null

      // Create FormData for file upload
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          _imageFile!.path,
          filename: 'upload.jpg',
          contentType: DioMediaType(
              'image', 'jpeg'), // Explicitly set the image content type
        ),
      });

      Options options = Options(
        contentType: 'multipart/form-data',
        headers: {
          'Authorization': 'Bearer $_jwtToken',
        },
      );

      // Print the URL for debugging
      if (kDebugMode) {
        print('Uploading to: $baseUrl/api/v1/posts/upload');
      }

      // Send POST request
      Response response = await _dio.post(
        '$baseUrl/api/v1/posts/upload',
        data: formData,
        options: options,
      );

      // Check the response
      if (response.statusCode == 200) {
        _showSnackBar('Image uploaded successfully', isError: false);
        if (kDebugMode) {
          if (response.data != null) {
            print(
                'Access this to view new images: http://localhost:8080/api/v1/assets/images/${response.data['data']['media_meta']['file_name']}');
          } else {
            print('No response data');
          }
        }
        // Clear the image after successful upload
        setState(() {
          _imageFile = null;
        });
      } else {
        _showSnackBar('Upload failed with status ${response.statusCode}',
            isError: true);
      }
    } on DioException catch (e) {
      // Detailed error logging
      if (e.response != null) {
        print('Dio error response: ${e.response?.data}');
        print('Dio error status: ${e.response?.statusCode}');
        _showSnackBar('Error: ${e.response?.data}', isError: true);
      } else {
        print('Dio error message: ${e.message}');
        _showSnackBar('Network Error: ${e.message}', isError: true);
      }
    } catch (e) {
      print('Unexpected error: $e');
      _showSnackBar('Unexpected error: $e', isError: true);
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  // Helper method to show SnackBar
  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    selectedMember = Provider.of<UserProvider>(context, listen: false)
        .userLoginResponse!
        .toMember();
    Member everyone = everyoneData;
    userList = [everyone, hoang, son];
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
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PopupMenuButton<String>(
                      offset: const Offset(0, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CircleAvatar(
                        backgroundImage: selectedMember.avatarUrl != null
                            ? NetworkImage(selectedMember.avatarUrl!)
                            : null,
                        child: selectedMember.avatarUrl == null
                            ? const Icon(Icons.account_circle,
                                color: Colors.white)
                            : null,
                      ),
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'profile',
                          child: Row(
                            children: [
                              Icon(Icons.person, color: Colors.grey),
                              SizedBox(width: 10),
                              Text('Profile'),
                            ],
                          ),
                        ),
                        const PopupMenuDivider(),
                        const PopupMenuItem<String>(
                          value: 'logout',
                          child: Row(
                            children: [
                              Icon(Icons.logout, color: Colors.red),
                              SizedBox(width: 10),
                              Text('Logout',
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                      onSelected: (String value) async {
                        if (value == 'logout') {
                          // Show confirmation dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.grey[900],
                                title: const Text(
                                  'Confirm Logout',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content: const Text(
                                  'Are you sure you want to logout?',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context); // Close dialog
                                      logout(context); // Perform logout
                                    },
                                    child: const Text(
                                      'Logout',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        } else if (value == 'profile') {
                          // Add profile navigation here if needed
                        }
                      },
                    ),
                    // Rest of your Row widgets...
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.zero,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                        );
                      },
                      child: selectedMember.id == -1
                          ? EveryoneGridViewWidget(
                              users: userList,
                              mobileBackGroundColorDark:
                                  mobileBackGroundColorDark,
                            )
                          : MyPostGrid(
                              selectedUser: selectedMember,
                              currentIndex: currentIndex,
                              onPageChanged: (index) {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                            ),
                    ),
                  ),
                ),
              ),
              if (selectedMember.id != -1)
                AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          selectedMember.nickname,
                          key: ValueKey<String>(selectedMember.nickname),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          formatDateTime(selectedMember.createdAt!),
                          // Assuming createdAt is not null
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )),
              if (selectedMember.id != -1)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Send message...',
                                hintStyle:
                                    const TextStyle(color: Colors.white54),
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
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.key, color: Colors.white),
                            onPressed: () {
                              // Implement the function to select "Everyone"
                              setState(() {
                                selectedMember = userList
                                    .firstWhere((user) => user.id == -1);
                                currentIndex = 0;
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.camera_alt, color: Colors.white),
                            onPressed: _takePicture, // Directly call _takePicture method
                          ),
                          IconButton(
                            icon: const Icon(Icons.share, color: Colors.white),
                            onPressed: () {
                              // Implement the share function
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
          if (_imageFile != null)
            Positioned.fill(
              child: Stack(
                children: [
                  // Full-screen image preview
                  Image.file(
                    _imageFile!,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  // Overlay with buttons
                  Positioned(
                    bottom: 30,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Cancel button
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white, size: 30),
                          onPressed: () {
                            setState(() {
                              _imageFile = null;
                            });
                          },
                        ),

                        // Upload button
                        _isUploading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                          onPressed: _uploadImage,
                          child: const Text('Upload'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
