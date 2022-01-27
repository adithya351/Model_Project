
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_login/constants.dart';
import 'package:flutter_login/sign_up_form.dart';
import 'package:flutter_login/LoginForm.dart';
import 'SocalButtns.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>with SingleTickerProviderStateMixin {
//If we want to show up sign up then we can set it to true
  bool _isShowSignUp=false;

  late AnimationController _animationController;
  late Animation<double>_animationTextRotate;
  void setUpAnimation(){
    _animationController=
        AnimationController(vsync: this,duration: defaultDuration);

    _animationTextRotate=Tween<double>(begin: 0,end: 90).animate(_animationController);
  }

  void updateView(){
    setState(() {
      _isShowSignUp=!_isShowSignUp;
    });
   _isShowSignUp ?_animationController.forward()
                  :_animationController.reverse();
  }

  @override
  void initState() {
    setUpAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final _size=MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
        animation:_animationController ,
        builder: (context, snapshot) {
          return Stack(
            children: [
              //Lets animate the transition
              //Login
              AnimatedPositioned(
                duration: defaultDuration,
                width:_size.width*0.88,
                height: _size.height,
                left:_isShowSignUp? -_size.width*0.76:0,
                child: Container(
                  child: GestureDetector(
                    onTap: (){
                    //just for test we use it
                     setState(() {
                       _isShowSignUp=!_isShowSignUp;
                     });
                    },
                    child: Container(
                    color: signup_bg,
                    child: LoginForm(),
              ),
                  ),
                )
              ),


              //Sign Up
              AnimatedPositioned(
                duration: defaultDuration,
                height: _size.height,
                  width: _size.width*0.88,
                  left: _isShowSignUp?_size.width*0.12:_size.width*0.88,
                  child:Container(
                    color:Colors.deepPurple,
                      child: SignUpForm()
                  ),

    ),
              //lets add the logo
              //As you can see our logo is not at the center
              //On sign up form the logo is not in center
              //lets make it



              AnimatedPositioned(
                duration: defaultDuration,
                width: _size.width,
                bottom:_size.height*0.1,
                right:_isShowSignUp

                  ?_size.width*0.06
                : _size.width*0.06,
                child: SocalButtns(),

              ),

              //Login Text
              //Login Text animation done
              AnimatedPositioned(
                duration: defaultDuration,
                bottom:_isShowSignUp
                                    ?_size.height/2-80//now width is its height
                                    : _size.height*0.03,
                  //When our sign up shows we want our text to the left center
                  //As you can see Sign up text not in center
                  right: _isShowSignUp? _size.width*0.44- 80:0,
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    style: TextStyle(
                          fontSize:!_isShowSignUp? 20: 32,
                          fontWeight:FontWeight.bold,
                          color:_isShowSignUp? Colors.white70: Colors.white70

                  ),
                    child: Transform.rotate(
                      angle:(90-_animationTextRotate.value)*pi/180,
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: (){
                          if(_isShowSignUp){
                            updateView();
                          }
                          else{
                              //Login
                          }
                      },
                        child: Container(
                        padding:const EdgeInsets.symmetric(
                          vertical: defpaultPadding*0.75
                        ),
                          width: 160,
                          color: Colors.red,
                          child: Text(
                        "Sign Up".toUpperCase(),
                        textAlign: TextAlign.center,

                    ),
                        ),
                      ),
                    ),
                  )
              ),

              //Sign Up Text
              AnimatedPositioned(
                  duration: defaultDuration,
                  bottom:_isShowSignUp
                      ?_size.height/2-80//now width is its height
                      : _size.height*0.03,
                  //When our sign up shows we want our text to the left center
                  //As you can see Sign up text not in center
                  right: _isShowSignUp? _size.width*0.44- 80:0,
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    style: TextStyle(
                        fontSize:!_isShowSignUp? 20: 32,
                        fontWeight:FontWeight.bold,
                        color:_isShowSignUp? Colors.white70: Colors.white70

                    ),
                    child: Transform.rotate(
                      angle:(90-_animationTextRotate.value)*pi/180,
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: (){
                          if(_isShowSignUp){
                            //Sign Up
                          }
                          else{
                            updateView();
                          }
                        },
                        child: Container(
                          padding:const EdgeInsets.symmetric(
                              vertical: defpaultPadding*0.75
                          ),
                          width: 160,
                          color: Colors.red,
                          child: Text(
                            "Sign Up".toUpperCase(),
                            textAlign: TextAlign.center,

                          ),
                        ),
                      ),
                    ),
                  )
              ),
            ],
          );
        }
      ),
    );
  }
}
