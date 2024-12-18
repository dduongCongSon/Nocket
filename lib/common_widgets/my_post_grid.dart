import 'package:flutter/material.dart';
import 'package:locket/features/users/member.dart';

class MyPostGrid extends StatefulWidget {
  final Member selectedUser;
  final int currentIndex;
  final Function(int) onPageChanged;

  const MyPostGrid({
    super.key,
    required this.selectedUser,
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  _MyPostGridState createState() => _MyPostGridState();
}

class _MyPostGridState extends State<MyPostGrid> {
  @override
  Widget build(BuildContext context) {
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
                  widget.onPageChanged(index);
                },
                itemCount: widget.selectedUser.posts.length,
                itemBuilder: (context, index) {
                  return Hero(
                    tag: 'image_${widget.selectedUser.posts[index].image}',
                    child: FractionallySizedBox(
                      heightFactor: 0.75,
                      child: Image.network(
                        widget.selectedUser.posts[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          if (widget.selectedUser.posts.isNotEmpty)
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
                      widget.selectedUser.posts[widget.currentIndex].title,
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
}