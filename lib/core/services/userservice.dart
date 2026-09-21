import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';
import '../core/constants/app_constants.dart';
import 'supabase_service.dart';

class UserService {
  static final _supabase = SupabaseService.client;

  static Future<bool> userExists(String userId) async {
    try {
      final response = await _supabase
          .from(AppConstants.profilesTable)
          .select('id')
          .eq('id', userId)
          .limit(1);
      return response.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  static Future<void> createUserProfile({
    required String userId,
    required String email,
    String? phone,
    required String fullName,
    required String username,
    required String province,
    required String city,
    String? barangay,
  }) async {
    try {
      await _supabase.from(AppConstants.profilesTable).insert({
        'id': userId,
        'email': email,
        'phone': phone,
        'full_name': fullName,
        'username': username,
        'province': province,
        'city': city,
        'barangay': barangay,
        'joined_date': DateTime.now().toIso8601String(),
        'is_verified': false,
        'rating': 0.0,
        'review_count': 0,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserModel?> getUserProfile(String userId) async {
    try {
      final response = await _supabase
          .from(AppConstants.profilesTable)
          .select()
          .eq('id', userId)
          .single();
      
      return UserModel.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  static Future<void> updateUserProfile(String userId, UserModel user) async {
    try {
      await _supabase
          .from(AppConstants.profilesTable)
          .update(user.toJson())
          .eq('id', userId);
    } catch (e) {
      rethrow;
    }
  }

  static Future<String?> uploadProfileImage(String userId, String imagePath) async {
    try {
      final fileName = 'profile_$userId.jpg';
      
      await _supabase.storage
          .from(AppConstants.profileImagesBucket)
          .upload(fileName, File(imagePath));
      
      final publicUrl = _supabase.storage
          .from(AppConstants.profileImagesBucket)
          .getPublicUrl(fileName);
      
      // Update profile with image URL
      await _supabase
          .from(AppConstants.profilesTable)
          .update({'profile_image': publicUrl})
          .eq('id', userId);
      
      return publicUrl;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<UserModel>> searchUsers(String query) async {
    try {
      final response = await _supabase
          .from(AppConstants.profilesTable)
          .select()
          .or('username.ilike.%$query%,full_name.ilike.%$query%')
          .limit(10);
      
      return (response as List)
          .map((user) => UserModel.fromJson(user))
          .toList();
    } catch (e) {
      return [];
    }
  }
}