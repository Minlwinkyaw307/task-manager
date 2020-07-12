# Task Manager

Task Manager is an android application to manage user's task base on date like daily, weekly and monthly. 

[Download Apk](https://drive.google.com/file/d/10qbQgHKY9rIGuleDxOqWK99itQnfjdiM/view?usp=sharing)

#### Dependencies

 - [fl_chart](https://pub.dev/packages/fl_chart) (For Pie Chart)
 - [intl](https://pub.dev/packages/intl)
 - [sqflite](https://pub.dev/packages/sqflite)
 - [provider](https://pub.dev/packages/provider)
 - [vibration](https://pub.dev/packages/vibration)
 - [flutter_staggered_grid_view](https://pub.dev/packages/flutter_staggered_grid_view)


There are only 2 pages in the application. Home page is where all the tasks of the user will be listed. The second page is to add or update task.

## Home Page

For mobile, on top of the page there is a pie chart to display how many tasks were finished, canceled and newly created. Pie chart data will be changing every time user select different list (today, week, or month). Base on display type and tablet pie chart might not display on top of the page. 


![Home Page Mobile View](https://res.cloudinary.com/minlwinkyaw/image/upload/c_scale,w_500/v1594537485/minlwinkyaw/task_manager/mobile_1_muofwj.jpg)
![Home Page Tablet View](https://res.cloudinary.com/minlwinkyaw/image/upload/c_scale,w_500/v1594537408/minlwinkyaw/task_manager/tablet_1_pmgjft.png)


After that there is a tab bar to switch page (page view's page) to check out today, weekly, monthly or all of the tasks. 
If user is using from tablet, the way of showing these task card will be different from mobile view.

If user long press on task card, it will pop up options for selected task. There are 4 option for a task. 

 1. User can pin the card to the top of the list (no matter which list the card in it, it will be listed on top) and unpin if it was pinned
 2. Editing the task (it can also be done by click on the task)
 3. Cancelling the task or restoring the task
 4. Deleting the task from the list (won't be recovered)
 
![Options in Mobile View](https://res.cloudinary.com/minlwinkyaw/image/upload/c_scale,w_500/v1594538191/minlwinkyaw/task_manager/mobile_2_x1efyj.jpg)
![Options in Tablet View](https://res.cloudinary.com/minlwinkyaw/image/upload/c_scale,w_500/v1594538190/minlwinkyaw/task_manager/tablet_3_ak0qkh.png)


## Add or Update Task Page

This page will be redirected when user select task that was already created as update page and it will allow user to update information of the task.
If user tap on add floating button from home page, it will work as adding new task.

![Adding task in mobile view](https://res.cloudinary.com/minlwinkyaw/image/upload/c_scale,w_500/v1594538699/minlwinkyaw/task_manager/mobile_3_jxgfya.jpg)
![Updating task in tablet view](https://res.cloudinary.com/minlwinkyaw/image/upload/c_scale,w_500/v1594537408/minlwinkyaw/task_manager/tablet_2_w2iqms.png)
