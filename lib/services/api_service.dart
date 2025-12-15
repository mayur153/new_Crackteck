import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';
import '../model/api_response.dart';

/// API Service for handling HTTP requests
class ApiService {
  ApiService._(); // Private constructor for singleton

  static final ApiService instance = ApiService._();

  // ---------------------------
  // Helper: safe JSON decode
  // ---------------------------
  Map<String, dynamic> _safeJsonDecode(String body) {
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) return decoded;
      return {'message': 'Server returned unexpected JSON format', 'data': decoded};
    } catch (_) {
      return {'message': 'Server returned non-JSON response', 'raw': body};
    }
  }

  // ---------------------------
  // Helper: common headers
  // ---------------------------
  Map<String, String> get _headers => const {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// Login - Send OTP
  Future<ApiResponse> login({
    required int roleId,
    required String phoneNumber,
  }) async {
    try {
      debugPrint('🔵 API Request: POST ${ApiConstants.login}');
      debugPrint('🔵 Request Body: {"role_id": $roleId, "phone_number": "$phoneNumber"}');

      final response = await http
          .post(
        Uri.parse(ApiConstants.login),
        headers: _headers,
        body: jsonEncode({'role_id': roleId, 'phone_number': phoneNumber}),
      )
          .timeout(ApiConstants.requestTimeout);

      debugPrint('🟡 API Response Status: ${response.statusCode}');
      debugPrint('🟡 API Response Body: ${response.body}');

      final jsonResponse = _safeJsonDecode(response.body);

      // Success
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          success: jsonResponse['success'] ?? true,
          message: jsonResponse['message'] ?? 'OTP sent',
          data: jsonResponse['data'],
          errors: jsonResponse['errors'],
        );
      }

      // Common "user not found / invalid" status codes
      if (response.statusCode == 404 || response.statusCode == 422) {
        return ApiResponse(
          success: false,
          message: jsonResponse['message'] ?? 'User not found',
          errors: jsonResponse['errors'],
        );
      }

      // Other server errors
      return ApiResponse(
        success: false,
        message: jsonResponse['message'] ?? 'Server error: ${response.statusCode}',
        errors: jsonResponse['errors'],
      );
    } on HandshakeException catch (e) {
      debugPrint('🔴 SSL Handshake Error: $e');
      return ApiResponse(
        success: false,
        message: 'SSL error: ${e.message}',
      );
    } on SocketException catch (e) {
      debugPrint('🔴 No Internet / DNS Error: $e');
      return ApiResponse(
        success: false,
        message: 'No internet connection. Please check your network.',
      );
    } on http.ClientException catch (e) {
      debugPrint('🔴 ClientException: $e');
      return ApiResponse(
        success: false,
        message: 'Request failed: ${e.message}',
      );
    } on TimeoutException catch (e) {
      debugPrint('🔴 Timeout: $e');
      return ApiResponse(
        success: false,
        message: 'Request timeout. Please try again.',
      );
    } catch (e) {
      debugPrint('🔴 Unexpected Error: $e');
      return ApiResponse(
        success: false,
        message: 'Unexpected error: $e',
      );
    }
  }

  /// Verify OTP
  Future<ApiResponse> verifyOtp({
    required int roleId,
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      debugPrint('🔵 API Request: POST ${ApiConstants.verifyOtp}');
      debugPrint(
        '🔵 Request Body: {"role_id": $roleId, "phone_number": "$phoneNumber", "otp": "$otp"}',
      );

      final response = await http
          .post(
        Uri.parse(ApiConstants.verifyOtp),
        headers: _headers,
        body: jsonEncode({
          'role_id': roleId,
          'phone_number': phoneNumber,
          'otp': otp,
        }),
      )
          .timeout(ApiConstants.requestTimeout);

      debugPrint('🟡 API Response Status: ${response.statusCode}');
      debugPrint('🟡 API Response Body: ${response.body}');

      final jsonResponse = _safeJsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          success: jsonResponse['success'] ?? true,
          message: jsonResponse['message'] ?? 'OTP verified',
          data: jsonResponse['data'],
          errors: jsonResponse['errors'],
        );
      }

      if (response.statusCode == 404 || response.statusCode == 422) {
        return ApiResponse(
          success: false,
          message: jsonResponse['message'] ?? 'Invalid OTP / user not found',
          errors: jsonResponse['errors'],
        );
      }

      return ApiResponse(
        success: false,
        message: jsonResponse['message'] ?? 'Server error: ${response.statusCode}',
        errors: jsonResponse['errors'],
      );
    } on HandshakeException catch (e) {
      debugPrint('🔴 SSL Handshake Error: $e');
      return ApiResponse(
        success: false,
        message: 'SSL error: ${e.message}',
      );
    } on SocketException catch (e) {
      debugPrint('🔴 No Internet / DNS Error: $e');
      return ApiResponse(
        success: false,
        message: 'No internet connection. Please check your network.',
      );
    } on http.ClientException catch (e) {
      debugPrint('🔴 ClientException: $e');
      return ApiResponse(
        success: false,
        message: 'Request failed: ${e.message}',
      );
    } on TimeoutException catch (e) {
      debugPrint('🔴 Timeout: $e');
      return ApiResponse(
        success: false,
        message: 'Request timeout. Please try again.',
      );
    } catch (e) {
      debugPrint('🔴 Unexpected Error: $e');
      return ApiResponse(
        success: false,
        message: 'Unexpected error: $e',
      );
    }
  }

  /// Refresh Token
  Future<ApiResponse> refreshToken({required int roleId}) async {
    try {
      debugPrint('🔵 API Request: POST ${ApiConstants.refreshToken}');
      debugPrint('🔵 Request Body: {"role_id": $roleId}');

      final response = await http
          .post(
        Uri.parse(ApiConstants.refreshToken),
        headers: _headers,
        body: jsonEncode({'role_id': roleId}),
      )
          .timeout(ApiConstants.requestTimeout);

      debugPrint('🟡 API Response Status: ${response.statusCode}');
      debugPrint('🟡 API Response Body: ${response.body}');

      final jsonResponse = _safeJsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          success: jsonResponse['success'] ?? true,
          message: jsonResponse['message'] ?? 'Token refreshed',
          data: jsonResponse['data'],
          errors: jsonResponse['errors'],
        );
      }

      return ApiResponse(
        success: false,
        message: jsonResponse['message'] ?? 'Token refresh failed',
        errors: jsonResponse['errors'],
      );
    } on HandshakeException catch (e) {
      debugPrint('🔴 SSL Handshake Error: $e');
      return ApiResponse(success: false, message: 'SSL error: ${e.message}');
    } on SocketException {
      return ApiResponse(success: false, message: 'No internet connection. Please check your network.');
    } on TimeoutException {
      return ApiResponse(success: false, message: 'Request timeout. Please try again.');
    } catch (e) {
      debugPrint('🔴 Unexpected Error: $e');
      return ApiResponse(success: false, message: 'Unexpected error: $e');
    }
  }

  /// Logout
  Future<ApiResponse> logout({required int roleId}) async {
    try {
      debugPrint('🔵 API Request: POST ${ApiConstants.logout}');
      debugPrint('🔵 Request Body: {"role_id": $roleId}');

      final response = await http
          .post(
        Uri.parse(ApiConstants.logout),
        headers: _headers,
        body: jsonEncode({'role_id': roleId}),
      )
          .timeout(ApiConstants.requestTimeout);

      debugPrint('🟡 API Response Status: ${response.statusCode}');
      debugPrint('🟡 API Response Body: ${response.body}');

      final jsonResponse = _safeJsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          success: jsonResponse['success'] ?? true,
          message: jsonResponse['message'] ?? 'Logged out',
          data: jsonResponse['data'],
          errors: jsonResponse['errors'],
        );
      }

      return ApiResponse(
        success: false,
        message: jsonResponse['message'] ?? 'Logout failed',
        errors: jsonResponse['errors'],
      );
    } on HandshakeException catch (e) {
      debugPrint('🔴 SSL Handshake Error: $e');
      return ApiResponse(success: false, message: 'SSL error: ${e.message}');
    } on SocketException {
      return ApiResponse(success: false, message: 'No internet connection. Please check your network.');
    } on TimeoutException {
      return ApiResponse(success: false, message: 'Request timeout. Please try again.');
    } catch (e) {
      debugPrint('🔴 Unexpected Error: $e');
      return ApiResponse(success: false, message: 'Unexpected error: $e');
    }
  }
}
