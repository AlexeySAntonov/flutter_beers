import 'package:flutter/widgets.dart';
import 'package:flutter_beers/di/favorite_beers_module_container.dart';
import 'package:flutter_beers/di/singleton_module_container.dart';

class AppRouter {
  Route favoriteBeersRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => FavoriteBeersModuleContainer.getScreenComposition(SingletonModuleContainer.get()),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
