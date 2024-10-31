import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:softdev_foodblog_frontend/screens/view_ingredients.dart';

class NotLogin extends StatelessWidget {
  const NotLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
            width: double.infinity,
            height: 300.0,
            color: Colors.white,
            child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center, 
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Please ', 
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, 
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Log in',
                          style: TextStyle(color: Color(0xFFFFAF30)), 
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Click ', 
                      style: const TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, 
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Here',
                          
                          style: const TextStyle(
                            color: Color(0xFFFFAF30),
                            decoration:TextDecoration.underline
                            ), 
                          recognizer:TapGestureRecognizer()..onTap = (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) => const ViewIngredients(),
                          )
                            );
                          }
                        ),
                      ],
                    ),
                  ),
                ])),
        Expanded(
            child: Container(
              decoration: const BoxDecoration(
              color: Color(0xFFFFAF30),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0))),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.center, 
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/images/corn.png'
                  ),
                  const SizedBox(width: 40),
                  Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center, 
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                    'lib/images/hamburger.png'
                  ),
                  const SizedBox(height: 50),
                  Image.asset(
                    'lib/images/onion.png'
                  ),
                    ],
                  ),
                ],
                
              ),
        ))
      ],
    ));
  }
}
