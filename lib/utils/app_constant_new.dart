import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//  New Figma Design System 
const Color newBlueColor        = Color(0xFF5B6CF6); // Primary CTA
final Color newBlueLightColor   = const Color(0xFF5B6CF6).withValues(alpha: 0.10); // Light blue bg
const Color newSurfaceColor     = Color(0xFFF8FAFC); // Input / card bg
const Color newBorderColor      = Color(0xFFE2E8F0); // Subtle border
const Color newTextPrimary      = Color(0xFF0F172A); // Heading text
const Color newTextSecondary    = Color(0xFF64748B); // Sub text
const Color newTextHint         = Color(0xFF94A3B8); // Placeholder
const Color newGreenColor       = Color(0xFF10B981); // Success / Completed
const Color newGreenLightColor  = Color(0xFFD1FAE5); // Green badge bg
const Color newOrangeColor      = Color(0xFFF59E0B); // Pending / Warning
const Color newOrangeLightColor = Color(0xFFFEF3C7); // Orange badge bg
const Color newRedColor         = Color(0xFFEF4444); // Error / Cancelled
const Color newRedLightColor    = Color(0xFFFEE2E2); // Red badge bg
const Color backgroundColor     = Color(0xFFFDFDFD); //background

//  Legacy colours (kept so existing screens compile) 
const Color purpleColor           = Color(0xFF5B6CF6);
final Color purpleLight           = const Color(0xFF5B6CF6).withValues(alpha: 0.10);
final Color purpleLightest        = const Color(0xFF5B6CF6).withValues(alpha: 0.05);


const Color blueColor             = Color(0xFF5B6CF6);
const Color grTopColor            = Color(0xFFEFF6FF);
const Color grBottomColor         = Color(0xFF2563EB);
const Color darkOrangeColor       = Color(0xFFF97316);
final Color orangeColor           = Color(0xFFF97316);
const Color whiteBoxColor         = Color(0xFFF8FAFC);
const Color unselectedColor       = Color(0xFFE2E8F0);
const Color msgTextColor          = Color(0xFF64748B);
const Color medGreyColor          = Color(0xFF94A3B8);
const Color blackColor            = Color(0xFF0F172A);
const Color lightGreyColor        = Color(0xFFF1F5F9);
const Color whiteColor            = Color(0xFFFFFFFF);
const Color red2Color             = Color(0xFFC71B23);
const Color greenColor            = Color(0xFF009847);
const Color lightGreenColor       = Color(0xFF009847);
const Color darkGreenColor        = Color(0xFF006D75);
const Color grey                  = Colors.grey;
const Color lightOrangeColor      = Color(0xFFF07F1B);
const Color dropdownBoxColor      = Color(0xFFEFF6FF);
const Color progressAttendanceColor = Color(0xFFF1F5F9);
const Color leaveBoxColor         = Color(0xFFF8FAFC);
const Color yellowColor           = Color(0xFFF59E0B);
const Color green2Color           = Color(0xFF009847);
const Color redColor              = Color(0xFFC71B23);
const Color white2Color           = Color(0xFFF8FAFC);
const Color red3Color             = Color(0xFFC71B23);
const Color red4Color             = Color(0xFF5471E6);
const Color darkBlueColor         = Color(0xFF0C1A2E);
const Color green3Color           = Color(0xFF009847);
const Color green4Color           = Color(0xFF009847);
const Color green5Color           = Color(0xFF009847);
const Color chocolateColor        = Color(0xFF0F172A);
const Color fadeGreenColor        = Color(0xFFEFF6FF);
const Color purpleShadowColor     = Color(0xFFEFF6FF);
const Color categoryColor         = Color(0xFF2563EB);
const Color newColor              = Color(0xFFEFF6FF);

final Color purple2Color = const Color(0xFF5471E6).withValues(alpha: 0.8);

const LinearGradient gr1 = LinearGradient(
    colors: grad1, begin: Alignment.topCenter, end: Alignment.bottomCenter);
const LinearGradient gr1Opp = LinearGradient(
    colors: grad1, begin: Alignment.bottomCenter, end: Alignment.topCenter);
const List<Color> grad1 = [grTopColor, grBottomColor];

