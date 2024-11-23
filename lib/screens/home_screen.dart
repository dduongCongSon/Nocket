import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:locket/data.dart';
import 'package:locket/models/user.dart';
import 'package:locket/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User selectedUser;
  List<User> users = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    User everyoneUser = User(
        id: -1,
        firstName: '',
        lastName: '',
        nickname: 'Everyone',
        email: '',
        address: '',
        password: '',
        isActive: false,
        dateOfBirth: '',
        avatarUrl: null,
        roleName: '',
        posts: []);
    users = [everyoneUser, hoang, son];
    selectedUser = users.first;
  }

  Widget buildGridView() {
    final allPosts = users
        .where((user) => user.id != -1)
        .expand((user) => user.posts)
        .toList();

    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(milliseconds: 300),
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: allPosts.length,
        itemBuilder: (context, index) {
          return Hero(
            tag: 'image_${allPosts[index].image}',
            child: Material(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: mobileBackGroundColorDark,
                  // Set the background color to black
                  child: Image.network(
                    allPosts[index].image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildPageView() {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(milliseconds: 300),
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
                    currentIndex = index;
                  });
                },
                itemCount: selectedUser.posts.length,
                itemBuilder: (context, index) {
                  return Hero(
                    tag: 'image_${selectedUser.posts[index].image}',
                    child: FractionallySizedBox(
                      heightFactor: 0.75,
                      // Set the height to 75% of the original size
                      child: Image.network(
                        selectedUser.posts[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          if (selectedUser.posts.isNotEmpty)
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      selectedUser.posts[currentIndex].title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 1),
                            blurRadius: 3.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
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
                    CircleAvatar(
                      backgroundImage: selectedUser.avatarUrl != null
                          ? NetworkImage(selectedUser.avatarUrl!)
                          : null,
                      child: selectedUser.avatarUrl == null
                          ? const Icon(Icons.account_circle,
                              color: Colors.white)
                          : null,
                    ),
                    DropdownButton<User>(
                      value: selectedUser,
                      items: users.map((User user) {
                        return DropdownMenuItem<User>(
                          value: user,
                          child: Row(
                            children: [
                              if (user.avatarUrl != null)
                                CircleAvatar(
                                  backgroundImage: user.avatarUrl != null
                                      ? NetworkImage(user.avatarUrl!)
                                      : null,
                                ),
                              const SizedBox(width: 10),
                              Text(
                                user.nickname,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (User? newUser) {
                        if (newUser != null) {
                          setState(() {
                            selectedUser = newUser;
                            currentIndex = 0;
                          });
                        }
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
                      child: selectedUser.id == -1
                          ? buildGridView()
                          : buildPageView(),
                    ),
                  ),
                ),
              ),
              if (selectedUser.id != -1)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Text(
                    selectedUser.firstName,
                    key: ValueKey<String>(selectedUser.firstName),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (selectedUser.id != -1)
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
                                selectedUser =
                                    users.firstWhere((user) => user.id == -1);
                                currentIndex = 0;
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.camera_alt,
                                color: Colors.white),
                            onPressed: () {
                              // Implement the function to connect to the phone camera
                            },
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
        ],
      ),
    );
  }
}
