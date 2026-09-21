import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';
import 'supabase_service.dart';
import 'user_service.dart';

class AuthService {
  final _supabase = SupabaseService.client;

  Stream<AuthState> get authStateChanges => SupabaseService.authStateChanges;

  Future<bool> registerWithEmail({
    required String email,
    required String password,
    required String fullName,
    required String username,
    required String province,
    required String city,
  }) async {
    try {
      final authResponse = await SupabaseService.signUpWithEmail(email, password);
      
      if (authResponse.user != null) {
        // Create user profile
        await UserService.createUserProfile(
          userId: authResponse.user!.id,
          email: email,
          fullName: fullName,
          username: username,
          province: province,
          city: city,
        );
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await SupabaseService.signInWithEmail(email, password);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> loginWithGoogle() async {
    try {
      await SupabaseService.signInWithGoogle();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> loginWithFacebook() async {
    try {
      await SupabaseService.signInWithFacebook();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> loginWithPhone({
    required String phone,
  }) async {
    try {
      await _supabase.auth.signInWithOtp(
        phone: phone,
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> verifyOTP({
    required String phone,
    required String token,
  }) async {
    try {
      final response = await _supabase.auth.verifyOTP(
        phone: phone,
        token: token,
        type: OtpType.sms,
      );
      
      if (response.user != null) {
        // Check if user exists, if not create profile
        final exists = await UserService.userExists(response.user!.id);
        if (!exists) {
          await UserService.createUserProfile(
            userId: response.user!.id,
            email: response.user!.email ?? '',
            phone: phone,
            fullName: phone,
            username: 'user_${response.user!.id.substring(0, 8)}',
            province: 'Metro Manila',
            city: 'Manila',
          );
        }
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      await SupabaseService.resetPasswordForEmail(email);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updatePassword(String newPassword) async {
    try {
      await SupabaseService.updateUser(
        UserAttributes(password: newPassword),
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await SupabaseService.signOut();
    } catch (e) {
      rethrow;
    }
  }

  bool isLoggedIn() {
    return SupabaseService.isAuthenticated;
  }

  String? getCurrentUserId() {
    return SupabaseService.userId;
  }

  User? getCurrentUser() {
    return SupabaseService.currentUser;
  }
}