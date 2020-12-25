import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spec_app/main.dart';
class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final GoogleSignIn googleSignIn=GoogleSignIn();
  final Firestore _db=Firestore.instance;

  Observable<FirebaseUser> u;
  Observable<Map<String,dynamic>>profile;
  PublishSubject loading=PublishSubject();

  // constructor
  AuthService(){
        u=Observable(_auth.onAuthStateChanged);
        profile=u.switchMap((FirebaseUser u) {
          if(u!=null)
           { return _db.collection('users').document(u.uid).snapshots().map(
                (snap)=>snap.data);
           }else{
            return Observable.just({});
          }
        });
  }

  Future<FirebaseUser> signInWithGoogle() async{
    loading.add(true);
      final GoogleSignInAccount googleSignInAccount=await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication=await
          googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken:googleSignInAuthentication.idToken);
      final AuthResult authResult = await _auth.signInWithCredential(credential);

      final FirebaseUser user = authResult.user;
      updateUserData(user);
      loading.add(false);
      //print("signed in.................... "+ user.displayName);
      return user;

  }

  void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('IsLoggedIn',true);
    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);

  }

  void signOutGoogle() async{
    await googleSignIn.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('IsLoggedIn',false);
    print("User Sign Out");
  }

  Future<int>SignIn(email,password) async
  {
    try{
      AuthResult result = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      user=result.user;
      return 0;
    }
    catch(error) {
      switch(error.code)
      {
        case "ERROR_USER_NOT_FOUND":
          return -1;
          break;
        case "ERROR_WRONG_PASSWORD":
            return 1;
            break;
      }
    }
  }
    }