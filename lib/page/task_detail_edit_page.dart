import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/provider/task_provider.dart';
import 'package:task_manager/util/global_data.dart';
import 'package:task_manager/util/global_method.dart';

class TaskDetailEdit extends StatefulWidget {
  static const ROUTE_NAME = '/taskDetail/new_edit';

  @override
  _TaskDetailEditState createState() => _TaskDetailEditState();
}

class _TaskDetailEditState extends State<TaskDetailEdit> {
  // task provider
  TaskProvider _taskProvider;
  // current task that is currently creating or updating
  Task _currentTask;
  // task's start date
  DateTime _taskStartDate = DateTime.now();
  // task's end date
  DateTime _taskEndDate = DateTime.now().add(Duration(days: 1));
  // task's start time
  TimeOfDay _taskStartTime = TimeOfDay.now();
  // task's end time
  TimeOfDay _taskEndTime;

  // title's controller, focus node and validation status
  var _titleController = TextEditingController();
  final FocusNode _titleFocus = FocusNode();
  bool _isTitleValid = true;

  // description's controller, focus node and validation status
  var _descriptionController = TextEditingController();
  final FocusNode _descriptionFocus = FocusNode();
  bool _isDescriptionValid = true;

  // whether focus on input or not when page was refresh
  bool _shouldFocus = false;
  // status of creating new task or editing in current page
  bool isCreatingNewTask = true;

