import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/util/global_data.dart';

class TaskDetailEdit extends StatefulWidget {
  @override
  _TaskDetailEditState createState() => _TaskDetailEditState();
}

class _TaskDetailEditState extends State<TaskDetailEdit> {
  Widget _customAppBar() {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 12,
              ),
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 27,
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.check,
                color: Colors.black,
                size: 27,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      height: constraints.maxHeight * 0.1,
                      width: constraints.maxWidth,
                      child: Center(child: Text("hey"),),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      height: constraints.maxHeight * 0.9,
                      width: constraints.maxWidth,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            this._customAppBar(),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              child: Text(
                                "Add Task",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.only(
                                      bottom: 5,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Task Info",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    child: Text(
                                      "Name",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: INPUT_BG_COLOR,
                                      border: Border.all(color: Colors.transparent, width: 1),
                                    ),
                                    child: TextFormField(
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.emailAddress,
                                      onFieldSubmitted: (value) {},
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    child: Wrap(
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Description",
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        true
                                            ? SizedBox()
                                            : Text(
                                          "(ကွက်လပ်အဖြစ်ထားခဲ့လို့မရပါ)",
                                          style: TextStyle(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: INPUT_BG_COLOR,
                                      border: Border.all(
                                          color: true
                                              ? Colors.transparent
                                              : Colors.red,
                                          width: 1),
                                    ),
                                    child: TextField(
//                      controller: _contentController,
//                      focusNode: _contentFocus,
                                      textInputAction: TextInputAction.newline,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 3,
                                      style: TextStyle(

                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.only(
                                      bottom: 5,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Detail",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 15,
                                    ),
                                    decoration: BoxDecoration(
                                      color: INPUT_BG_COLOR,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 0,
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Expanded(
                                                flex: 5,
                                                child: Container(
                                                  child: Text(
                                                    "Date",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Container(
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                    "10 Jul 2020",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  child: Icon(
                                                    Icons.chevron_right,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: const Color.fromRGBO(0, 0, 0, 0.1),
                                          thickness: 0.5,
                                          height: 0,
                                        ),

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
