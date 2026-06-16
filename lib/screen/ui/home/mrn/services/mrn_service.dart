// // lib/services/mrn_service.dart
// import 'package:dio/dio.dart';
// import '../../../../../services/api_service/api_client.dart';
// import 'api_client.dart';
// import '../model/mrn_models.dart';
//
// class MRNService {
//   final _client = ApiClient().dio;
//
//   //  GET /api/mrn 
//   Future<ApiResponse<PaginatedResponse<MRN>>> getMRNs({
//     int page = 1,
//     int pageSize = 20,
//     String? status,
//     String? search,
//     int? partyId,
//     int? siteId,
//     int? jobTypeId,
//     int? statusId,
//     DateTime? fromDate,
//     DateTime? toDate,
//   }) async {
//     try {
//       final response = await _client.get('/mrn', queryParameters: {
//         'Page': page,
//         'PageSize': pageSize,
//         if (statusId != null) 'StatusID': statusId,
//         if (partyId != null) 'PartyID': partyId,
//         if (siteId != null) 'SiteID': siteId,
//         if (jobTypeId != null) 'JobTypeID': jobTypeId,
//         if (search != null && search.isNotEmpty) 'SearchText': search,
//         if (fromDate != null) 'FromDate': fromDate.toIso8601String(),
//         if (toDate != null) 'ToDate': toDate.toIso8601String(),
//       });
//       final data = response.data['data'] ?? response.data;
//       return ApiResponse.success(PaginatedResponse.fromJson(
//           data, (e) => MRN.fromJson(e as Map<String, dynamic>)));
//     } on DioException catch (e) {
//       return ApiResponse.error(ApiClient.errorMessage(e));
//     }
//   }
//
//   //  POST /api/mrn 
//   Future<ApiResponse<MRN>> createMRN(CreateMRNRequest request) async {
//     try {
//       final response = await _client.post('/mrn', data: request.toJson());
//       // POST returns { mrnid, mrnNo } not full MRN — fetch detail
//       final created = response.data['data'] ?? response.data;
//       final id = (created['mrnid'] ?? created['mrnId']).toString();
//       return getMRN(id);
//     } on DioException catch (e) {
//       return ApiResponse.error(ApiClient.errorMessage(e));
//     }
//   }
//
//   //  GET /api/mrn/filter-options 
//   Future<ApiResponse<MRNFilterOptions>> getFilterOptions() async {
//     try {
//       final response = await _client.get('/mrn/filter-options');
//       return ApiResponse.success(
//           MRNFilterOptions.fromJson(response.data['data'] ?? response.data));
//     } on DioException catch (e) {
//       return ApiResponse.error(ApiClient.errorMessage(e));
//     }
//   }
//
//   //  GET /api/mrn/{id} 
//   Future<ApiResponse<MRN>> getMRN(String id) async {
//     try {
//       final response = await _client.get('/mrn/$id');
//       final data = response.data['data'] ?? response.data;
//       return ApiResponse.success(MRN.fromJson(data as Map<String, dynamic>));
//     } on DioException catch (e) {
//       return ApiResponse.error(ApiClient.errorMessage(e));
//     }
//   }
//
//   //  DELETE /api/mrn/{id} 
//   Future<ApiResponse<bool>> deleteMRN(String id) async {
//     try {
//       await _client.delete('/mrn/$id');
//       return ApiResponse.success(true);
//     } on DioException catch (e) {
//       return ApiResponse.error(ApiClient.errorMessage(e));
//     }
//   }
//
//   //  PUT /api/mrn/{id}/status 
//   // API expects 'statusID' (PascalCase) not 'status'
//   Future<ApiResponse<bool>> updateMRNStatus(
//       String id,
//       int statusCode, {
//         String? remarks,
//       }) async {
//     try {
//       await _client.put('/mrn/$id/status', data: {
//         'statusID': statusCode, // ← fixed key
//         if (remarks != null && remarks.isNotEmpty) 'remarks': remarks,
//       });
//       return ApiResponse.success(true);
//     } on DioException catch (e) {
//       return ApiResponse.error(ApiClient.errorMessage(e));
//     }
//   }
//
//   //  POST /api/mrn/{id}/attachments 
//   Future<ApiResponse<bool>> uploadAttachment(
//       String mrnId,
//       String filePath,
//       String fileName, {
//         String category = 'DOCUMENT',
//       }) async {
//     try {
//       final formData = FormData.fromMap({
//         'file': await MultipartFile.fromFile(filePath, filename: fileName),
//         'category': category,
//       });
//       await _client.post(
//         '/mrn/$mrnId/attachments',
//         data: formData,
//         options: Options(headers: {'Content-Type': 'multipart/form-data'}),
//       );
//       return ApiResponse.success(true);
//     } on DioException catch (e) {
//       return ApiResponse.error(ApiClient.errorMessage(e));
//     }
//   }
// }