  Widget _inputTextField({
    @required TextEditingController controller,
    @required FocusNode focusNode,
    @required Function validation,
    @required bool validCheck,
  }) {
    // should not make it to widget class
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
        autofocus: false,
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

  void unFocusInput() {
    // unfocusing the inputs when user update date and time
    if (!_shouldFocus) return;
    _titleFocus.unfocus();
    _descriptionFocus.unfocus();
    // ignore: unnecessary_statements
    _shouldFocus = false;
  }

  bool _inputValidation({
    @required String value,
    @required bool validCheck,
    FocusNode focusNode,
  }) {
    // should not make it to widget class
    // form validation for title and description
    setState(() {
      if (value.length == 0 || value.replaceAll(' ', '').length == 0) {
        validCheck = false;
        print("Not Valid" +
            _isTitleValid.toString() +
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
        autofocus: false,
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        maxLines: 5,
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

  // bottom button is a widget base on current page condition it will render
  // save button or (update and delete) buttons with different functionalities
  Widget _bottomButtons(BuildContext context, double height, double width) {
    return Container(
      height: height,
      width: width,
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
                    onTap: () {
                      confirmAlertDialog(
                          context,
                          'Confirm?',
                          "Are you sure, you want to delete this task?",
                          () {
                            Navigator.of(context).pop();
                          }, () {
                        _taskProvider.deleteByID(_currentTask).then((result) {
                          if (result) {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          }
                        }).catchError((err) {
                          print(
                              "Getting Error while deleting a row(${_currentTask.id}) : ${err.toString()}");
                        });
                      });
                    },
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
                        borderRadius: BorderRadius.circular(0),
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
                _isTitleValid = _inputValidation(
                    value: _titleController.text, validCheck: _isTitleValid);
                _isDescriptionValid = _inputValidation(
                    value: _descriptionController.text,
                    validCheck: _isDescriptionValid);
                if (isCreatingNewTask) {
                  if (_isTitleValid && _isDescriptionValid) {
                    _taskProvider
                        .addNewTask(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      startDate: _taskStartDate.toString(),
                      endDate: _taskEndDate.toString(),
                      startTime: _taskStartTime.format(context),
                      endTime: _taskEndTime.format(context),
                      status: "NEW",
                      pinned: false,
                    )
                        .then((result) {
                      if (result) {
                        Navigator.of(context).pop();
                      }
                    }).catchError((err) {
                      print(
                          "Getting Error While Adding New Task : ${err.toString()}");
                    });
                  }
                } else {
                  if (_isTitleValid && _isDescriptionValid) {
                    _currentTask.title = _titleController.text;
                    _currentTask.description = _descriptionController.text;
                    _currentTask.startDate = _taskStartDate != null
                        ? _taskStartDate
                        : _currentTask.startDate;
                    _currentTask.endDate = _taskEndDate != null
                        ? _taskEndDate
                        : _currentTask.endDate;

                    _currentTask.setStartTime(_taskStartTime.format(context));
                    _currentTask.setEndTime(_taskEndTime.format(context));

                    _taskProvider.updateTask(_currentTask).then((result) {
                      if (result) {
                        Navigator.of(context).pop();
                      }
                    }).catchError((err) {
                      print(
                          "Getting Error While Updating Task(${_currentTask.id}) : ${err.toString()}");
                    });
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
    );
  }

  @override
  Widget build(BuildContext context) {
    // task provider (no need to render again)
    this._taskProvider = Provider.of<TaskProvider>(context, listen: false);

    // retrieving id value that was passed from home page to get task
    int id = ModalRoute.of(context).settings.arguments as int;
    // base on id getting task or creating empty task
    if (id != -1 && _taskProvider.getTaskByID(id) != null) {
      if (_currentTask == null) {
        isCreatingNewTask = false;
        this._currentTask = _taskProvider.getTaskByID(id);
        _taskStartDate = this._currentTask.startDate;
        _taskEndDate = this._currentTask.endDate;
        _taskStartTime = this._currentTask.startTime;
        _taskEndTime = this._currentTask.endTime;
        _titleController.text = this._currentTask.title;
        _descriptionController.text = this._currentTask.description;
      }
    } else
      isCreatingNewTask = true;
    if (_taskEndTime == null) {
      _taskEndTime = TimeOfDay.now();
      if (_taskEndTime.hour + 1 >= 24)
        _taskEndTime.replacing(
          hour: 0,
        );
      else
        _taskEndTime.replacing(
          hour: _taskEndTime.hour + 1,
        );
    }

    final dateFormat = new DateFormat('dd MMMM yyyy');
    // unfocusing input
    unFocusInput();

    // should show save button or not (when user open keyboard to type title and description)
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
                          ? constraints.maxHeight - 75
                          : constraints.maxHeight,
                      width: constraints.maxWidth,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: 15,
                          ),
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
                                  isCreatingNewTask ? "Add Task" : "Edit Task",
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
                                        "Title",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    _inputTextField(
                                        controller: _titleController,
                                        focusNode: _titleFocus,
                                        validation: _inputValidation,
                                        validCheck: _isTitleValid),
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
                                                  _shouldFocus = true;
                                                  if (date != null) {
                                                    this._taskStartDate = date;
                                                    if (_taskStartDate.isAfter(
                                                        _taskEndDate)) {
                                                      _taskEndDate =
                                                          _taskStartDate;
                                                    }
                                                  }
                                                });
                                              });
                                            },
                                          ),
                                          _divider(),
                                          _detailListTile(
                                            'Start Time',
                                            _taskStartTime == null
                                                ? "Not Set"
                                                : _taskStartTime
                                                    .format(context),
                                            () {
                                              showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          _taskStartTime == null
                                                              ? TimeOfDay.now()
                                                              : _taskStartTime)
                                                  .then((time) {
                                                _shouldFocus = true;
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
                                                ? dateFormat
                                                    .format(_taskEndDate)
                                                : dateFormat.format(
                                                    DateTime.now().add(
                                                        Duration(days: 1))),
                                            () {
                                              showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          _taskEndDate != null
                                                              ? _taskEndDate
                                                              : DateTime.now(),
                                                      firstDate: _taskEndDate,
                                                      lastDate: DateTime(3000))
                                                  .then((date) {
                                                _shouldFocus = true;
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
                                                ? "Not Set"
                                                : _taskEndTime.format(context),
                                            () {
                                              showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          _taskEndTime == null
                                                              ? TimeOfDay.now()
                                                              : _taskEndTime)
                                                  .then((time) {
                                                _shouldFocus = true;
                                                setState(() {
                                                  if (time != null) {
                                                    if ((time.hour * 60 +
                                                            time.minute) <
                                                        (_taskStartTime.hour *
                                                                60 +
                                                            _taskStartTime
                                                                .minute)) {
                                                      _taskEndTime =
                                                          _taskStartTime
                                                              .replacing(
                                                        hour: _taskStartTime
                                                                .hour +
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
                  ),
                  isKeyBoardOn
                      ? Container()
                      : Positioned(
                          bottom: 0,
                          left: 0,
                          child:
                              _bottomButtons(context, 75, constraints.maxWidth),
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
