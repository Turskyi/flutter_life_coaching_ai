import 'package:flutter/material.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:lifecoach/router/app_route.dart';

class HomeAppBarButton extends StatelessWidget {
  const HomeAppBarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoute.home.path,
            // This predicate removes all routes from the stack without
            // exceptions.
            (Route<Object?> route) => false,
          );
        },
        borderRadius: BorderRadius.circular(100),
        child: const ClipOval(
          child: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('${constants.imagePath}logo.png'),
          ),
        ),
      ),
    );
  }
}
