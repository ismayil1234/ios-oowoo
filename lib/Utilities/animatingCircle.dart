import 'dart:math';
import 'package:flutter/material.dart';

class AnimatingCircle extends StatefulWidget {
  @override
  _AnimatingCircleState createState() => _AnimatingCircleState();
}

class _AnimatingCircleState extends State<AnimatingCircle>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animationRotation;
  Animation<double> animationRadiusIn;
  Animation<double> animationRadiusOut;
  Animation<Color> animationColor1;
  Animation<Color> animationColor2;
  Animation<Color> animationColor3;
  Animation<Color> animationColor4;
  Animation<Color> animationColor5;
  double initialRadius = 20;
  double radius = 0;
  double innerRad = 18;

  //Ist :starts wth green

//  Green 0XFF73fc03
  //  yellow 0XFFd7fc03
  //  Brown 0XFFd15658
  //  pink 0XFFf081e3
//  Blue 0XFF03d3fc

  Animatable<Color> color1 = TweenSequence([
    TweenSequenceItem(
        tween: ColorTween(begin: Color(0XFF73fc03), end: Color(0XFFd7fc03)),
        weight: 1),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Color(0XFFd7fc03), end: Color(0XFFd15658)),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Color(0XFFd15658), end: Color(0XFFf081e3)),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Color(0XFFf081e3), end: Color(0XFF03d3fc)),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Color(0XFF03d3fc), end: Color(0XFF73fc03)),
    ),
  ]);

//second starts with yellow
  Animatable<Color> color2 = TweenSequence([
    TweenSequenceItem(
        tween: ColorTween(begin: Color(0XFFd7fc03), end: Color(0XFFd15658)),
        weight: 1),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Color(0XFFd15658), end: Color(0XFFf081e3)),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Color(0XFFf081e3), end: Color(0XFF03d3fc)),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Color(0XFF03d3fc), end: Color(0XFF73fc03)),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Color(0XFF73fc03), end: Color(0XFFd7fc03)),
    ),
    //
  ]);

  //3rd starts with brown
  Animatable<Color> color3 = TweenSequence([
    TweenSequenceItem(
        tween: ColorTween(begin: Color(0XFFd15658), end: Color(0XFFf081e3)),
        weight: 1),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Color(0XFFf081e3), end: Color(0XFF03d3fc)),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Color(0XFF03d3fc), end: Color(0XFF73fc03)),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Color(0XFF73fc03), end: Color(0XFFd7fc03)),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Color(0XFFd7fc03), end: Color(0XFFd15658)),
    ),
  ]);

  //4th starts with pink
  Animatable<Color> color4 = TweenSequence([
    TweenSequenceItem(
        tween: ColorTween(begin: Color(0XFFf081e3), end: Color(0XFF03d3fc)),
        weight: 1),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Color(0XFF03d3fc), end: Color(0XFF73fc03)),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Color(0XFF73fc03), end: Color(0XFFd7fc03)),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Color(0XFFd7fc03), end: Color(0XFFd15658)),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Color(0XFFd15658), end: Color(0XFFf081e3)),
    ),
  ]);

  //5th starts with Blue
  Animatable<Color> color5 = TweenSequence([
    TweenSequenceItem(
        tween: ColorTween(begin: Color(0XFF03d3fc), end: Color(0XFF73fc03)),
        weight: 1),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Color(0XFF73fc03), end: Color(0XFFd7fc03)),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Color(0XFFd7fc03), end: Color(0XFFd15658)),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Color(0XFFd15658), end: Color(0XFFf081e3)),
    ),
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(begin: Color(0XFFf081e3), end: Color(0XFF03d3fc)),
    ),
  ]);

  Center getDot(double radius, Color color) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(seconds: 4),
        width: radius,
        height: radius,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationRadiusIn = Tween<double>(begin: 1, end: 0.5)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    animationRadiusOut = Tween<double>(begin: 0.5, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    animationRotation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: controller, curve: Interval(0, 1, curve: Curves.linear)));
    animationColor1 = color1.animate(controller);
    animationColor2 = color2.animate(controller);
    animationColor3 = color3.animate(controller);
    animationColor4 = color4.animate(controller);
    animationColor5 = color5.animate(controller);
    controller.addListener(() {
      setState(() {
        if (controller.value >= .5 && controller.value <= 1) {
          radius = animationRadiusIn.value * initialRadius * 1.5;
        } else if (controller.value >= 0 && controller.value < .5) {
          radius = animationRadiusOut.value * initialRadius * 1.5;
        }
      });
    });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        child: Center(
          child: RotationTransition(
            turns: animationRotation,
            child: Stack(
              children: [
                SizedBox(height: 25, width: 25),
                Transform.translate(
                    offset:
                        Offset(radius * cos(pi / 2.5), radius * sin(pi / 2.5)),
                    child: Center(
                      child: AnimatedBuilder(
                        animation: controller,
                        builder: (context, child) => Container(
                          width: innerRad,
                          height: innerRad,
                          decoration: BoxDecoration(
                              color: animationColor1.value,
                              shape: BoxShape.circle),
                        ),
                      ),
                    )),
                Transform.translate(
                    offset: Offset(
                        radius * cos(2 * pi / 2.5), radius * sin(2 * pi / 2.5)),
                    child: Center(
                      child: AnimatedBuilder(
                        animation: controller,
                        builder: (context, child) => Container(
                          width: innerRad,
                          height: innerRad,
                          decoration: BoxDecoration(
                              color: animationColor2.value,
                              shape: BoxShape.circle),
                        ),
                      ),
                    )),
                Transform.translate(
                    offset: Offset(
                        radius * cos(3 * pi / 2.5), radius * sin(3 * pi / 2.5)),
                    child: Center(
                      child: AnimatedBuilder(
                        animation: controller,
                        builder: (context, child) => Container(
                          // duration: Duration(seconds: 4),
                          width: innerRad,
                          height: innerRad,
                          decoration: BoxDecoration(
                              color: animationColor3.value,
                              shape: BoxShape.circle),
                        ),
                      ),
                    )),
                Transform.translate(
                    offset: Offset(
                        radius * cos(4 * pi / 2.5), radius * sin(4 * pi / 2.5)),
                    child: Center(
                      child: AnimatedBuilder(
                        animation: controller,
                        builder: (context, child) => Container(
                          width: innerRad,
                          height: innerRad,
                          decoration: BoxDecoration(
                              color: animationColor4.value,
                              shape: BoxShape.circle),
                        ),
                      ),
                    )),
                Transform.translate(
                    offset: Offset(
                        radius * cos(5 * pi / 2.5), radius * sin(5 * pi / 2.5)),
                    child: Center(
                      child: AnimatedBuilder(
                        animation: controller,
                        builder: (context, child) => Container(
                          width: innerRad,
                          height: innerRad,
                          decoration: BoxDecoration(
                              color: animationColor5.value,
                              shape: BoxShape.circle),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
