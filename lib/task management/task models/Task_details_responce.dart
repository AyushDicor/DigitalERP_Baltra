

import 'dart:convert';

TaskDetailsResponse taskDetailsResponseFromJson(String str) =>
    TaskDetailsResponse.fromJson(json.decode(str));
String taskDetailsResponseToJson(TaskDetailsResponse data) =>
    json.encode(data.toJson());

class TaskDetailsResponse {
  TaskDetailsResponse({
    this.success,
    this.data,
    this.message,
    this.status,
  });

  TaskDetailsResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? TaskDetailData.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  bool? success;
  TaskDetailData? data;
  String? message;
  int? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['message'] = message;
    map['status'] = status;
    return map;
  }
}

//  Main data wrapper 
class TaskDetailData {
  TaskDetailData({
    this.taskdetail,
    this.history,
  });

  TaskDetailData.fromJson(dynamic json) {
    taskdetail = json['taskdetail'] != null
        ? TaskDetail.fromJson(json['taskdetail'])
        : null;
    if (json['history'] != null) {
      history = [];
      json['history'].forEach((v) {
        history?.add(TaskHistory.fromJson(v));
      });
    }
  }

  TaskDetail? taskdetail;
  List<TaskHistory>? history;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (taskdetail != null) {
      map['taskdetail'] = taskdetail?.toJson();
    }
    if (history != null) {
      map['history'] = history?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

//  Task Detail (header info) 
class TaskDetail {
  TaskDetail({
    this.taskid,
    this.tasksection,
    this.task,
    this.status,
    this.priority,
    this.assigndate,
    this.duedate,
    this.lastupdatedate,
    this.lastcomment,
    this.document,
    this.assignedto,
    this.assignedtoid,
    this.assignedby,
    this.clientname,
    this.sitename,
    this.siteid,
    // Direct Task only
    this.tasktype,
    this.clientreference,
    // Project Task only
    this.orderno,
    this.orderid,
    this.linenumber,
    this.lineitem,
    this.lineid,
    this.jobtype,
    this.jobtypeid,
    this.projecttype,
    this.totalquantity,
    this.completedquantity,
    this.unitname,
    this.unitid,
    this.startdate,
    this.description,
    this.fromlocation,
    this.tolocation,
    this.noofrun,
    this.totallength,
    this.escalateto,
    this.escalatetoid,
    this.createdby,
  });

  TaskDetail.fromJson(dynamic json) {
    taskid = json['taskid'];
    tasksection = json['tasksection'];
    task = json['task'];
    status = json['status'];
    priority = json['priority'];
    assigndate = json['assigndate'];
    duedate = json['duedate'];
    lastupdatedate = json['lastupdatedate'];
    lastcomment = json['lastcomment'];
    document = json['document'];
    assignedto = json['assignedto'];
    assignedtoid = json['assignedtoid'];
    assignedby = json['assignedby'];
    clientname = json['clientname'];
    sitename = json['sitename'];
    siteid = json['siteid'];
    tasktype = json['tasktype'];
    clientreference = json['clientreference'];
    orderno = json['orderno'];
    orderid = json['orderid'];
    linenumber = json['linenumber'];
    lineitem = json['lineitem'];
    lineid = json['lineid'];
    jobtype = json['jobtype'];
    jobtypeid = json['jobtypeid'];
    projecttype = json['projecttype'];
    totalquantity = json['totalquantity'];
    completedquantity = json['completedquantity'];
    unitname = json['unitname'];
    unitid = json['unitid'];
    startdate = json['startdate'];
    description = json['description'];
    fromlocation = json['fromlocation'];
    tolocation = json['tolocation'];
    noofrun = json['noofrun'];
    totallength = json['totallength'];
    escalateto = json['escalateto'];
    escalatetoid = json['escalatetoid'];
    createdby = json['createdby'];
  }

  int? taskid;
  String? tasksection; // ← "Direct Task" or "Project"
  String? task;
  String? status;
  String? priority;
  String? assigndate;
  String? duedate;
  String? lastupdatedate;
  String? lastcomment;
  String? document;
  String? assignedto;
  int? assignedtoid;
  String? assignedby;
  String? clientname;
  String? sitename;
  int? siteid;

  // Direct Task only
  String? tasktype;
  String? clientreference;

  // Project Task only
  String? orderno;
  int? orderid;
  int? linenumber;
  String? lineitem;
  int? lineid;
  String? jobtype;
  int? jobtypeid;
  String? projecttype;
  double? totalquantity;
  double? completedquantity;
  String? unitname;
  int? unitid;
  String? startdate;
  String? description;
  String? fromlocation;
  String? tolocation;
  int? noofrun;
  double? totallength;
  String? escalateto;
  int? escalatetoid;
  String? createdby;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['taskid'] = taskid;
    map['tasksection'] = tasksection;
    map['task'] = task;
    map['status'] = status;
    map['priority'] = priority;
    map['assigndate'] = assigndate;
    map['duedate'] = duedate;
    map['lastupdatedate'] = lastupdatedate;
    map['lastcomment'] = lastcomment;
    map['document'] = document;
    map['assignedto'] = assignedto;
    map['assignedtoid'] = assignedtoid;
    map['assignedby'] = assignedby;
    map['clientname'] = clientname;
    map['sitename'] = sitename;
    map['siteid'] = siteid;
    map['tasktype'] = tasktype;
    map['clientreference'] = clientreference;
    map['orderno'] = orderno;
    map['orderid'] = orderid;
    map['linenumber'] = linenumber;
    map['lineitem'] = lineitem;
    map['lineid'] = lineid;
    map['jobtype'] = jobtype;
    map['jobtypeid'] = jobtypeid;
    map['projecttype'] = projecttype;
    map['totalquantity'] = totalquantity;
    map['completedquantity'] = completedquantity;
    map['unitname'] = unitname;
    map['unitid'] = unitid;
    map['startdate'] = startdate;
    map['description'] = description;
    map['fromlocation'] = fromlocation;
    map['tolocation'] = tolocation;
    map['noofrun'] = noofrun;
    map['totallength'] = totallength;
    map['escalateto'] = escalateto;
    map['escalatetoid'] = escalatetoid;
    map['createdby'] = createdby;
    return map;
  }
}

//  Task History (followup entries) 
class TaskHistory {
  TaskHistory({
    this.transid,
    this.sno,
    this.entrydate,
    this.status,
    this.comment,
    this.attachfile,
    this.hasfile,
    this.quantity,
    this.unitname,
    this.escalatedto,
    this.enteredby,
  });

  TaskHistory.fromJson(dynamic json) {
    transid = json['transid'];
    sno = json['sno'];
    entrydate = json['entrydate'];
    status = json['status'];
    comment = json['comment'];
    attachfile = json['attachfile'];
    hasfile = json['hasfile'];
    quantity = json['quantity'];
    unitname = json['unitname'];
    escalatedto = json['escalatedto'];
    enteredby = json['enteredby'];
  }

  int?    transid;
  int?    sno;
  String? entrydate;
  String? status;
  String? comment;
  String? attachfile;
  int?    hasfile;
  double? quantity;
  String? unitname;
  String? escalatedto;
  String? enteredby;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['transid'] = transid;
    map['sno'] = sno;
    map['entrydate'] = entrydate;
    map['status'] = status;
    map['comment'] = comment;
    map['attachfile'] = attachfile;
    map['hasfile'] = hasfile;
    map['quantity'] = quantity;
    map['unitname'] = unitname;
    map['escalatedto'] = escalatedto;
    map['enteredby'] = enteredby;
    return map;
  }
}
