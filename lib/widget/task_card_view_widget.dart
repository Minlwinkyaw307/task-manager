import 'package:flutter/material.dart';
import 'package:task_manager/util/global_data.dart';

class TaskCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 1,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        ),
        margin: EdgeInsets.only(
          bottom: 15,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.circular(
                10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey
                    .withOpacity(
                    0.35),
                spreadRadius: -7.5,
                blurRadius: 20,
                offset: Offset(0, 5),
              ),
            ]),
        child: Column(
          children: <Widget>[
            Container(
              decoration:
              const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(
                        0x23000000),
                    width: 0.5,
                  ),
                ),
              ),
              padding: EdgeInsets
                  .symmetric(
                vertical: 5,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 3,
                      child: Align(
                        alignment:
                        Alignment
                            .topCenter,
                        child:
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              color:
                              DONE_COLOR,
                              borderRadius:
                              BorderRadius.circular(100)),
                        ),
                      )),
                  Expanded(
                    flex: 17,
                    child: Wrap(
                      direction: Axis
                          .vertical,
                      children: <
                          Widget>[
                        Text(
                          'Title of the Task',
                          style: TextStyle(
                              fontSize:
                              18,
                              fontWeight:
                              FontWeight.w600),
                        ),
                        Text(
                          '09.07.2020',
                          style: TextStyle(
                              fontSize:
                              15,
                              fontWeight:
                              FontWeight.w300),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Padding(
                padding:
                const EdgeInsets
                    .symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                child: Text(
                  "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight:
                      FontWeight.normal),
                ),
              ),
              decoration:
              const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(
                        0x23000000),
                    width: 0.5,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets
                  .only(
                left: 15,
                right: 15,
                top: 10,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 14,
                    child: Container(
                      child: Text(
                          "09:30 AM - 10:45 AM"),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Icon(
                        Icons
                            .mode_edit,
                        size: 25,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Icon(
                        Icons
                            .delete,
                        size: 25,
                        color: CANCELED_COLOR,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
