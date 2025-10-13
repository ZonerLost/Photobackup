import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;
  static final AuthService instance = AuthService._internal();
  AuthService._internal();

  /// ------------------ SESSION MANAGEMENT ------------------
  Stream<AuthState> get authStateChanges => supabase.auth.onAuthStateChange;
  User? get currentUser => supabase.auth.currentUser;
  bool get isLoggedIn => currentUser != null;


  /// ------------------ SIGN UP ------------------
  Future<String?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      if (response.user != null) {
        return null; // Success
      }
      return response.session == null
          ? 'Sign up failed'
          : null; // In case of no session returned
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      throw("Error Signup $e");

    }
  }

  /// ------------------ LOGIN ------------------
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.session != null) {
        return null; // Success
      }
      return 'Login failed';
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  /// ------------------ LOGOUT ------------------
  Future<void> logout() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await supabase.auth.signOut();
    await googleSignIn.signOut();
  }

  /// ------------------ FORGET PASSWORD (SEND RESET EMAIL) ------------------
  Future<String?> sendPasswordResetEmail({required String email}) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);
      return null; // Success
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  /// ------------------ CHANGE PASSWORD AFTER LOGIN ------------------
  Future<String?> changePassword({required String newPassword}) async {
    try {
      final userId = currentUser?.id;
      if (userId == null) return "No logged-in user";

      final response = await supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );

      return response.user != null ? null : "Password change failed";
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  /// verify you account on the time of sign up

  Future<AuthResponse?> verifyOTP({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await supabase.auth.verifyOTP(
        email: email,
        token: otp,
        type: OtpType.signup,
      );

      if (response.user != null) {
        // Mark user as verified
        await supabase.auth.updateUser(
          UserAttributes(
            data: {'isVerified': true},
          ),
        );
      }

      return response;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<AuthResponse?> verifyResetWithOTP(String email, String otp) async {
    try {
      final response = await supabase.auth.verifyOTP(
        email: email,
        token: otp,
        type: OtpType.recovery,
      );
      return response;
    } catch (e) {
      rethrow; // let controller handle error
    }
  }

  Future<void> updateUserPassword(String newPassword) async {
    try {
      await supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
    } catch (e) {
      rethrow; // Let the controller handle errors
    }
  }



  /// ------------------ GOOGLE LOGIN ------------------
  Future<AuthResponse> googleSignIn() async {

    const webClientId = '823408425171-7bl6sesqh98bbfrco05q3h620sunmgn2.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }
}

/*

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speaker_ignite/View/Screens/Auth/Login/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../View/Screens/Auth/Login/forgetpw_otp.dart';
import '../../View/Screens/Auth/Login/reset_password.dart';
import '../../View/Screens/Auth/Login/reset_pw_success.dart';
import '../../core/enums/network_status.dart';
import '../../core/network_connectivity.dart';
import '../../core/snackbars.dart';

class AuthController extends GetxController {

  static AuthController instance = Get.find<AuthController>();


  final supabase = Supabase.instance.client;

  // Additional controllers for password reset
  TextEditingController newPasswordCtrlr = TextEditingController();
  TextEditingController confirmNewPasswordCtrlr = TextEditingController();
  TextEditingController otpCtrlr = TextEditingController();
  TextEditingController resetEmail= TextEditingController();


  //Reset Password Visibility
  RxBool isShowPwd = true.obs;
  RxBool isShowConfirmPwd = true.obs;

  // Showing the reset password screen new and new confirm show toggle

  void toggleResetPwdView() {
    isShowPwd.value = !isShowPwd.value;
  }

  //toggle confirm password
  void toggleResetConfirmPwdView() {
    isShowConfirmPwd.value = !isShowConfirmPwd.value;
  }

  // Loading states
  RxBool isLoggingOut = false.obs;
  RxBool isResettingPassword = false.obs;
  RxBool isResettingPassword1 = false.obs;
  RxBool isSendingResetEmail = false.obs;
  RxBool isChangingPassword = false.obs;
  RxBool isVerifying = false.obs;

  Future<void> verifyOTP(String email, String otp) async {

    final networkStatus = await NetworkConnectivity.instance.getNetworkStatus();
    if (networkStatus == NetworkStatus.offline) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Verification",
        message: "Network Problem. Please check your connection",
      );
      return;
    }

    try {
      isVerifying.value = true;

      final AuthResponse response = await supabase.auth.verifyOTP(
        email: email,
        token: otp,
        type: OtpType.signup,
      );

      if (response.user != null) {
        // Update user metadata to mark as verified
        await supabase.auth.updateUser(
          UserAttributes(
            data: {
              'isVerified': true,
            },
          ),
        );

        CustomSnackBars.instance.showSuccessSnackbar(
          title: "Verification",
          message: "Email verified successfully!",
        );

        Get.to(SuccessPWChange());
        // Navigate to login or home based on your flow
        // Get.off(() => Login());
      }
    } on AuthException catch (e) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Verification Failed",
        message: e.message,
      );
    } catch (e) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Verification Error",
        message: "An unexpected error occurred. Please try again.",
      );
      print(e);
    } finally {
      isVerifying.value = false;
    }
  }

  // Method to resend OTP
  Future<void> resendOTP(String email) async {
    // Check network connectivity
    final networkStatus = await NetworkConnectivity.instance.getNetworkStatus();
    if (networkStatus == NetworkStatus.offline) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Resend OTP",
        message: "Network Problem. Please check your connection",
      );
      return;
    }

    try {
      await supabase.auth.resend(
        type: OtpType.signup,
        email: email,
      );

      CustomSnackBars.instance.showSuccessSnackbar(
        title: "Resend OTP",
        message: "New verification code sent to your email",
      );
    } catch (e) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Resend Failed",
        message: "Failed to send new code. Please try again.",
      );
    }
  }

  // Method to check if email is verified
  Future<bool> isEmailVerified() async {
    try {
      final user = supabase.auth.currentUser;
      if (user != null) {
        final userData =
        await supabase.from('users').select().eq('id', user.id).single();

        return userData['isVerified'] ?? false;
      }
      return false;
    } catch (e) {
      return false;
    }
  }



  // Forgot password - Send reset email
  Future<void> forgotPassword(String email) async {
    // Check network connectivity
    final networkStatus = await NetworkConnectivity.instance.getNetworkStatus();
    if (networkStatus == NetworkStatus.offline) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Password Reset",
        message: "Network Problem. Please check your connection",
      );
      return;
    }

    try {
      isSendingResetEmail.value = true;
      await supabase.auth.resetPasswordForEmail(
        email,
        // not need for when otp verify
        // redirectTo: 'io.supabase.flutter://reset-callback/',
      );

      CustomSnackBars.instance.showSuccessSnackbar(
        title: "Password Reset",
        message: "Password reset Otp sent to your email",
      );
      Get.to(ForgetOtpVerification(email: email,));
      // Navigate to OTP verification screen if needed
      // Get.toNamed('/verify-reset');
    } catch (e) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Reset Failed",
        message: "Failed to send reset instructions. Please try again.",
      );
    } finally {
      isSendingResetEmail.value = false;
    }
  }

  Future<void> verifyResetWithOTP(String email, String otp) async {
    try {
      isResettingPassword.value = true;
      final AuthResponse response = await supabase.auth.verifyOTP(
        email: email,
        token: otp,
        type: OtpType.recovery,
      );

      if (response.user != null) {

        CustomSnackBars.instance.showSuccessSnackbar(
          title: "Verification",
          message: "Email verified successfully!",
        );

        otpCtrlr.clear();

        Get.to(ResetPassword());
        // Navigate to login
        // Get.offAllNamed('/login');
      }
    } catch (e) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Reset Failed",
        message: "Failed to reset password. Please try again.",
      );
    } finally {
      isResettingPassword.value = false;
    }
  }

  // Reset Password With OTP
  Future<void> resetPasswordWithOTP(String newPassword) async {
    try {
      isResettingPassword1.value = true;
      await supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
      CustomSnackBars.instance.showSuccessSnackbar(
        title: "Password Reset",
        message: "Password reset successful. Please login with your new password.",
      );

      otpCtrlr.clear();
      // newPasswordCtrlr.clear();
      // confirmNewPasswordCtrlr.clear();
      // resetEmail.clear();
      Get.offAll(LoginScreen());
    } catch (e) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Reset Failed",
        message: "Failed to reset password. Please try again.",
      );
    } finally {
      isResettingPassword1.value = false;
    }
  }

  // Change password (when user is logged in)
  Future<void> changePassword(String currentPassword, String newPassword) async {
    // Check network connectivity
    final networkStatus = await NetworkConnectivity.instance.getNetworkStatus();
    if (networkStatus == NetworkStatus.offline) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Change Password",
        message: "Network Problem. Please check your connection",
      );
      return;
    }

    try {
      isChangingPassword.value = true;

      // First verify current password
      final user = supabase.auth.currentUser;
      if (user == null) throw Exception('No user logged in');

      // Attempt to sign in with current password to verify it
      await supabase.auth.signInWithPassword(
        email: user.email!,
        password: currentPassword,
      );

      // Update to new password
      await supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );

      CustomSnackBars.instance.showSuccessSnackbar(
        title: "Change Password",
        message: "Password updated successfully",
      );
      newPasswordCtrlr.clear();
      confirmNewPasswordCtrlr.clear();

      // Optionally logout user
      await logout();
    } on AuthException catch (e) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Change Failed",
        message: e.message,
      );
    } catch (e) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Change Failed",
        message: "Failed to change password. Please try again.",
      );
    } finally {
      isChangingPassword.value = false;
    }
  }


}*/
