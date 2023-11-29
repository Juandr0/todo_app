import 'package:flutter/material.dart';
import 'package:todo_app/constants/app_sizes.dart';
import 'package:google_fonts/google_fonts.dart';

class Mysman extends StatefulWidget {
  const Mysman({super.key});

  @override
  State<Mysman> createState() => _MysmanState();
}

class _MysmanState extends State<Mysman> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  int animationDurationInSeconds = 3;
  double imageWidth = 200;
  double imageRadius = 500;
  double cardOutlineWidth = 2;
  double tweenBegin = -1.5;
  double tweenEnd = 1.5;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: animationDurationInSeconds),
    )..repeat(reverse: true);

    _animation = Tween(begin: tweenBegin, end: tweenEnd).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 34, 25, 25),
          image: DecorationImage(
            image: AssetImage(
              'assets/themes/hearts.png',
            ),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _animation.value * 3),
                  child: child,
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(imageRadius),
                  side: BorderSide(
                    color:
                        const Color.fromARGB(180, 255, 35, 90).withOpacity(0.5),
                    width: cardOutlineWidth,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(imageRadius),
                  child: Image.asset(
                    'assets/themes/mysman.png',
                    width: imageWidth,
                  ),
                ),
              ),
            ),
            Text(
              'Vila i frid, Buster',
              style: GoogleFonts.dancingScript(
                fontSize: AppSizes.between * 2,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
