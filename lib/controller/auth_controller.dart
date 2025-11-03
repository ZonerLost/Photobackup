import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photobackup/services/database_service.dart';
import 'package:photobackup/view/auth/login_page.dart';
import 'package:photobackup/view/auth/welcome_page.dart';
import 'package:photobackup/view/home_page/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../components/network_connectivity.dart';
import '../models/userModel.dart';
import '../services/auth_service.dart';
import '../utils/file_indexes.dart';
import '../view/auth/set_password.dart';
import '../view/auth/sign_up_verification.dart';
import '../view/auth/verification_page.dart';
import '../widgets/auth_widgets/auth_dialogues.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var isVerifying = false.obs;
  var isResettingPassword = false.obs;
  var selectedImage = Rxn<File>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  var selectedImageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadWelcomeStatus();
    loadRememberedStatus();
  }

  var isWelcomeShown = false.obs;
  static const _welcomeKey = 'isWelcomeShown';

  /// Load the stored welcome status from SharedPreferences
  Future<void> loadWelcomeStatus() async {
    final prefs = await SharedPreferences.getInstance();
    isWelcomeShown.value = prefs.getBool(_welcomeKey) ?? false;
  }

  /// Save the welcome status to SharedPreferences
  Future<void> setWelcomeShown(bool value) async {
    isWelcomeShown.value = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_welcomeKey, value);
  }

  RxBool isRemembered = false.obs;
  static const _rememberedKey = 'isRemembered';

  /// loadRemembered
  Future<void> loadRememberedStatus() async {
    final prefs = await SharedPreferences.getInstance();
    isRemembered.value = prefs.getBool(_rememberedKey) ?? false;
  }

  /// setRemembered
  Future<void> setRemembered(bool value) async {
    isRemembered.value = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberedKey, value);
  }

  final ImagePicker _picker = ImagePicker();

  ///Image picker Function
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<void> signUpUser(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result =
          await AuthService.instance.signUp(email: email, password: password);
      if (result != null && result.user != null) {
        final user = result.user!;

        String defaultPic = "https://i.pravatar.cc/150?u=${user.id}";
        String imageUrl;
        if (selectedImage.value != null) {
          final file = selectedImage.value!;
          final filePath =
              'profile_images/${user.id}_${DateTime.now().millisecondsSinceEpoch}.jpg';
          final response = await Supabase.instance.client.storage
              .from('profile_images')
              .upload(filePath, file);

          if (response.isEmpty) {
            Get.snackbar("Error", "Image upload failed");
            imageUrl = defaultPic;
          } else {
            final publicUrl = Supabase.instance.client.storage
                .from('profile_images')
                .getPublicUrl(filePath);
            imageUrl = publicUrl;
          }
        } else {
          imageUrl = defaultPic;
        }

        print("User Model${user.id}");
        print("User Model${user.email}");
        print("User Model ${nameController.text}");
        print("User Model image $imageUrl");

        final userModel = UserModel(
          userId: user.id,
          name: nameController.text,
          email: user.email.toString(),
          profilePic: imageUrl,
        );

        await DatabaseService.instance.storeUser(userModel);
        setWelcomeShown(true);
        Get.snackbar("Success", "Account created successfully!");
        Get.to(() => SignUpVerification(email: email));
      } else {
        errorMessage.value = "Sign up failed";
        Get.snackbar("Error", "Sign up failed");
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Login User
  Future<void> loginUser(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result =
        await AuthService.instance.login(email: email, password: password);

    if (result == null) {
      setWelcomeShown(true);
      Get.snackbar("Success", "Logged in successfully!");
      Get.off(() => HomePage());
    } else {
      errorMessage.value = result;
      Get.snackbar("Error", result);
    }
    isLoading.value = false;
  }

  /// Logout User
  Future<void> logoutUser() async {
    try {
      await AuthService.instance.logout(); // call your service
      setRemembered(false);
      Get.offAll(() => LoginPage()); // go back to login screen
    } catch (e) {
      Get.snackbar("Error", "Failed to log out: $e");
    }
  }

  ///SignupVerifyOtp
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

      final response =
          await AuthService.instance.verifyOTP(email: email, otp: otp);

      if (response?.user != null) {
        CustomSnackBars.instance.showSuccessSnackbar(
          title: "Verification",
          message: "Email verified successfully!",
        );
        Get.off(() => LoginPage());
      }
    } catch (e) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Verification Failed",
        message: e.toString(),
      );
    } finally {
      isVerifying.value = false;
    }
  }

  ///ForgetPassword
  Future<void> forgotPassword(String email) async {
    try {
      if (email.isEmpty) {
        CustomSnackBars.instance.showFailureSnackbar(
          title: "Password Reset",
          message: "Please enter a valid email address",
        );
        return;
      }

      final networkStatus =
          await NetworkConnectivity.instance.getNetworkStatus();
      if (networkStatus == NetworkStatus.offline) {
        CustomSnackBars.instance.showFailureSnackbar(
          title: "Password Reset",
          message: "Network problem. Please check your connection",
        );
        return;
      }

      await AuthService.instance.sendPasswordResetEmail(email: email);

      CustomSnackBars.instance.showSuccessSnackbar(
        title: "Password Reset",
        message: "Password reset OTP has been sent to your email",
      );

      Get.to(() => VerificationPage(
            email: email,
          ));
      //Get.to(() => ForgetOtpVerification(email: email));
    } catch (e) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Reset Failed",
        message: e.toString(),
      );
    }
  }

  ///ForgetPasswordOtpVerify
  Future<void> verifyResetWithOTP(String email, String otp) async {
    try {
      if (email.isEmpty || otp.isEmpty) {
        CustomSnackBars.instance.showFailureSnackbar(
          title: "Verification",
          message: "Email and OTP are required",
        );
        return;
      }

      isResettingPassword.value = true;

      final response =
          await AuthService.instance.verifyResetWithOTP(email, otp);

      if (response != null && response.user != null) {
        CustomSnackBars.instance.showSuccessSnackbar(
          title: "Verification",
          message: "Email verified successfully!",
        );

        Get.to(() => SetPassword());
      } else {
        CustomSnackBars.instance.showFailureSnackbar(
          title: "Verification Failed",
          message: "Invalid OTP. Please try again.",
        );
      }
    } catch (e) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Reset Failed",
        message: e.toString(),
      );
    } finally {
      isResettingPassword.value = false;
    }
  }

  ///UpdatePassword
  Future<void> updatePassword({
    required BuildContext context,
    String? currentPassword,
    required String newPassword,
    bool isResetFlow = false,
  }) async {
    try {
      final networkStatus =
          await NetworkConnectivity.instance.getNetworkStatus();
      if (networkStatus == NetworkStatus.offline) {
        CustomSnackBars.instance.showFailureSnackbar(
          title: "Password Update",
          message: "Network Problem. Please check your connection",
        );
        return;
      }

      if (newPassword.isEmpty) {
        CustomSnackBars.instance.showFailureSnackbar(
          title: "Password Update",
          message: "New password cannot be empty",
        );
        return;
      }

      if (!isResetFlow) {
        final user = AuthService.instance.currentUser;
        if (user == null) throw Exception("No user logged in");

        if (currentPassword == null || currentPassword.isEmpty) {
          throw Exception("Current password is required");
        }

        await AuthService.instance.login(
          email: user.email!,
          password: currentPassword,
        );
      }

      await AuthService.instance.updateUserPassword(newPassword);

      CustomSnackBars.instance.showSuccessSnackbar(
        title: "Password Update",
        message: isResetFlow
            ? "Password reset successful. Please login with your new password."
            : "Password changed successfully",
      );

      if (isResetFlow) {
        AuthDialogues.successDialog(context);
      } else {
        await AuthService.instance.logout();
      }
    } on AuthException catch (e) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Password Update Failed",
        message: e.message,
      );
    } catch (e) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Password Update Failed",
        message: e.toString(),
      );
    }
  }

  ///Login With Google
  Future<void> loginWithGoogle() async {
    //isLoading.value = true;
    errorMessage.value = '';

    final result = await AuthService.instance.googleSignIn();
    print("result $result");

    if (result.user != null) {
      final user = result.user!;
      final userModel = UserModel(
        userId: user.id,
        name: user.userMetadata!["full_name"] ?? '',
        email: user.email ?? '',
        profilePic: user.userMetadata!["picture"] ?? '',
      );

      await DatabaseService.instance.storeUser(userModel);

      setWelcomeShown(true);
      setRemembered(true);
      Get.snackbar("Success", "Logged in with Google!");
      Get.off(() => HomePage());
    } else {
      errorMessage.value = result.toString();
      Get.snackbar("Error", result.toString());
    }

    //isLoading.value = false;
  }

  /// ------------------ DELETE USER ACCOUNT ------------------
  Future<void> handleDeleteUserAccount() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final user = AuthService.instance.currentUser;
      if (user == null) throw Exception("No logged-in user found.");

      // Step 1: Delete user data from your 'users' table
      await AuthService.instance.supabase
          .from('users')
          .delete()
          .eq('user_id', user.id);

      // Step 2: Delete the auth account
      final result = await AuthService.instance.deleteUserAccount();

      if (result == null) {
        Get.snackbar("Success", "Account deleted successfully!");
        setRemembered(false);
        Get.offAll(() => LoginPage());
      } else {
        errorMessage.value = result;
        Get.snackbar("Error", result);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> getCurrentUserProfile() async {
    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;

      if (user == null) {
        Get.snackbar("Error", "No user found");
        return;
      }

      final email = user.email ?? '';
      final imagePath = user.userMetadata?['image'] as String?; // stored file path in metadata

      String imageUrl;

      if (imagePath != null && imagePath.isNotEmpty) {
        imageUrl = supabase.storage.from('profile_images').getPublicUrl(imagePath);
      } else {
        imageUrl = "https://i.pravatar.cc/150?u=${user.id}";
      }
      emailController.text = email;
      selectedImageUrl.value = imageUrl;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }





}
