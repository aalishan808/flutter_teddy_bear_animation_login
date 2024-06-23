import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String animationURL;
  Artboard? _teddyArtboard;
  SMITrigger? succesTrigger, failTrigger;
  SMIBool? isHandsUp, isChecking;
  SMINumber? numLook;
  StateMachineController? stateMachineController;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    animationURL = 'assets/animated_login_character_.riv';
    rootBundle.load(animationURL).then((data){
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
       stateMachineController=
           StateMachineController.fromArtboard(
               artboard, 'Login Machine');
        if(stateMachineController!=null){
          artboard.addController(stateMachineController!);
          stateMachineController!.inputs.forEach((e) {
            debugPrint(e.runtimeType.toString());
            debugPrint("name: ${e.name}End");
          });
          stateMachineController!.inputs.forEach((element){
            if(element.name == 'success'){
              succesTrigger = element as SMITrigger;
            }else if(element.name == 'trigFail'){
              failTrigger = element as SMITrigger;
            }
            else if(element.name == 'isHandsUp'){
              isHandsUp = element as SMIBool;
            }
            else if(element.name == 'isChecking'){
              isChecking = element as SMIBool;
            }
            else if(element.name == 'numLook'){
              numLook = element as SMINumber;
            }
          });
        }
        setState(()=>_teddyArtboard = artboard);
    });
    super.initState();
  }
  void handsOnEyes(){
    isHandsUp?.change(true);
  }
  void lookOnTheFeild(){
    isHandsUp?.change(false);
    isChecking?.change(true);
    numLook?.change(0);
  }
  void moveEyeBalls(val){
    numLook?.change(val.length.toDouble());
  }
  void login() async{
    await isChecking?.change(false);
   await isHandsUp?.change(false);
    setState(() {
    });
    if(_emailController.text == 'admin' && _passwordController.text == 'admin'){
      succesTrigger?.fire();
  }else{
      failTrigger?.fire();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd6e2ea),
      body: SingleChildScrollView(
        child:Column(

          children: [
            SizedBox(height: 110),
            SizedBox(
            width: 390,
              height: 250,
              child: Rive(
              artboard: _teddyArtboard!,
              fit: BoxFit.contain,
            ),
            ),

                  Container(
            alignment: Alignment.center,
            width: 400,
            padding: EdgeInsets.only(bottom: 15),
            margin: EdgeInsets.only(bottom: 15*4),
            decoration: BoxDecoration(
              color: Color(0xff4a55ff),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(

                children: [
                  const SizedBox(height: 15 * 2),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: moveEyeBalls,
                    onTap: lookOnTheFeild,
                    style: const TextStyle(fontSize: 14),
                    cursorColor: const Color(0xff3d3bc9),
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusColor: Color(0xff3d3bc9),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff3d3bc9),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    onTap: handsOnEyes,
                    style: const TextStyle(fontSize: 14),
                    cursorColor: const Color(0xff3d3bc9),
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusColor: Color(0xff3d3bc9),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff3d3bc9),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff3d3bc9),
                    ),
                    onPressed: login,
                    child: const Text('Login', style: TextStyle(color: Colors.white),),),
                ],
              ),
            ),
                  ),
          ],
        ),
      ),
    );
  }
}
