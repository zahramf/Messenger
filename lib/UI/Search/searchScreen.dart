//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/BloC/Search/searchBloc.dart';
import 'package:messenger/Model/SearchModel.dart';
import 'package:messenger/Model/SentModel.dart';
import 'package:messenger/Widget/InputFieldArea.dart';
import 'package:messenger/Widget/TextFieldBack.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController titleCobtroller, textController, userController;
  SearchBloc searchBloc;

  @override
  void initState() {
    super.initState();
    this.searchBloc = BlocProvider.of<SearchBloc>(context);
    this.titleCobtroller = new TextEditingController();
    this.textController = new TextEditingController();
    this.userController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
//        : Icon(Icons.search),
        title: Text("جستجو ", style: TextStyle(fontSize: 13)),
      ),
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
        if (state is SearchStateCompleted) {
          Future.delayed(const Duration(seconds: 3), () {
            //  Navigator.popAndPushNamed(context, '/main');
          });
        }
        if (state is SearchStateInitial || state is SearchStateInProgress) {
          return buildUiBasedSearchState(state);
        }
        return Text("M");
      }),
    );
  }

  Widget buildUiBasedSearchState(SearchState state) {
    // timeDilation = .4;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: <Widget>[
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              new Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 30, bottom: 10),
                  child: TextFieldBack(
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: titleCobtroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.assignment),
                        hintText: "عنوان مورد درنظر را وارد کنید",
                        labelText: " جستجو در عنوان",
                      ),
                    ),
                  )

                  /*new InputField(
                  textController: titleCobtroller,
                  hint: 'عنوان مورد نظر را وارد کنید',
                  label: 'جستجو در عنوان',
                  obscure: false,
                  icon: Icons.title_sharp,
                  radius: 10,
                ),*/
                  ),
              new Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                  child: TextFieldBack(
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: userController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.assignment),
                        hintText: "نام مورد درنظر را وارد کنید",
                        labelText: " جستجو در نام و نام خانوادگی",
                      ),
                    ),
                  )
                  /*new InputField(
                  textController: userController,
                  hint: 'نام مورد نظر را وارد کنید',
                  label: ' جستجو در نام و نام خانوادگی',
                  obscure: false,
                  icon: Icons.person,
                  radius: 10,

                  // suffixIcon: Icon(Icons.lock),
                ),*/
                  ),
              new Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: TextFieldBack(
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: textController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.assignment),
                        hintText: "عبارت مورد درنظر را وارد کنید",
                        labelText: " جستجو در متن",
                      ),
                    ),
                  )
                  /* new InputField(
                  textController: textController,
                  hint: 'عبارت مورد نظر را وارد کنید',
                  label: ' جستجو در متن',
                  obscure: false,
                  icon: Icons.subject_outlined,
                  radius: 10,

                  // suffixIcon: Icon(Icons.lock),
                ),*/
                  ),
            ],
          ),
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ButtonTheme(
                minWidth: width * .25,
                height: 40,
                child: new RaisedButton(
                  onPressed: () {
                    this.searchBloc.add(new SearchEventSearch(
                        title: titleCobtroller.text,
                        name: userController.text,
                        text: textController.text));
                  },
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(
                        'جستجو',
                        style: new TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  color: Colors.blue[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                )),
            ButtonTheme(
                minWidth: width * .25,
                height: 40,
                child: new RaisedButton(
                  onPressed: () {},
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Text(
                        'لغو',
                        style: new TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.cancel,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  color: Colors.red[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                )),
          ],
        )
      ],
    );
    /*Container(
      // height: height,
      //width: width,
      child: Expanded(
          child: new SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
              child: new InputField(
                textController: subjectCobtroller,
                hint: 'عنوان مورد نظر را وارد کنید',
                label: 'جستجو در عنوان',
                obscure: false,
                icon: Icons.title_sharp,
                radius: 10,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            new Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: new InputField(
                textController: nameController,
                hint: 'نام مورد نظر را وارد کنید',
                label: ' جستجو در نام و نام خانوادگی',
                obscure: false,
                icon: Icons.person,
                radius: 15,

                // suffixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            new Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: new InputField(
                textController: wordController,
                hint: 'عبارت مورد نظر را وارد کنید',
                label: ' جستجو در متن',
                obscure: false,
                icon: Icons.subject_outlined,
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
                      this.searchBloc.add(new SearchEventSearch(
                          subject: subjectCobtroller.text,
                          name: nameController.text,
                          word: wordController.text));
                    },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(
                          'جستجو',
                          style: new TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    color: new Color(0xff333399),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  )),
            )
          ],
        ),
      )),
    );*/
  }
}
