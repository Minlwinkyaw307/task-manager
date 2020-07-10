import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/util/global_data.dart';

class TaskDetailEdit extends StatefulWidget {
  @override
  _TaskDetailEditState createState() => _TaskDetailEditState();
}

class _TaskDetailEditState extends State<TaskDetailEdit> {
  DateTime _taskStartDate = DateTime.now();
  DateTime _taskEndDate = DateTime.now().add(Duration(days: 1));
  TimeOfDay _taskStartTime = TimeOfDay.now();
  TimeOfDay _taskEndTime = TimeOfDay.now().replacing(
    hour: TimeOfDay.now().hour + 1,
  );

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

  Widget _inputTextField() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 3,
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
    );
  }

  Widget _textArea() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: INPUT_BG_COLOR,
        border:
            Border.all(color: true ? Colors.transparent : Colors.red, width: 1),
      ),
      child: TextField(
//                      controller: _contentController,
//                      focusNode: _contentFocus,
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        style: TextStyle(),
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _detailListTile(String title, String defaultValue, Function onClick) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                child: Text(
                  title,
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
                  defaultValue,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = new DateFormat('dd MMMM yyyy');
    final timeFormat = new DateFormat('HH:mm');

    print(MediaQuery.of(context).viewInsets.bottom == 0);
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: Stack(
                children: <Widget>[
                  MediaQuery.of(context).viewInsets.bottom != 0.0
                      ? Container()
                      : Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            height: constraints.maxHeight * 0.1,
                            width: constraints.maxWidth,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      child: Text("Delete", style: TextStyle(
                                        fontSize: 16,
                                        color: CANCELED_COLOR,
                                        fontWeight: FontWeight.bold,
                                      ),
                                        textAlign: TextAlign.center,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: CANCELED_COLOR,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(0)
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      child: Text("Save", style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                        textAlign: TextAlign.center,
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: DONE_COLOR,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(0),
                                        color: DONE_COLOR,

                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                    ),
                                  ),
                                ),


                              ],
                            ),
                          ),
                        ),
                  Positioned(
                    child: Container(
                      height: MediaQuery.of(context).viewInsets.bottom == 0.0
                          ? constraints.maxHeight
                          : constraints.maxHeight * 0.9,
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
                                  // Top Title
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
                                  _inputTextField(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
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
                                  _textArea(),
                                  SizedBox(
                                    height: 20,
                                  ),
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
                                        _detailListTile(
                                          'Start Date',
                                          _taskStartDate != null ? dateFormat.format(_taskStartDate) : dateFormat.format(DateTime.now()),
                                          () {
                                            showDatePicker(
                                                    context: context,
                                                    initialDate: _taskStartDate != null ? _taskStartDate : DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime(3000))
                                                .then((date) {
                                              setState(() {
                                                if(date != null)
                                                  this._taskStartDate = date;
                                              });
                                            });
                                          },
                                        ),
                                        Divider(
                                          color: const Color.fromRGBO(
                                              0, 0, 0, 0.1),
                                          thickness: 0.5,
                                          height: 0,
                                        ),
                                        _detailListTile(
                                          'Start Time',
                                          _taskStartTime == null ? "Not Setted" : _taskStartTime.format(context),
                                              () {
                                                showTimePicker(context: context, initialTime: _taskStartTime == null ? TimeOfDay.now() : _taskStartTime).then((time){
                                                  setState(() {
                                                    if(time != null) this._taskStartTime = time;
                                                  });
                                                });
                                              },
                                        ),
                                        Divider(
                                          color: const Color.fromRGBO(
                                              0, 0, 0, 0.1),
                                          thickness: 0.5,
                                          height: 0,
                                        ),
                                        _detailListTile(
                                          'End Date',
                                          _taskEndDate != null ? dateFormat.format(_taskEndDate) : dateFormat.format(DateTime.now().add(Duration(days: 1))),
                                              () {
                                            showDatePicker(
                                                context: context,
                                                initialDate: _taskEndDate != null ? _taskEndDate : DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(3000))
                                                .then((date) {
                                              setState(() {
                                                if(date != null) this._taskStartDate = date;
                                              });
                                            });
                                          },
                                        ),
                                        Divider(
                                          color: const Color.fromRGBO(
                                              0, 0, 0, 0.1),
                                          thickness: 0.5,
                                          height: 0,
                                        ),
                                        _detailListTile(
                                          'End Time',
                                          _taskEndTime == null ? "Not Setted" : _taskEndTime.format(context),
                                              () {
                                            showTimePicker(context: context, initialTime: _taskEndTime == null ? TimeOfDay.now() : _taskEndTime).then((time){
                                              setState(() {
                                                if(time != null) this._taskEndTime = time;
                                              });
                                            });
                                          },
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
