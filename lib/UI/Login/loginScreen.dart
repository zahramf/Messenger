import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/BloC/Login/loginBloc.dart';
import 'package:messenger/Widget/InputFieldArea.dart';
import 'package:messenger/routes/router.gr.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController userNameController, passController;
  LoginBloc loginBloc;

  @override
  void initState() {
    super.initState();
    this.loginBloc = BlocProvider.of<LoginBloc>(context);
    this.userNameController = new TextEditingController();
    this.passController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (state is LoginStateCompleted) {
          Future.delayed(const Duration(microseconds: 500), () {
            print("Press");
            ExtendedNavigator.of(context).push(
              Routes.mainScreen,
            );
            //Navigator.of(context).pushReplacementNamed('/main-screen');
            //  Navigator.popAndPushNamed(context, '/main');
          });
        }
        if (state is LoginStateInitial || state is LoginStateInProgress) {
          return buildUiBasedLoginState(state);
        }
        return Container();
      }),
    );
  }

  Widget buildUiBasedLoginState(LoginState state) {
    timeDilation = .4;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        //child: SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(top: 70, bottom: 30),
              child: new Container(
                width: width,
                height: height * 0.25,
                child: Image.asset("assets/images/loginIcon.png"),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: new InputField(
                textController: userNameController,
                hint: 'نام کاربری خود را وارد کنید',
                label: 'نام کاربری',
                obscure: false,
                icon: Icons.person,
                radius: 15,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            new Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: new InputField(
                textController: passController,
                hint: 'رمز عبور خود را وارد کنید',
                label: ' رمز عبور',
                obscure: false,
                icon: Icons.vpn_key,
                radius: 15,
                // suffixIcon: Icon(Icons.lock),
              ),
            ),
            // (state is )
            new Padding(
              padding: const EdgeInsets.only(top: 40),
              child: new ButtonTheme(
                  minWidth: width * .85,
                  height: 55,
                  child: new RaisedButton(
                    onPressed: () {
                      this.loginBloc.add(new LoginEventLogin(
                          userName: userNameController.text,
                          pass: passController.text));
                    },
                    child: new Text(
                      'ورود',
                      style: new TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    color: new Color(0xff333399),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  )),
            )
          ],
        ),

        //),
      ),
    );
  }
}
