// lib/supabase_services.dart

import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

/// A custom class to represent the result of an authentication operation.
///
/// This provides a clean way to handle both success and failure states,
/// avoiding the need for extensive try-catch blocks in the UI.
class AuthResult {
  final bool success;
  final User? user;
  final String? errorMessage;

  AuthResult._({required this.success, this.user, this.errorMessage});

  /// Factory constructor for a successful result.
  /// The [user] can be null for operations like sign-out or password reset,
  /// where the action is successful but doesn't return a user session object.
  factory AuthResult.success(User? user) {
    return AuthResult._(success: true, user: user);
  }

  /// Factory constructor for a failed result.
  factory AuthResult.failure(String errorMessage) {
    return AuthResult._(success: false, errorMessage: errorMessage);
  }
}

/// A centralized service class to handle all Supabase authentication operations.
///
/// This class uses the Singleton pattern to ensure a single instance
/// is used throughout the application.
class SupabaseAuthService {
  // Private constructor for the Singleton pattern
  SupabaseAuthService._();

  // The single instance of the service
  static final SupabaseAuthService instance = SupabaseAuthService._();

  // The Supabase client instance
  final _supabase = Supabase.instance.client;

  // --- AUTH STATE MANAGEMENT ---

  /// A stream that emits the current user's authentication state.
  /// The UI should listen to this stream to reactively update when a user
  /// signs in or out.
  Stream<User?> get authStateChanges =>
      _supabase.auth.onAuthStateChange.map((event) => event.session?.user);

  /// Returns the currently logged-in user, or null if there is none.
  User? get currentUser => _supabase.auth.currentUser;

  // --- SIGN UP ---

  /// Signs up a new user with an email, password, and additional metadata.
  ///
  /// [email]: The user's email address.
  /// [password]: The user's password.
  /// [fullName]: The user's full name to be stored in user metadata.
  /// [studentId]: The student's ID to be stored in user metadata.
  ///
  /// Returns an [AuthResult] indicating success or failure.
  Future<AuthResult> signUp({
    required String email,
    required String password,
    required String fullName,
    required String studentId,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'student_id': studentId,
        },
      );
      if (response.user != null) {
        // If email confirmation is disabled, user will be logged in.
        // If enabled, user is created but not active.
        return AuthResult.success(response.user);
      } else {
        return AuthResult.failure(
            'Could not complete sign up. Please try again.');
      }
    } on AuthException catch (e) {
      return AuthResult.failure(_getAuthErrorMessage(e));
    } catch (e) {
      return AuthResult.failure(
          'An unexpected error occurred: ${e.toString()}');
    }
  }

  // --- SIGN IN ---

  /// Signs in an existing user with their email and password, or student ID and password.
  ///
  /// [identifier]: The user's email address or student ID.
  /// [password]: The user's password.
  ///
  /// Returns an [AuthResult] indicating success or failure.
  Future<AuthResult> signIn({
    required String identifier,
    required String password,
  }) async {
    try {
      String emailToUse = identifier;

      // If the identifier is not an email, assume it's a student ID.
      if (!_isEmail(identifier)) {
        // Call the database function to get the email associated with the student ID.
        final result = await _supabase.rpc(
          'get_email_by_student_id',
          params: {'student_id_to_find': identifier},
        );

        if (result == null) {
          return AuthResult.failure('No account found with this Student ID.');
        }
        emailToUse = result;
      }

      // Proceed with sign-in using the found email.
      final response = await _supabase.auth.signInWithPassword(
        email: emailToUse,
        password: password,
      );
      return AuthResult.success(response.user!);
    } on AuthException catch (e) {
      return AuthResult.failure(_getAuthErrorMessage(e));
    } catch (e) {
      return AuthResult.failure(
          'An unexpected error occurred: ${e.toString()}');
    }
  }

  // --- SIGN IN WITH OAUTH ---

  /// Initiates a sign-in with a third-party OAuth provider (e.g., Google, GitHub).
  ///
  /// [provider]: The OAuth provider to use (e.g., `Provider.google`).
  /// [redirectTo]: The deep link to redirect to after authentication.
  Future<void> signInWithOAuth(OAuthProvider provider,
      {String? redirectTo}) async {
    try {
      await _supabase.auth.signInWithOAuth(
        provider,
        redirectTo: redirectTo,
      );
    } on AuthException catch (e) {
      log('OAuth Error: ${e.message}');
    } catch (e) {
      log('Unexpected OAuth Error: ${e.toString()}');
    }
  }

  // --- SIGN OUT ---

  /// Signs out the currently logged-in user.
  ///
  /// Returns an [AuthResult] indicating success or failure.
  /// On success, the user object will be null.
  Future<AuthResult> signOut() async {
    try {
      await _supabase.auth.signOut();
      // A successful sign-out means there is no current user.
      return AuthResult.success(null);
    } on AuthException catch (e) {
      return AuthResult.failure(_getAuthErrorMessage(e));
    } catch (e) {
      return AuthResult.failure(
          'An unexpected error occurred: ${e.toString()}');
    }
  }

  // --- PASSWORD RESET ---

  /// Sends a password reset email to the user.
  ///
  /// [email]: The email address of the user whose password needs to be reset.
  ///
  /// Returns an [AuthResult] indicating success or failure.
  /// On success, the user object will be null.
  Future<AuthResult> resetPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
      // The action was successful, but no user session is returned.
      return AuthResult.success(null);
    } on AuthException catch (e) {
      return AuthResult.failure(_getAuthErrorMessage(e));
    } catch (e) {
      return AuthResult.failure(
          'An unexpected error occurred: ${e.toString()}');
    }
  }

  // --- UPDATE USER ---

  /// Updates the user's email, password, or metadata.
  ///
  /// This action can only be performed by a logged-in user.
  ///
  /// [email]: The new email address (optional).
  /// [password]: The new password (optional).
  /// [data]: A map of new metadata to merge with existing metadata (optional).
  ///
  /// Returns an [AuthResult] indicating success or failure.
  Future<AuthResult> updateUser({
    String? email,
    String? password,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _supabase.auth.updateUser(
        UserAttributes(
          email: email,
          password: password,
          data: data,
        ),
      );
      return AuthResult.success(response.user!);
    } on AuthException catch (e) {
      return AuthResult.failure(_getAuthErrorMessage(e));
    } catch (e) {
      return AuthResult.failure(
          'An unexpected error occurred: ${e.toString()}');
    }
  }

  // --- HELPER METHODS ---

  /// Checks if a given string is a valid email format.
  bool _isEmail(String string) {
    // Simple regex for email validation
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(string);
  }

  /// Translates Supabase [AuthException] codes into user-friendly messages.
  String _getAuthErrorMessage(AuthException exception) {
    switch (exception.message) {
      case 'Invalid login credentials':
        return 'The credentials you entered is incorrect.';
      case 'Email not confirmed':
        return 'Please verify your email address before signing in. Check your inbox for the confirmation link.';
      case 'User already registered':
        return 'An account with this email address already exists.';
      case 'Password should be at least 6 characters':
        return 'Password is too weak. Please choose a password with at least 6 characters.';
      case 'Unable to validate email address: invalid format':
        return 'The email address you entered is not valid.';
      default:
        return 'An authentication error occurred: ${exception.message}';
    }
  }
}
