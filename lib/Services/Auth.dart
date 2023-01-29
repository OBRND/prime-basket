import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:primebasket/Services/Database.dart';
import 'package:primebasket/Services/User.dart';

// import 'package:van_lines/screens/Home/Navigation_Pages/Profile.dart';
// import 'package:van_lines/services/Database.dart';

class Auth_service {

  final FirebaseAuth _auth = FirebaseAuth.instance;
// create a user object based on the firebase user
  UserFB? userFromFirebase(User? user){
    return user != null ? UserFB(uid: user.uid) : null;
  }

  //auth change of user stream
  Stream<UserFB?> get Userx{
    return _auth.authStateChanges().map(userFromFirebase);
  }

  final googlesignin = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;


  Future googleLogin() async{
    try {
      final googleuser = await googlesignin.signIn();
      if (googleuser == null) return;
      _user = googleuser;

      final googleAuth = await googleuser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = result.user;
      return userFromFirebase(user);
    } catch(e){
      print(e.toString());
      return null;
    }

    // notifyListeners();
  }

  Future registerWEP(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      print(user?.uid);
      //create a new document for the user with uid
      await DatabaseService(uid: user!.uid).createuserdata(email);
      // ProfileState().user(user!.uid);
      // DatabaseService(uid:user!.uid).getuserInfo(user!.uid);
      return userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password

  Future Signin_WEP(email, password) async {
    try {
      // await Firebase.initializeApp();
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      // DatabaseService(uid:user!.uid).getuserInfo();
      // print(DatabaseService(uid:user!.uid).getuserInfo(user!.uid));
      // ProfileState().user(user!.uid);
      print(user);
      return userFromFirebase(user);

      //create a new document for the user with uid
      // await databaseservice(uid: user!.uid).updateUserData('0', 'new_member', 100);
      // return _userfromfirebaseuser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future sign_out() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}
