import 'package:flutter/material.dart';
import 'package:new_pro/screens/add_post.dart';

import 'package:new_pro/screens/home.dart';

import 'package:new_pro/screens/login_screen.dart';
import 'package:new_pro/screens/mange_hall.dart';
import 'package:new_pro/screens/my_posts.dart';
import 'package:new_pro/screens/registration_screen.dart';
import 'package:new_pro/screens/search.dart';
import 'package:new_pro/screens/showUserReservation.dart';

import 'package:new_pro/screens/welcome_screen.dart';

void main() => runApp(const FlashChat());

class FlashChat extends StatelessWidget {
  const FlashChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) =>  const WelcomeScreen(),
        'login_screen': (context) => const LoginMain(),
        'search user': (context) => const SearchUser(),
        'registration_screen': (context) =>  const RegesterMain(),
        'home': (context) =>  const HomeMain(),

        'hall_owner': (context) => const AddPostMain(),
        'search': (context) =>  const Search(),
        'showPost': (context) =>  const PostsMain(),

        'manage_hall': (context) =>  const MangeMain(),
      }
    );
  }
}
