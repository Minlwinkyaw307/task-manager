import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/provider/task_provider.dart';
import 'package:task_manager/util/global_data.dart';

class TaskDetailEdit extends StatefulWidget {
  static const ROUTE_NAME = '/taskDetail/new_edit';

  @override
  _TaskDetailEditState createState() => _TaskDetailEditState();
}

class _TaskDetailEditState extends State<TaskDetailEdit> {
  TaskProvider _taskProvider;
  Task _currentTask;
  DateTime _taskStartDate = DateTime.now();
  DateTime _taskEndDate = DateTime.now().add(Duration(days: 1));
  TimeOfDay _taskStartTime = TimeOfDay.now();
  TimeOfDay _taskEndTime = TimeOfDay.now().replacing(
    hour: TimeOfDay.now().hour + 1,
  );

  var _nameController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  bool _isNameValid = true;

  var _descriptionController = TextEditingController();
  final FocusNode _descriptionFocus = FocusNode();
  bool _isDescriptionValid = true;

  bool isCreatingNewTask = true;

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

  Widget _inputTextField({
    @required TextEditingController controller,
    @required FocusNode focusNode,
    @required Function validation,
    @required bool validCheck,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: INPUT_BG_COLOR,
        border: Border.all(
            color: validCheck ? Colors.transparent : Colors.red, width: 1),
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        onFieldSubmitted: (value) => validation(
            value: value, validCheck: validCheck, focusNode: focusNode),
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

  bool _inputValidation({
    @required String value,
    @required bool validCheck,
    FocusNode focusNode,
  }) {
    setState(() {
      if (value.length == 0 || value.replaceAll(' ', '').length == 0) {
        validCheck = false;
        print("Not Valid" +
            _isNameValid.toString() +
            " " +
            _isDescriptionValid.toString());
      } else {
        validCheck = true;
        if (focusNode != null) FocusScope.of(context).requestFocus(focusNode);
      }
    });
    return validCheck;
  }

  Widget _textArea({
    @required TextEditingController controller,
    @required FocusNode focusNode,
    @required bool validCheck,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: INPUT_BG_COLOR,
        border: Border.all(
            color: validCheck ? Colors.transparent : Colors.red, width: 1),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
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

  Widget _divider() {
    return Divider(
      color: const Color.fromRGBO(0, 0, 0, 0.1),
      thickness: 0.5,
      height: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = new DateFormat('dd MMMM yyyy');
    final timeFormat = new DateFormat('HH:mm');

    int id = ModalRoute.of(context).settings.arguments as int;
    if (id != -1) {
      isCreatingNewTask = true;
      this._currentTask = _taskProvider.getTaskByID(id);
      _taskStartDate = this._currentTask.startDate;
      _taskEndDate = this._currentTask.endDate;
      _taskStartTime = this._currentTask.startTime;
      _taskEndTime = this._currentTask.endTime;
    }
    this._taskProvider = Provider.of<TaskProvider>(context, listen: true);

    bool isKeyBoardOn = MediaQuery.of(context).viewInsets.bottom != 0;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Container(
                      height: !isKeyBoardOn
                          ? constraints.maxHeight * 0.9
                          : constraints.maxHeight,
                      width: constraints.maxWidth,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
//                            this._customAppBar(),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              child: Text(
                                "Add Task",
                                style: TextStyle(
                                  fontSize: 35,
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
                                  _inputTextField(
                                      controller: _nameController,
                                      focusNode: _nameFocus,
                                      validation: _inputValidation,
                                      validCheck: _isNameValid),
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
                                  _textArea(
                                    validCheck: _isDescriptionValid,
                                    focusNode: _descriptionFocus,
                                    controller: _descriptionController,
                                  ),
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
                                          _taskStartDate != null
                                              ? dateFormat
                                                  .format(_taskStartDate)
                                              : dateFormat
                                                  .format(DateTime.now()),
                                          () {
                                            showDatePicker(
                                                    context: context,
                                                    initialDate:
                                                        _taskStartDate != null
                                                            ? _taskStartDate
                                                            : DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime(3000))
                                                .then((date) {
                                              setState(() {
                                                if (date != null)
                                                  this._taskStartDate = date;
                                              });
                                            });
                                          },
                                        ),
                                        _divider(),
                                        _detailListTile(
                                          'Start Time',
                                          _taskStartTime == null
                                              ? "Not Setted"
                                              : _taskStartTime.format(context),
                                          () {
                                            showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        _taskStartTime == null
                                                            ? TimeOfDay.now()
                                                            : _taskStartTime)
                                                .then((time) {
                                              setState(() {
                                                if (time != null)
                                                  this._taskStartTime = time;
                                              });
                                            });
                                          },
                                        ),
                                        _divider(),
                                        _detailListTile(
                                          'End Date',
                                          _taskEndDate != null
                                              ? dateFormat.format(_taskEndDate)
                                              : dateFormat.format(DateTime.now()
                                                  .add(Duration(days: 1))),
                                          () {
                                            showDatePicker(
                                                    context: context,
                                                    initialDate:
                                                        _taskEndDate != null
                                                            ? _taskEndDate
                                                            : DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime(3000))
                                                .then((date) {
                                              setState(() {
                                                if (date != null)
                                                  this._taskEndDate = date;
                                              });
                                            });
                                          },
                                        ),
                                        _divider(),
                                        _detailListTile(
                                          'End Time',
                                          _taskEndTime == null
                                              ? "Not Setted"
                                              : _taskEndTime.format(context),
                                          () {
                                            showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        _taskEndTime == null
                                                            ? TimeOfDay.now()
                                                            : _taskEndTime)
                                                .then((time) {
                                              setState(() {
                                                if (time != null) {
                                                  if (_taskStartDate.compareTo(
                                                              _taskEndDate) ==
                                                          0 &&
                                                      (time.hour * 60 +
                                                              time.minute) <
                                                          (_taskStartTime.hour *
                                                                  60 +
                                                              _taskStartDate
                                                                  .minute)) {
                                                    _taskEndTime =
                                                        TimeOfDay.now()
                                                            .replacing(
                                                      hour:
                                                          TimeOfDay.now().hour +
                                                              1,
                                                    );
                                                  } else
                                                    this._taskEndTime = time;
                                                }
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
                  isKeyBoardOn
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
                                !isCreatingNewTask
                                    ? Expanded(
                                        child: InkWell(
                                          onTap: () {},
                                          child: Container(
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(
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
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                              color: Colors.transparent,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              vertical: 15,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                !isCreatingNewTask
                                    ? SizedBox(
                                        width: 5,
                                      )
                                    : Container(),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      print("On tap Save");
                                      if (isCreatingNewTask) {
                                        _isNameValid = _inputValidation(
                                            value: _nameController.text,
                                            validCheck: _isNameValid);
                                        _isDescriptionValid = _inputValidation(
                                            value: _descriptionController.text,
                                            validCheck: _isDescriptionValid);
                                        if (_isNameValid &&
                                            _isDescriptionValid) {
                                          if (_taskProvider.addNewTask(
                                              title: _nameController.text,
                                              description:
                                                  _descriptionController.text,
                                              startDate:
                                                  _taskStartDate.toString(),
                                              endDate: _taskEndDate.toString(),
                                              startTime: _taskStartTime
                                                  .format(context),
                                              endTime:
                                                  _taskEndTime.format(context),
                                              status: "NEW")) {
                                            Navigator.of(context).pop();
                                          }
                                          //Save Data
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      child: Text(
                                        isCreatingNewTask ? "Save" : "Update",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.blue,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(0),
                                        color: Colors.blue,
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
