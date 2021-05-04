import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/BloC/NewMessage/bloc/new_messageBloc.dart';
import 'package:messenger/Widget/InputFieldArea.dart';

class NewMsgScreen extends StatefulWidget {
  @override
  _NewMsgScreenState createState() => _NewMsgScreenState();
}

class _NewMsgScreenState extends State<NewMsgScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController receiverController, subjectController, textController;
  NewmessageBloc newmessageBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.newmessageBloc = BlocProvider.of<NewmessageBloc>(context);
    this.receiverController = new TextEditingController();
    this.subjectController = new TextEditingController();
    this.textController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<NewmessageBloc, NewmessageState>(
          builder: (context, state) {
        if (state is NewmessageCompleted) {
          Future.delayed(const Duration(seconds: 3), () {
            //  Navigator.popAndPushNamed(context, '/main');
          });
        }
        if (state is NewmessageInitial || state is NewmessageInProgress) {
          return buidUiBasedNewMsgState(state);
        }
        return Text("M");
      }),
    );
  }

  Widget buidUiBasedNewMsgState(NewmessageState state) {
    // timeDilation = .4;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
//        : Icon(Icons.search),
        title: Text("نوشتن پیام ", style: TextStyle(fontSize: 13)),
      ),
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(left: 15, right: 10, top: 30),
                child: new InputField(
                  textController: receiverController,
                  hint: 'نام گیرنده پیام را وارد کنید',
                  label: 'گیرنده',
                  obscure: false,
                  icon: Icons.person_add_alt_1_outlined,
                  radius: 15,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              new Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: new InputField(
                  textController: subjectController,
                  hint: 'عنوان پیام را وارد کنید',
                  label: ' عنوان ',
                  obscure: false,
                  icon: Icons.title,
                  radius: 15,
                  // suffixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              new Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: new InputField(
                  textController: textController,
                  // hint: 'پیام ',
                  label: ' متن',
                  obscure: false,
                  icon: Icons.message,
                  radius: 15,
                  // suffixIcon: Icon(Icons.lock),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(80),
                child: new ButtonTheme(
                    minWidth: width * .25,
                    height: 50,
                    child: new RaisedButton(
                      onPressed: () {
                        this.newmessageBloc.add(new NewmessageEventSend(
                            receiver: receiverController.text,
                            subject: subjectController.text,
                            text: textController.text));
                      },
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(
                            'ارسال',
                            style: new TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      color: new Color(0xff333399),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
