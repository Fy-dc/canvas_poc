import 'package:flutter/material.dart';

class PlaceController extends StatelessWidget {
  const PlaceController({required this.movePlace, Key? key}) : super(key: key);
  final Function movePlace;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(), // big empty space up top
        // the bottom part
        Row(
          children: [
            const Spacer(), // left of directional buttons
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 50),
                    GestureDetector(
                      child: Container(
                        height: 48,
                        width: 48,
                        color: const Color(0xffffffff),
                        child: const Center(
                          child: Icon(Icons.keyboard_arrow_up, size: 32),
                        ),
                      ),
                      onTap: () {
                        movePlace('UP');
                      },
                    ),
                    const SizedBox(width: 50),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 48,
                        width: 48,
                        color: const Color(0xffffffff),
                        child: const Center(
                          child: Icon(Icons.keyboard_arrow_left, size: 32),
                        ),
                      ),
                      onTap: () {
                        movePlace('LEFT');
                      },
                    ),
                    const SizedBox(width: 50),
                    GestureDetector(
                      child: Container(
                        height: 48,
                        width: 48,
                        color: const Color(0xffffffff),
                        child: const Center(
                          child: Icon(Icons.keyboard_arrow_right, size: 32),
                        ),
                      ),
                      onTap: () {
                        movePlace('RIGHT');
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(width: 50),
                    GestureDetector(
                      child: Container(
                        height: 48,
                        width: 48,
                        color: const Color(0xffffffff),
                        child: const Center(
                          child: Icon(Icons.keyboard_arrow_down, size: 32),
                        ),
                      ),
                      onTap: () {
                        movePlace('DOWN');
                      },
                    ),
                    const SizedBox(width: 50),
                  ],
                ),
              ],
            ), // the directional buttons
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
