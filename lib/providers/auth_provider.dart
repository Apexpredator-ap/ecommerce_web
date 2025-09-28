import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  bool _isLoading = false;
  String? _userName;
  String? _userEmail;

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;
  String? get userName => _userName;
  String? get userEmail => _userEmail;

  AuthProvider() {
    // Listen to auth state changes
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      if (user != null) {
        _userEmail = user.email;
        _loadUserData();
      } else {
        _userName = null;
        _userEmail = null;
      }
      notifyListeners();
    });
  }

  /// Load user data from Firestore
  Future<void> _loadUserData() async {
    if (_user != null) {
      try {
        DocumentSnapshot userDoc = await _firestore
            .collection('users')
            .doc(_user!.uid)
            .get();

        if (userDoc.exists) {
          Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
          _userName = userData['name'] ?? _user!.displayName ?? 'User';
        } else {
          _userName = _user!.displayName ?? 'User';
        }
        notifyListeners();
      } catch (e) {
        _userName = _user!.displayName ?? 'User';
        debugPrint('Error loading user data: $e');
      }
    }
  }

  /// Sign in with email and password
  Future<void> signIn(String email, String password, bool rememberMe) async {
    _setLoading(true);

    try {
      // Sign in with Firebase
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      // Handle remember me functionality
      if (rememberMe) {
        await _saveCredentials(email, password);
      } else {
        await _clearSavedCredentials();
      }

      // Load user data after successful sign in
      await _loadUserData();

    } on FirebaseAuthException catch (e) {
      String errorMessage = _getAuthErrorMessage(e.code);
      throw errorMessage;
    } catch (e) {
      throw 'An unexpected error occurred. Please try again.';
    } finally {
      _setLoading(false);
    }
  }

  /// Sign up with email, password and name
  Future<void> signUp(String email, String password, String name) async {
    _setLoading(true);

    try {
      // Create user with Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      // Update display name in Firebase Auth
      await userCredential.user!.updateDisplayName(name);

      // Save user data to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Set local user data
      _userName = name;
      _userEmail = email;

    } on FirebaseAuthException catch (e) {
      String errorMessage = _getAuthErrorMessage(e.code);
      throw errorMessage;
    } catch (e) {
      throw 'Failed to create account. Please try again.';
    } finally {
      _setLoading(false);
    }
  }

  /// Sign out user
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _userName = null;
      _userEmail = null;
      // Optionally clear saved credentials on logout
      // await _clearSavedCredentials();
    } catch (e) {
      throw 'Failed to sign out. Please try again.';
    }
  }

  /// Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getAuthErrorMessage(e.code);
      throw errorMessage;
    } catch (e) {
      throw 'Failed to send reset email. Please try again.';
    }
  }

  /// Update user name
  Future<void> updateUserName(String newName) async {
    if (_user == null || newName.trim().isEmpty) {
      throw 'Invalid user or name.';
    }

    _setLoading(true);

    try {
      // Update in Firestore
      await _firestore.collection('users').doc(_user!.uid).update({
        'name': newName.trim(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Update in Firebase Auth
      await _user!.updateDisplayName(newName.trim());

      // Update local state
      _userName = newName.trim();

    } catch (e) {
      throw 'Failed to update name. Please try again.';
    } finally {
      _setLoading(false);
    }
  }

  /// Update user password
  Future<void> updatePassword(String currentPassword, String newPassword) async {
    if (_user == null) {
      throw 'No user logged in.';
    }

    if (currentPassword.isEmpty || newPassword.isEmpty) {
      throw 'Please fill all password fields.';
    }

    if (newPassword.length < 6) {
      throw 'New password must be at least 6 characters.';
    }

    _setLoading(true);

    try {
      // Re-authenticate user with current password
      AuthCredential credential = EmailAuthProvider.credential(
        email: _user!.email!,
        password: currentPassword,
      );

      await _user!.reauthenticateWithCredential(credential);

      // Update password
      await _user!.updatePassword(newPassword);

      // Update saved credentials if they exist
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedEmail = prefs.getString('saved_email');
      if (savedEmail != null) {
        await _saveCredentials(savedEmail, newPassword);
      }

    } on FirebaseAuthException catch (e) {
      String errorMessage = _getAuthErrorMessage(e.code);
      throw errorMessage;
    } catch (e) {
      throw 'Failed to update password. Please try again.';
    } finally {
      _setLoading(false);
    }
  }

  /// Save credentials for remember me feature
  Future<void> _saveCredentials(String email, String password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('saved_email', email);
      await prefs.setString('saved_password', password);
      await prefs.setBool('remember_me', true);
    } catch (e) {
      debugPrint('Error saving credentials: $e');
    }
  }

  /// Clear saved credentials
  Future<void> _clearSavedCredentials() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('saved_email');
      await prefs.remove('saved_password');
      await prefs.setBool('remember_me', false);
    } catch (e) {
      debugPrint('Error clearing credentials: $e');
    }
  }

  /// Get saved credentials
  Future<Map<String, String>?> getSavedCredentials() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool rememberMe = prefs.getBool('remember_me') ?? false;

      if (rememberMe) {
        String? email = prefs.getString('saved_email');
        String? password = prefs.getString('saved_password');

        if (email != null && password != null) {
          return {
            'email': email,
            'password': password,
          };
        }
      }
    } catch (e) {
      debugPrint('Error getting saved credentials: $e');
    }
    return null;
  }

  /// Check if credentials are saved
  Future<bool> hasRememberedCredentials() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool('remember_me') ?? false;
    } catch (e) {
      debugPrint('Error checking remembered credentials: $e');
      return false;
    }
  }

  /// Delete user account
  Future<void> deleteAccount(String currentPassword) async {
    if (_user == null) {
      throw 'No user logged in.';
    }

    _setLoading(true);

    try {
      // Re-authenticate user
      AuthCredential credential = EmailAuthProvider.credential(
        email: _user!.email!,
        password: currentPassword,
      );

      await _user!.reauthenticateWithCredential(credential);

      // Delete user data from Firestore
      await _firestore.collection('users').doc(_user!.uid).delete();

      // Delete user account
      await _user!.delete();

      // Clear saved credentials
      await _clearSavedCredentials();

    } on FirebaseAuthException catch (e) {
      String errorMessage = _getAuthErrorMessage(e.code);
      throw errorMessage;
    } catch (e) {
      throw 'Failed to delete account. Please try again.';
    } finally {
      _setLoading(false);
    }
  }

  /// Reload user data
  Future<void> reloadUser() async {
    if (_user != null) {
      await _user!.reload();
      _user = _auth.currentUser;
      await _loadUserData();
    }
  }

  /// Send email verification
  Future<void> sendEmailVerification() async {
    if (_user != null && !_user!.emailVerified) {
      try {
        await _user!.sendEmailVerification();
      } on FirebaseAuthException catch (e) {
        String errorMessage = _getAuthErrorMessage(e.code);
        throw errorMessage;
      }
    }
  }

  /// Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// Get user-friendly error messages
  String _getAuthErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'weak-password':
        return 'Password is too weak. Please choose a stronger password.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'operation-not-allowed':
        return 'This operation is not allowed.';
      case 'requires-recent-login':
        return 'Please log in again to perform this action.';
      case 'invalid-credential':
        return 'The provided credentials are invalid.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  /// Get user profile data
  Future<Map<String, dynamic>?> getUserProfile() async {
    if (_user == null) return null;

    try {
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(_user!.uid)
          .get();

      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>?;
      }
    } catch (e) {
      debugPrint('Error getting user profile: $e');
    }
    return null;
  }

  /// Update user profile data
  Future<void> updateUserProfile(Map<String, dynamic> data) async {
    if (_user == null) {
      throw 'No user logged in.';
    }

    _setLoading(true);

    try {
      data['updatedAt'] = FieldValue.serverTimestamp();

      await _firestore.collection('users').doc(_user!.uid).update(data);

      // Reload user data
      await _loadUserData();

    } catch (e) {
      throw 'Failed to update profile. Please try again.';
    } finally {
      _setLoading(false);
    }
  }

  /// Clear all user data (for logout)
  void _clearUserData() {
    _user = null;
    _userName = null;
    _userEmail = null;
  }

  @override
  void dispose() {
    // Clean up any resources if needed
    super.dispose();
  }
}