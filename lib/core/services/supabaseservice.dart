import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseClient _client = Supabase.instance.client;

  static SupabaseClient get client => _client;

  static User? get currentUser => _client.auth.currentUser;

  static String? get userId => _client.auth.currentUser?.id;

  static bool get isAuthenticated => _client.auth.currentUser != null;

  static Future<AuthResponse> signUpWithEmail(String email, String password) async {
    return await _client.auth.signUp(email: email, password: password);
  }

  static Future<AuthResponse> signInWithEmail(String email, String password) async {
    return await _client.auth.signInWithPassword(email: email, password: password);
  }

  static Future<void> signOut() async {
    await _client.auth.signOut();
  }

  static Future<AuthResponse> signInWithGoogle() async {
    return await _client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.flutter://bilibenta/auth/callback',
    );
  }

  static Future<AuthResponse> signInWithFacebook() async {
    return await _client.auth.signInWithOAuth(
      OAuthProvider.facebook,
      redirectTo: 'io.supabase.flutter://bilibenta/auth/callback',
    );
  }

  static Future<void> resetPasswordForEmail(String email) async {
    await _client.auth.resetPasswordForEmail(email);
  }

  static Future<AuthResponse> updateUser(UserAttributes attributes) async {
    return await _client.auth.updateUser(attributes);
  }

  // Listen to auth state changes
  static Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  // Listen to realtime updates
  static RealtimeChannel listenToTable(String table, String event) {
    return _client.realtime.channel('public:$table').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(
        event: event,
        schema: 'public',
        table: table,
      ),
      (payload, [ref]) {},
    );
  }
}