import 'dart:ui';
import 'package:flutter/material.dart';
import 'data.dart'; // Ensure this file contains the imageUrls Map and messages Map

void main() {
  runApp(MaterialApp(
    home: SafeArea(
      child: MyHomePage(), // Sử dụng MyHomePage ở đây
    ),
  ));
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedName = 'Giang'; // Tên mặc định
  late String selectedImageUrl; // Khai báo biến URL
  late String selectedMessage; // Khai báo biến cho thông điệp
  List<String> names = []; // Danh sách tên

  @override
  void initState() {
    super.initState();
    // Khởi tạo names, selectedImageUrl và selectedMessage từ imageUrls
    names = imageUrls.keys.toList(); // Danh sách tên
    selectedImageUrl = imageUrls[selectedName]!; // URL tương ứng
    selectedMessage = messages[selectedName]!; // Thông điệp tương ứng
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton<String>(
                      value: selectedName,
                      items: names.map((String name) {
                        return DropdownMenuItem<String>(
                          value: name,
                          child: Text(name, style: TextStyle(color: Colors.white)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedName = newValue!;
                          selectedImageUrl = imageUrls[selectedName]!; // Cập nhật URL tương ứng
                          selectedMessage = messages[selectedName]!; // Cập nhật thông điệp tương ứng
                        });
                      },
                      dropdownColor: Colors.grey[800],
                    ),
                    Icon(Icons.notifications, color: Colors.white),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              selectedImageUrl, // Hiển thị URL tương ứng
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          selectedMessage, // Hiển thị thông điệp tương ứng
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Send message...',
                          hintStyle: TextStyle(color: Colors.white54),
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
                      icon: Icon(Icons.send, color: Colors.yellow),
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
