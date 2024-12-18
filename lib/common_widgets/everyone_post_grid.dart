import 'package:flutter/material.dart';
import 'package:locket/features/users/member.dart';

class EveryoneGridViewWidget extends StatelessWidget {
  final List<Member> users;
  final Color mobileBackGroundColorDark;

  const EveryoneGridViewWidget({super.key, required this.users, required this.mobileBackGroundColorDark});

  @override
  Widget build(BuildContext context) {
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
}