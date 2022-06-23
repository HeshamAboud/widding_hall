
import 'package:flutter/material.dart';
import 'home.dart';

//import 'package:animated_text_kit/animated_text_kit.dart';


class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {


  @override


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
  /*          Row(
              children: <Widget>[

                TypewriterAnimatedTextKit(
                  text: const ['welcome'],
                  textStyle: const TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),*/
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Material(
          elevation: 5.0,
          color:Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          child: MaterialButton(
            onPressed: ()
            {
              Navigator.pushNamed(context, HomeMain.id);
            },
            minWidth: 200.0,
            height: 42.0,
            child: const Text(
              'Get Start',
            ),
          ),
        ),
      ),

          ],
        ),
      ),
    );
  }
}
