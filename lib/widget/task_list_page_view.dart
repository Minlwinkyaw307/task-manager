import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/page/task_detail_edit_page.dart';
import 'package:task_manager/provider/task_provider.dart';
import 'package:task_manager/util/global_method.dart';
import 'package:task_manager/widget/task_card_view_widget.dart';

import 'bottom_sheet_option_tile.dart';

// ignore: must_be_immutable
class TaskListPageView extends StatelessWidget {
  final BoxConstraints constraints;
  final List<Task> sortedTasks;
  final bool isMobile;
  final TaskProvider taskProvider; 

  const TaskListPageView({this.constraints, this.sortedTasks, this.isMobile, this.taskProvider});

  void _longPressTaskCard(BuildContext context, Task task) {
    vibrate(150, 50);
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                BottomSheetOptionTile(
                    title: task.pinned ? "Unpin from top" : "Pin to top",
                    textColor: Colors.black,
                    icon: task.pinned
                        ? Icons.vertical_align_bottom
                        : Icons.vertical_align_top,
                    iconColor: Colors.black,
                    onPress: () {
                      task.pinned = task.pinned ? false : true;
                      taskProvider.updateTask(task);
                      Navigator.of(context).pop();
                    }),
                BottomSheetOptionTile(
                    title: "Edit",
                    textColor: Colors.blue,
                    icon: Icons.edit,
                    iconColor: Colors.blue,
                    onPress: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(TaskDetailEdit.ROUTE_NAME,
                          arguments: task.id);
                    }),
                BottomSheetOptionTile(
                    title: task.status == "CANCELED" ? "Restore" : "Cancel",
                    textColor: Colors.amber,
                    icon: task.status == "CANCELED"
                        ? Icons.restore
                        : Icons.cancel,
                    iconColor: Colors.amber,
                    onPress: () {
                      task.status =
                      task.status == "CANCELED" ? "NEW" : "CANCELED";
                      taskProvider.updateTask(task);
                      Navigator.of(context).pop();
                      //Navigator.of(context).pushNamed(TaskDetailEdit.ROUTE_NAME, arguments: task.id);
                    }),
                BottomSheetOptionTile(
                    title: "Delete",
                    textColor: Colors.red,
                    icon: Icons.delete,
                    iconColor: Colors.red,
                    onPress: () {
                      confirmAlertDialog(context, 'Confirm?',
                          "Are you sure, you want to delete this task?", () {
                            Navigator.of(context).pop();
                          }, () {
                            taskProvider.deleteByID(task).then((result) {
                              if (result) {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              }
                            }).catchError((err) {
                              print(
                                  "Getting Error while deleting a row(${task.id}) : ${err.toString()}");
                            });
                          });
                    }),
              ],
            ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    // In case there is no task was in the list, then show empty list message
    if(sortedTasks.length == 0){
      return Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: Center(
          child: Text("Wow, Such an empty!\nMaybe create new task..",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),),
        ),
      );
    }
    // if not then show list of task
    return Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      margin: const EdgeInsets.only(
        top: 15,
      ),
      child: SingleChildScrollView(
        child: Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight * 0.95,
          margin: EdgeInsets.only(
            top: 10,
            bottom: 20,
          ),
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: sortedTasks.length + 1,
            staggeredTileBuilder: (int index) =>
                new StaggeredTile.fit(isMobile ? 4 : 2),
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            itemBuilder: (context, index) {
              if (sortedTasks.length == index)
                return SizedBox(
                  height: 60,
                );
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 5,
                ),
                child: GestureDetector(
                  onLongPress: () =>
                      this._longPressTaskCard(context, sortedTasks[index]),
                  child: TaskCardView(
                    currentTask: sortedTasks[index],
                    provider: taskProvider,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
