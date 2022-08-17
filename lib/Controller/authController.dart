import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // var displayName = '';
  var loading = false.obs;
  // FirebaseAuth auth = FirebaseAuth.instance;
  var FirebaseFirestore;
  // var isSignedIn = false.obs;
  var phonebook = [].obs;
  // late CollectionReference collectionReference;
  // User? get userProfile => auth.currentUser;

  @override
  void onInit() {
    get_data();
    super.onInit();
  }

  // Future getData(String collection) async {
  //   var datadoc = await FirebaseFirestore.instance.collection(collection).get();
  //   return datadoc.docs;
  // }

  // signUp(String name, String email, String password) async {
  //   try {
  //     await auth
  //         .createUserWithEmailAndPassword(
  //             email: email.trim(), password: password)
  //         .then((value) {
  //       auth.currentUser!.updateDisplayName(name);
  //     });
  //     // final User? user = auth.currentUser;
  //     // final _uid = user?.uid;
  //     // FirebaseFirestore.instance.collection('phonebookData').doc(_uid).set({
  //     //   'userName': nameEditingController.text,
  //     //   'phone': phoneEditingController.text,
  //     //   'email': emailEditingController.text,
  //     //   'designation': designationEditingController.text,
  //     //   'address': addressEditingController.text,
  //     //   'description': descriptionEditingController.text,
  //     // });
  //     update();
  //     // Get.to(() => LoginScreen());
  //   } on FirebaseAuthException catch (e) {
  //     String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;
  //     String message = '';
  //
  //     if (e.code == 'weak-password') {
  //       message = 'The password provided is too weak.';
  //     } else if (e.code == 'email-already-in-use') {
  //       message = ('The account already exists for that email.');
  //     } else {
  //       message = e.message.toString();
  //     }
  //
  //     Get.snackbar(
  //       title, message,
  //       snackPosition: SnackPosition.BOTTOM,
  //       // backgroundColor: Colo,
  //       // colorText: kBackgroundColor
  //     );
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error occured!', e.toString(),
  //       snackPosition: SnackPosition.BOTTOM,
  //       // backgroundColor: kPrimaryColor,
  //       // colorText: kBackgroundColor
  //     );
  //   }
  // }

  // signIn(String email, String password) async {
  //   try {
  //     await auth.signInWithEmailAndPassword(email: email, password: password);
  //
  //     update();
  //     // Get.offAll(() => AdminScreen());
  //   } on FirebaseAuthException catch (e) {
  //     String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;
  //
  //     String message = '';
  //
  //     if (e.code == 'wrong-password') {
  //       message = 'Invalid Password. Please try again!';
  //     } else if (e.code == 'user-not-found') {
  //       message =
  //           ('The account does not exists for $email. Create your account by signing up.');
  //     } else {
  //       message = e.message.toString();
  //     }
  //
  //     Get.snackbar(
  //       title, message,
  //       snackPosition: SnackPosition.BOTTOM,
  //       // backgroundColor: kPrimaryColor,
  //       // colorText: kBackgroundColor
  //     );
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error occured!',
  //       e.toString(),
  //       snackPosition: SnackPosition.BOTTOM,
  //       // backgroundColor: kPrimaryColor,
  //       // colorText: kBackgroundColor,
  //     );
  //   }
  // }

  get_data() async {
    // loading(true);
    update();
    final res =
        await FirebaseFirestore.instance.collection("phonebookData").get();
    print("here is the data ${res}");
    phonebook(res.docs);
    loading(false);
    update();
  }

  // PhoneVerification(String phoneNumber) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   auth.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     verificationCompleted: (phoneAuthCredential) async {},
  //     verificationFailed: (verificationFailed) async {},
  //     codeSent: (verificationId, resendingToken) async {},
  //     codeAutoRetrievalTimeout: (verificationId) async {},
  //   );
  // }
  //
  // phoneVerification() async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: '+44 7123 123 456',
  //     verificationCompleted: (PhoneAuthCredential credential) {},
  //     verificationFailed: (FirebaseAuthException e) {},
  //     codeSent: (String verificationId, int? resendToken) {},
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //   );
  // }
  //
  // resetPassword(String email) async {
  //   try {
  //     await auth.sendPasswordResetEmail(email: email);
  //     AlertDialog(
  //       title: Text("Kindly chechk your given email for reset your password"),
  //     );
  //     // Get.to(SuccessfullRegister(),
  //     //     transition: Transition.leftToRight,
  //     //     duration: Duration(microseconds: 100000));
  //     // Get.back();
  //   } on FirebaseAuthException catch (e) {
  //     String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;
  //
  //     String message = '';
  //
  //     if (e.code == 'user-not-found') {
  //       message =
  //           ('The account does not exists for $email. Create your account by signing up.');
  //     } else {
  //       message = e.message.toString();
  //     }
  //
  //     Get.snackbar(
  //       title, message,
  //       snackPosition: SnackPosition.BOTTOM,
  //       // backgroundColor: kPrimaryColor,
  //       // colorText: kBackgroundColor
  //     );
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error occured!', e.toString(),
  //       snackPosition: SnackPosition.BOTTOM,
  //       // backgroundColor: kPrimaryColor,
  //       // colorText: kBackgroundColor
  //     );
  //   }
  // }
  //
  // signout() async {
  //   try {
  //     await auth.signOut();
  //     // await _googleSignIn.signOut();
  //     isSignedIn.value = false;
  //     update();
  //     Get.offAll(() => SelectionScreen());
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error occured!', e.toString(),
  //       snackPosition: SnackPosition.BOTTOM,
  //       // backgroundColor: kPrimaryColor,
  //       // colorText: kBackgroundColor
  //     );
  //   }
  // }
}

Stream<QuerySnapshot<Object?>>? pendingDataSnapshot =
    FirebaseFirestore.instance.collection("phonebookData").snapshots();

final TextEditingController nameEditingController = TextEditingController();
final TextEditingController emailEditingController = TextEditingController();
final TextEditingController phoneEditingController = TextEditingController();
final TextEditingController descriptionEditingController =
    TextEditingController();
final TextEditingController addressEditingController = TextEditingController();
final TextEditingController designationEditingController =
    TextEditingController();

final TextEditingController passwordEditingController = TextEditingController();
String email = emailEditingController.text.trim();
String password = passwordEditingController.text.trim();
String name = nameEditingController.text;

// // to capitalize first letter of a Sting
// extension StringExtension on String {
//   String capitalizeString() {
//     return "${this[0].toUpperCase()}${this.substring(1)}";
//   }
// }