final LinearGradient gr2 = LinearGradient(
    colors: grad2, begin: Alignment.topCenter, end: Alignment.bottomCenter);
final LinearGradient gr2Opp = LinearGradient(
    colors: grad2, begin: Alignment.bottomCenter, end: Alignment.topCenter);
final List<Color> grad2 = [orangeColor, red2Color];
const List<Color> onlyGrey = [grey, grey];

const LinearGradient gr10 = LinearGradient(
    colors: onlyGrey, begin: Alignment.bottomCenter, end: Alignment.topCenter);

LinearGradient blueDropdownGr = LinearGradient(
  colors: [
    grBottomColor.withValues(alpha: 0.2),
    grTopColor.withValues(alpha: 0.2),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

LinearGradient orangeDropdownGr(double opacity) => LinearGradient(
  colors: [
    orangeColor.withValues(alpha: opacity),
    red2Color.withValues(alpha: opacity),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

LinearGradient customGradient({
  required Color topColor,
  required Color bottomColor,
  double? opacity,
  bool isHorizontal = false,
}) =>
    LinearGradient(
      colors: [
        topColor.withValues(alpha: opacity ?? 1),
        bottomColor.withValues(alpha: opacity ?? 1),
      ],
      begin: isHorizontal ? Alignment.centerLeft : Alignment.topCenter,
      end: isHorizontal ? Alignment.centerRight : Alignment.bottomCenter,
    );

const String dummyTextShort = 'Lorem Ipsum is simply dummy text of the printing';
const String dummyTextMed =
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text.';
const String dummyTextLong =
    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled';

const String dummyImageUrlTxt =
    'https://statinfer.com/wp-content/uploads/dummy-user.png';
const String dummyImage2UrlTxt =
    'https://source.unsplash.com/user/c_v_r/1600x900';
const String dummyImage3UrlTxt = 'https://picsum.photos/300/150';
const String dummyImage4UrlTxt = 'assets/icons/poins_icon.png';

const int orderFilter              = 0;
const int visitPlanFilter          = 1;
const int newVisitPlanFilter       = 2;
const int previewFilter            = 3;
const int orderDetailEdit          = 4;
const int attendanceListFilter     = 5;
const int productListFilter        = 6;
const int leaveHistoryFilter       = 7;
const int managerLeaveHistoryFilter = 8;
const int executiveAttendanceFilter = 9;

class VoucherType {
  static const String none       = '0';
  static const String receipt    = '1';
  static const String payment    = '2';
  static const String contra     = '3';
  static const String journal    = '5';
  static const String expense    = '14';
  static const String collection = '15';
}

class ReportType {
  static const String accountRegister = 'AR';
  static const String dayBook         = 'DB';
  static const String balanceSheet    = 'BS';
  static const String profitAndLoss   = 'PAL';
  static const String trialBalance    = 'TB';
}

class AppConst {
  static DateTime calenderFirstDate = DateTime(2000, 1, 1);
  static DateTime calenderLastDate  = DateTime(2050, 12, 31);
  static String appCastUrl =
      'https://raw.githubusercontent.com/Reyparmar/appxml/main/digitalerpappcast.xml';
}

class AppString {
  static const String edit                       = 'Edit';
  static const String filter                     = 'Filter';
  static const String date                       = 'Date';
  static const String month                      = 'Month';
  static const String selectExecutiveName        = 'Select Executive Name';
  static const String selectState                = 'Select State';
  static const String selectCity                 = 'Select City';
  static const String selectArea                 = 'Select Area';
  static const String selectCustomer             = 'Select Customer';
  static const String selectCollectionLedger     = 'Select Collection Ledger';
  static const String filterByDate               = 'Filter by Date';
  static const String filterByMonth              = 'Filter by Month';
  static const String selectMonth                = 'Select Month';
  static const String enterAmount                = 'Enter Amount';
  static const String amount                     = 'Amount';
  static const String paymentMode               = 'Payment Mode';
  static const String type                       = 'Type...';
  static const String remark                     = 'Remark';
  static const String chooseOption               = 'Choose Option';
  static const String selectImageFromGallery     = 'Select Image From Gallery';
  static const String takePicture                = 'Take Picture';
  static const String pleaseSelectDate           = 'Please Select Date';
  static const String enterCompanyNameTxt        = 'Enter Customer Name';
  static const String enterGstNoTxt              = 'Enter GST. No.';
  static const String enterMobileTxt             = 'Enter Mobile No.';
  static const String enterContactPersonTxt      = 'Enter Contact Person';
  static const String enterEmailIdTxt            = 'Enter Email ID';
  static const String enterPanNoTxt              = 'Enter Pan No.';
  static const String enterAddressTxt            = 'Enter Address';
  static const String enterCountryTxt            = 'Enter Country';
  static const String enterStateTxt              = 'Enter State';
  static const String enterPincodeTxt            = 'Enter Pincode';
  static const String enterCityTxt               = 'Enter City';
  static const String customerCompanyNameTxt     = 'Customer/Company Name';
  static const String mobileTxt                  = 'Mobile Number';
  static const String gstNoTxt                   = 'GST. No.';
  static const String contactPersonTxt           = 'Contact Person';
  static const String emailIdTxt                 = 'Email ID';
  static const String panNoTxt                   = 'Pan No.';
  static const String addressTxt                 = 'Address';
  static const String countryTxt                 = 'Country';
  static const String stateTxt                   = 'State';
  static const String cityTxt                    = 'City';
  static const String pincodeTxt                 = 'Pincode';
  static const String mapAddress                 = 'Map Address';
  static const String latLng                     = 'LatLng';
  static const String addCustomer                = 'Add Customer';
  static const String uploadDocument             = 'Upload Document';
  static const String uploadPicture              = 'Upload Picture';
  static const String changeImage                = 'Change Image';
  static const String pleaseEnterMobileTxt       = 'Please Enter Mobile Number';
  static const String pleaseEnterValidMobileTxt  = 'Please Enter Valid Mobile Number';
  static const String pleaseEnterCompanyNameTxt  = 'Please Enter Company Name';
  static const String pleaseEnterGstNoTxt        = 'Please Enter GST. No.';
  static const String pleaseEnterContactPersonTxt = 'Please Enter Contact Person';
  static const String pleaseEnterEmailIdTxt      = 'Please Enter Email ID';
  static const String pleaseEnterValidEmailIdTxt = 'Please Enter Valid Email ID';
  static const String pleaseEnterPanNoTxt        = 'Please Enter Pan No.';
  static const String pleaseEnterAddressTxt      = 'Please Enter Address';
  static const String pleaseEnterCountryTxt      = 'Please Enter Country';
  static const String pleaseEnterStateTxt        = 'Please Enter State';
  static const String pleaseSelectCompanyTxt     = 'Please select company';
  static const String pleaseEnterPincodeTxt      = 'Please Enter Pincode';
  static const String pleaseEnterValidPincodeTxt = 'Please Enter Valid Pincode';
  static const String pleaseEnterTitleTxt        = 'Please Enter title';
  static const String pleaseEnterDesTxt          = 'Please Enter description';
  static const String pleaseUploadDocumentTxt    = 'Please upload document';
  static const String sameForShippingAddressTxt  = 'Same for Shipping Address';
  static const String shippingAddressTxt         = 'Shipping Address';
  static const String pleaseEnterNameTxt         = 'Please Enter name';
  static const String pleaseEnterEmailTxt        = 'Please Enter email';
  static const String pleaseEnterValidEmailTxt   = 'Please Enter Valid email';
  static const String pleaseEnterValidAddressTxt = 'Please Enter Valid Address';
  static const String pleaseEnterAddress         = 'Please Enter address';
  static const String pleaseEnterCity            = 'Please Enter City';
  static const String pleaseEnterPasswordTxt     = 'Please Enter Password';
  static const String passAnConPassNotMatchTxt   =
      'Password and confirm password does not match';
  static const String pleaseEnterConfirmPasswordTxt = 'Please Enter Confirm Password';
  static const String passwordDoesNotMatchTxt    = 'Password does not match';
  static const String enter6DigitOtpTxt          = 'Please Enter 6-digit Otp';
  static const String noInternetConnectionTxt    = 'No Internet Connection';
  static const String pleaseCheckTxt             = 'Please Check';
  static const String requiredFieldTxt           = 'Required Field';
  static const String somethingTxt               = 'Something went wrong';
  static const String dateGreaterThanFromTxt     =
      'Please select to-Date must be greater than from-Date';
  static const String dateGreaterThanTodayTxt    =
      'Please select to-Date must be not greater than today';
  static const String dateGreaterThanYear        =
      'Please select to-Date must be less than current year';
  static const String selectFromDateTxt          = 'Please select from-Date';
  static const String selectToDateTxt            = 'Please select to-Date';
  static const String selectMonthTxt             = 'Please select month';
  static const String checkPermissionTxt         = 'Please check Permission';
  static const String locationPermissionDeniedTxt  = 'Location permission denied';
  static const String locationPermissionGrantedTxt = 'Location permission granted';
  static const String selectGroupTxt             = 'Please select group';
  static const String selectStatusTxt            = 'Please select any status from Dropdown';
  static const String messageTxt                 = 'Message';
  static const String productAddedTxt            = 'Product Added in Cart';
  static const String alreadyInCartTxt           = 'Product already in Cart';
  static const String productQtyUpdateTxt        = 'Product Qty Updated';
  static const String companyPendingTxt          = 'Selected company is pending for approval';
  static const String pleaseEnterLeadNo          = 'Please Enter Lead No';
  static const String pleaseEnterLeadDate        = 'Please Enter Lead Date';
  static const String pleaseEnterRequirementSpecification =
      'Please Enter Requirement Specification';
  static const String pleaseEnterCompanyName     = 'Please Enter Company Name';
  static const String pleaseEnterOwnerName       = 'Please Enter Owner Name';
  static const String pleaseEnterContactPerson   = 'Please Enter Contact Person';
  static const String pleaseEnterAlternateMobileNo = 'Please Enter Alternate Mobile No';
  static const String pleaseEnterMailId          = 'Please Enter Email Id';
  static const String pleaseEnterWebsite         = 'Please Enter Website';
  static const String pleaseEnterCompanyAddress  = 'Please Enter Company/Address';
  static const String pleaseEnterPhoneNo         = 'Please Enter Phone No';
  static const String pleaseEnterBusinessNature  = 'Please Enter Business Nature';
  static const String pleaseEnterRemark          = 'Please Enter Remark';
  static const String pleaseEnterFollowupTime    = 'Please Enter Followup Time';
  static const String pleaseEnterTaskDetails     = 'Please Enter TaskDetails';
  static const String pleaseEnterComment         = 'Please Enter Comment';
  static const String pleaseSelectFile           = 'Please Select File';
  static const String pleaseEnterShippingAddress = 'Please Enter Shipping Address';
  static const String pleaseEnterDelivered       = 'Please Enter Delivered';
  static const String pleaseEnterTransportName   = 'Please Enter TransportName';
  static const String pleaseEnterGRNo            = 'Please Enter GR Number';
  static const String pleaseEnterVehicleNo       = 'Please Enter Vehicle Number';
  static const String pleaseEnterEwayBillNo      = 'Please Enter Eway Bill Number';
  static const String pleaseEnterDeliveryType    = 'Please Enter Delivery Type';
  static const String pleaseEnterShippingNote    = 'Please Enter Shipping Note';
  static const String pleaseEnterTaskName        = 'Please Enter Task Name';
  static const String ddMMyyyy                   = 'dd-MM-yyyy';
  static const String yyyyMMdd                   = 'yyyy-MM-dd';
  static const String dateTimeFormat             = 'yyyy-MM-dd HH:mm:sss';
  static const String dateTimeEmpty             = '--/--/----';
  static const String printDSR                   = 'Print DSR';
  static const String goToMap                    = 'Go to Map';
  static const String documentType              = 'Document Type';
  static const String description               = 'Description';
  static const String title                     = 'Title';
  static const String executiveName             = 'Executive Name';
  static const String selectExecutive           = 'Select Executive';
  static const String forwardTo                 = 'Forward To';
  static const String absent                    = 'Absent';
  static const String liveLocation              = 'Live Location';
  static const String location                  = 'Location';
  static const String customerName              = 'Customer name';
  static const String updating                  = 'Updating...';
  static const String executive                 = 'Executive';
  static const String outstanding               = 'Outstanding';
  static const String stockReport               = 'Stock Report';
  static const String pendingShipping           = 'Pending Shipping';
  static const String attendanceReport          = 'Attendance Report';
  static const String order                     = 'Order';
  static const String payment                   = 'Payment';
  static const String visit                     = 'Visit';
  static const String voucherNo                 = 'Voucher No';
  static const String pleaseSelectAnyParty      = 'Please Select Any Party';
  static const String noCustomerFound           = 'No Customer Found';
  static const String submit                    = 'Submit';
  static const String entryNo                   = 'Entry no.';
  static const String partyName                 = 'Party Name';
  static const String deliveredTo               = 'Delivered to';
  static const String status                    = 'Status';
  static const String empName                   = 'Emp name';
  static const String workingDays               = 'Working Days';
  static const String presentDays               = 'Present Days';
  static const String absentDays                = 'Absent Days';
  static const String orderNo                   = 'Order No.';
  static const String orderDate                 = 'Order Date';
  static const String totalQty                  = 'Total Qty.';
  static const String qty                       = 'Qty.';
  static const String totalAmt                  = 'Total Amt.';
  static const String mobileNo                  = 'Mobile No.';
  static const String balance                   = 'Balance';
  static const String balanceType               = 'Balance Type';
  static const String mainGrp                   = 'Main Grp';
  static const String subGrp                    = 'Sub Grp';
  static const String brand                     = 'Brand';
  static const String itemName                  = 'Item Name';
  static const String rate                      = 'Rate';
  static const String unit                      = 'Unit';
  static const String leadNo                    = 'Lead No';
  static const String leadDate                  = 'Lead Date';
  static const String requirementSpecification  = 'Requirement Specification';
  static const String companyName               = 'Company Name';
  static const String ownerName                 = 'Owner Name';
  static const String contactPerson             = 'Contact Person';
  static const String alternateMobileNo         = 'Alternate Mobile No';
  static const String emailId                   = 'Email Id';
  static const String website                   = 'Website';
  static const String companyAddress            = 'Company/Address';
  static const String phoneNo                   = 'Phone No';
  static const String businessNature            = 'Business Nature';
  static const String enterLeadNo               = 'Enter Lead No';
  static const String enterLeadDate             = 'Enter Lead Date';
  static const String enterRequirementSpecification = 'Enter Requirement Specification';
  static const String enterCompanyName          = 'Enter Company Name';
  static const String enterOwnerName            = 'Enter Owner Name';
  static const String enterContactPerson        = 'Enter Contact Person';
  static const String enterAlternateMobileNo    = 'Enter Alternate Mobile No';
  static const String enterMailId               = 'Enter Email Id';
  static const String enterWebsite              = 'Enter Website';
  static const String enterCompanyAddress       = 'Enter Company/Address';
  static const String enterPhoneNo              = 'Enter Phone No';
  static const String enterBusinessNature       = 'Enter Business Nature';
  static const String sales                     = 'Sales';
  static const String amountReceived            = 'Amount Received';
  static const String totalIncentives           = 'Total Incentives';
  static const String paidIncentives            = 'Paid Incentives';
  static const String remainingIncentives       = 'Remaining Incentives';
  static const String srNo                      = 'Sr.No';
  static const String salesInvoiceNo            = 'Sales Invoice No.';
  static const String billNo                    = 'Bill No';
  static const String incentiveReceive          = 'Incentive Receive';
  static const String incentivePaid             = 'Incentive Paid';
  static const String incentiveDue              = 'Incentive Due';
  static const String itemQty                   = 'Item QTY';
  static const String price                     = 'Price';
  static const String totalPrice                = 'Total Price';
}

class NumberFormatter {
  static String format(dynamic value, {int decimal = 0}) {
    if (value == null) return "0";

    double number;

    if (value is String) {
      number = double.tryParse(value) ?? 0;
    } else if (value is num) {
      number = value.toDouble();
    } else {
      return "0";
    }

    // 🔥 remove trailing .00 if not needed
    if (number % 1 == 0) {
      return number.toInt().toString();
    }

    return number.toStringAsFixed(decimal);
  }
}