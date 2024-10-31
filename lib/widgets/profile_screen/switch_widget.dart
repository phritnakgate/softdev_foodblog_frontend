import 'package:flutter/material.dart';

class SwitchWidget extends StatelessWidget {
  final bool showPosts;
  final ValueChanged<bool> onSwitch;

  const SwitchWidget({
    super.key,
    required this.showPosts,
    required this.onSwitch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => onSwitch(true),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: showPosts ? Colors.orangeAccent : Colors.transparent,
                  width: 3,
                ),
              ),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
            child: Text(
              'My Posts',
              style: TextStyle(
                fontSize: 18,
                fontWeight: showPosts ? FontWeight.bold : FontWeight.normal,
                color: showPosts ? Colors.orangeAccent : Colors.grey,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () => onSwitch(false),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: showPosts ? Colors.transparent : Colors.orangeAccent,
                  width: 3,
                ),
              ),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
            child: Text(
              'Liked Posts',
              style: TextStyle(
                fontSize: 18,
                fontWeight: showPosts ? FontWeight.normal : FontWeight.bold,
                color: showPosts ? Colors.grey : Colors.orangeAccent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
