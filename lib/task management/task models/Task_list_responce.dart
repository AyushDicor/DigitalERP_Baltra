// import 'dart:convert';
//
// TaskListResponse taskListResponseFromJson(String str) =>
//     TaskListResponse.fromJson(json.decode(str));
// String taskListResponseToJson(TaskListResponse data) =>
//     json.encode(data.toJson());
//
// class TaskListResponse {
//   TaskListResponse({
//     this.success,
//     this.data,
//     this.message,
//     this.status,
//   });
//
//   TaskListResponse.fromJson(dynamic json) {
//     success = json['success'];
//     if (json['data'] != null) {
//       data = [];
//       json['data'].forEach((v) {
//         data?.add(TaskListData.fromJson(v));
//       });
//     }
//     message = json['message'];
//     status = json['status'];
//   }
//   bool? success;
//   List<TaskListData>? data;
//   String? message;
//   int? status;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['success'] = success;
//     if (data != null) {
//       map['data'] = data?.map((v) => v.toJson()).toList();
//     }
//     map['message'] = message;
//     map['status'] = status;
//     return map;
//   }
// }
//
// class TaskListData {
//   TaskListData(
//       {this.taskid,
//       this.taskname,
//       this.assignto,
//       this.assigndate,
//       this.duedate,
//       this.status,
//       this.assignby,
//       this.clientreference,
//       this.lastcomment,
//       this.unit,
//       this.assignqty,
//       this.sitename,
//       this.location,
//       this.priority,
//       this.tasksection,
//       this.flag});
//
//   TaskListData.fromJson(dynamic json) {
//     taskid = json['taskid'];
//     taskname = json['task'];
//     assignto = json['assignedto'];
//     assigndate = json['assigndate'];
//     duedate = json['duedate'];
//     status = json['status'];
//     assignby = json['assignby'];
//     clientreference = json['clientname'];
//     lastcomment = json['lastcomment'];
//     assignqty = json['assignqty'];
//     unit = json['unit'];
//     sitename = json['sitename'];
//     location = json['location'];
//     priority = json['priority'];
//     tasksection = json['tasksection'];
//     flag = json['flag'];
//   }
//   int? taskid;
//   String? taskname;
//   String? assignto;
//   String? assigndate;
//   String? duedate;
//   String? status;
//   String? assignby;
//   String? clientreference;
//   String? lastcomment;
//
//   String? unit;
//   String? location;
//   String? sitename;
//   String? assignqty;
//   String? priority;
//   String? tasksection;
//   String? flag;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['taskid'] = taskid;
//     map['taskname'] = taskname;
//     map['assigto'] = assignto;
//     map['assigndate'] = assigndate;
//     map['duedate'] = duedate;
//     map['status'] = status;
//     map['assignby'] = assignby;
//     map['clientreference'] = clientreference;
//     map['lastcomment'] = lastcomment;
//     map['unit'] = unit ;
//     map['location'] = location;
//     map['sitename'] = sitename;
//     map['assignqty'] =assignqty ;
//     map['priority'] =priority ;
//     map['tasksection'] =tasksection ;
//     map['flag'] =flag ;
//
//     return map;
//   }
// }

import 'dart:convert';

TaskListResponse taskListResponseFromJson(String str) =>
    TaskListResponse.fromJson(json.decode(str));
String taskListResponseToJson(TaskListResponse data) =>
    json.encode(data.toJson());

class TaskListResponse {
  TaskListResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  TaskListResponse.fromJson(dynamic json) {
    success = json['success'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(TaskListData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  bool? success;
  List<TaskListData>? data;
  String? message;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    map['status'] = status;
    return map;
  }
}

class TaskListData {
  TaskListData({
    this.taskid,
    this.assignedto,
    this.status,
    this.priority,
    this.clientname,
    this.sitename,
    this.task,
    this.assigndate,
    this.duedate,
    this.lastcomment,
    this.tasksection,
    this.flag,
  });

  TaskListData.fromJson(dynamic json) {
    taskid = json['taskid'];
    assignedto = json['assignedto'];
    status = json['status'];
    priority = json['priority'];
    clientname = json['clientname'];
    sitename = json['sitename'];
    task = json['task'];
    assigndate = json['assigndate'];
    duedate = json['duedate'];
    lastcomment = json['lastcomment'];
    tasksection = json['tasksection'];
    flag = json['flag'];
  }

  int? taskid;
  String? assignedto;
  String? status;
  String? priority;
  String? clientname;
  String? sitename;
  String? task;
  String? assigndate;
  String? duedate;
  String? lastcomment;
  String? tasksection;
  String? flag; // ← NEW: "Direct Task" or "Project"

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['taskid'] = taskid;
    map['assignedto'] = assignedto;
    map['status'] = status;
    map['priority'] = priority;
    map['clientname'] = clientname;
    map['sitename'] = sitename;
    map['task'] = task;
    map['assigndate'] = assigndate;
    map['duedate'] = duedate;
    map['lastcomment'] = lastcomment;
    map['tasksection'] = tasksection;
    map['flag'] = flag;
    return map;
  }
}
