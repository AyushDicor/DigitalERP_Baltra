// Future<void> generateExcel(
//     Map<String, dynamic> mapData, DateTime fromDate, DateTime toDate)
// async {
//   try {
//     final XLS.Workbook workbook = XLS.Workbook();
//     final XLS.Worksheet sheet = workbook.worksheets[0];
//     sheet.enableSheetCalculations();
//     sheet
//         .getRangeByIndex(
//       1,
//       1,
//     )
//         .setText('Active Date');
//     sheet
//         .getRangeByIndex(
//       1,
//       1,
//     )
//         .columnWidth = 20;
//     sheet
//         .getRangeByIndex(
//       1,
//       2,
//     )
//         .setText('Registration Date');
//     sheet
//         .getRangeByIndex(
//       1,
//       2,
//     )
//         .columnWidth = 20;
//     sheet
//         .getRangeByIndex(
//       1,
//       3,
//     )
//         .setText('User Id');
//     sheet
//         .getRangeByIndex(
//       1,
//       3,
//     )
//         .columnWidth = 35;
//
//     sheet
//         .getRangeByIndex(
//       1,
//       4,
//     )
//         .setText('Name');
//     sheet
//         .getRangeByIndex(
//       1,
//       4,
//     )
//         .columnWidth = 20;
//     sheet
//         .getRangeByIndex(
//       1,
//       5,
//     )
//         .setText('Email');
//     sheet
//         .getRangeByIndex(
//       1,
//       5,
//     )
//         .columnWidth = 30;
//     sheet
//         .getRangeByIndex(
//       1,
//       6,
//     )
//         .setText('Phone Number');
//     sheet
//         .getRangeByIndex(
//       1,
//       6,
//     )
//         .columnWidth = 20;
//
//     sheet
//         .getRangeByIndex(
//       1,
//       7,
//     )
//         .setText('DOB');
//     sheet
//         .getRangeByIndex(
//       1,
//       8,
//     )
//         .setText('Gender');
//
//     sheet
//         .getRangeByIndex(
//       1,
//       9,
//     )
//         .setText('Interested In');
//     sheet
//         .getRangeByIndex(
//       1,
//       10,
//     )
//         .setText('Device Id');
//     sheet
//         .getRangeByIndex(
//       1,
//       10,
//     )
//         .columnWidth = 30;
//     sheet
//         .getRangeByIndex(
//       1,
//       11,
//     )
//         .setText('Active Times');
//     sheet
//         .getRangeByIndex(
//       1,
//       11,
//     )
//         .columnWidth = 30;
//
//     int columnIndex=1;
//     for (int index = 2; index < mapData.keys.toList().length + 2; index++){
//       final key = mapData.keys.toList()[index - 2];
//       columnIndex+=1;
//
//       sheet
//           .getRangeByIndex(columnIndex, 1)
//           .setText(DateFormatUtils.ddMMMYYYYKKMM(int.parse(key)));
//       for (int innerIndex = 1; innerIndex < (mapData[key] as List).length + 1; innerIndex++){
//         columnIndex+=1;
//         final user = (mapData[key] as List)[innerIndex-1]['user'];
//         final activeTime = (mapData[key] as List)[innerIndex-1]['activeTime'] as List;
//         sheet
//             .getRangeByIndex(columnIndex, 2)
//             .setText(DateFormatUtils.ddMMMYYYYKKMM(user.time));
//         sheet.getRangeByIndex(columnIndex, 3).setText(user.id);
//         sheet.getRangeByIndex(columnIndex, 4).setText(user.name);
//         sheet.getRangeByIndex(columnIndex, 5).setText(user.email);
//         sheet
//             .getRangeByIndex(
//           columnIndex,
//           6,
//         )
//             .setText(user.countryCode + user.number);
//
//         sheet.getRangeByIndex(columnIndex, 7).setText(user.dob);
//         sheet.getRangeByIndex(columnIndex, 8).setText(user.gender);
//         sheet.getRangeByIndex(columnIndex, 9).setText(user.interestedIn);
//         sheet.getRangeByIndex(columnIndex, 10).setText(user.deviceId);
//         sheet.getRangeByIndex(columnIndex, 11).setText(activeTime.join(',\n'));
//       }
//       (mapData[key] as List);
//     }
//
//
//     sheet.getRangeByName('A1:K1').cellStyle.hAlign = XLS.HAlignType.justify;
//     sheet.getRangeByName('A1:K1').cellStyle.fontSize = 10;
//     sheet.getRangeByName('A1:K1').cellStyle.bold = true;
//
//     final List<int> bytes = workbook.saveAsStream();
//     workbook.dispose();
//     final filePath = await saveAndLaunchFile(bytes,
//         'DailyReport_${DateFormat('ddMMMyyyy').format(fromDate)}-${DateFormat('ddMMMyyyy').format(toDate)}.xlsx');
//     if (filePath != '') {
//       Helper.showBottomFlash(true, 'Alert', "Report saved successfully");
//       openInvoice(filePath);
//     } else {
//       Helper.showBottomFlash(
//           false, 'Alert', "Report not saved,please try again");
//     }
//   } finally {
//     isLoading.value = false;
//   }
// }

