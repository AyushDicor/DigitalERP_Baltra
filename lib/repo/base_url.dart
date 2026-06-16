class AppUrls {
  // static const baseUrl = "http://salewebservice.digitalerp.biz/api/";
  // static const baseUrl = "http://demoservice.digitalerp.biz/api/";
  static const baseUrl = "http://supportapi.digitalerp.biz/api/";
}

class MethodName {
  static const organizationFetchApi = "organisation/orgdropdown";
  static const userNameFetchApi = "UserName/username";
  static const issueTypeFetchApi = "issuetype/issuetypedropdown";
  static const relatedServices = "Service/servicedropdown";
  static const moduleDropdown = "module/moduledropdown";
  static const ticketList = "Ticketentry/saveticketentry";

  static const getAllTicketList = "getComplainlist/getComplainlist";
  static const updateTicketEntry = "UpdateTicketEntry/UpdateTicketEntry";

  /// reimbursement

 // static const reimbursementDropDownType = 'ReimbursementDropdown';
  static const selectCurrency = "Currency/Currencydropdown";
 // static const submitReimbursementRequest = 'SaveReimbursement';
 // static const reimbursementGetList = 'GetExpenseListNew';
 // static const reimbursementGetDetail = 'GetExpenseDetail';
  //new apis
  static const getExpenseDetail = 'GetExpenseDetail';
  //static const getExpenseDesc = "getexpensedesc/getexpensedesc";
  static const getExpenseListNew = "GetExpenseListNew";
 //new apis
  static const reimbursementDropdown     = 'ReimbursementDropdown';
  static const uploadReimbursementFile   = 'UploadReimbursementFile';
  static const saveReimbursement         = 'SaveReimbursement';

  /// Lead Management

  static const businessTypeUrl = "BusinessType/BusinessTypedropdown";
  static const industryTypeUrl = "IndustryType/IndustryTypedropdown";
  static const interestedTypeUrl = "CurrentSoftware/CurrentSoftwaredropdown";
  // static const tagProductTypeUrl = "getitems/getitemslist";
  static const tagProductTypeUrl = "itemwithbranch/itemlistwithbranch";
  static const interestedInApi = "CurrentSoftware/CurrentSoftwaredropdown";
  static const decisionTimelineApi = "DecisionTimeline/DecisionTimelinedropdown";
  static const currentSoftwareApi = "DecisionTimeline/DecisionTimelinedropdown";
  static const saveLeadEntry = "leadentry/saveleadentry";

  ///
  static const getleadentryApi = "getleadentry/getleadentry";
  static const getLeadDetailFromId = "Leadedit/getlead";

  ///15-

  static const deleteLeadMethod = "deletelead/deletelead";
  static const insertLeadNotesAndFollowUpMethod = "/insertleadfollowup/leadfollowup";
  static const getNotesAndFollowupMethod = "/getremarksonlead/getremarks";
  static const deleteNotesMethod = "deleteremarks/deleteremarks";
  static const updateLeadEntry = "/updateleadentry/updateleadentry";

  ///
  static const getQuestionAgainLeads = "Quotation/getleadForQuotation";
  static const insertQuote = "InsertQuotation/saveQuotation";
  static const getQuote = "GetQuotation/getleadForQuotation";

  /// group and main group
  ///
  static const mainGroup = "categorywithbranch/getcategorylistwithbranch";
  static const subGroup = "subcategorywithbranch/subcategorylistwithbranch";


}
// TODO Implement this library.