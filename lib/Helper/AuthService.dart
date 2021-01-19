import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spec_app/main.dart';
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final Firestore _db = Firestore.instance;

  Observable<FirebaseUser> u;
  Observable<Map<String, dynamic>>profile;
  PublishSubject loading = PublishSubject();

  // constructor
  AuthService() {
    u = Observable(_auth.onAuthStateChanged);
    profile = u.switchMap((FirebaseUser u) {
      if (u != null) {
        return _db.collection('users').document(u.uid).snapshots().map((
            snap) => snap.data);
      }
      else {
        return Observable.just({});
      }
    });
  }
  @deprecated
  Future<FirebaseUser> signInWithGoogle() async {
    loading.add(true);
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await
    googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);
    final AuthResult authResult = await _auth.signInWithCredential(credential);

    final FirebaseUser user = authResult.user;
    updateUserData(user);
    loading.add(false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('IsLoggedInGoogle', true);
    prefs.setBool('IsLoggedInFirebase', false);
    return user;
  }
  @deprecated
  void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('IsLoggedIn', true);
    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
  }
 @deprecated
  void signOutGoogle() async {
    await googleSignIn.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('IsLoggedIn', false);
    print("User Sign Out");
  }

  Future<FirebaseUser> SignUp(name, surname, email, password, image,notCR,year,branch,rollno) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    UserUpdateInfo info = UserUpdateInfo();
    info.displayName = name + " " + surname;
    String image_url="";
    if (image != null) {
      StorageReference ref = FirebaseStorage().ref().child(
          '${info.displayName}/profileImage');
      StorageUploadTask uploadTask = ref.putFile(image);
      StorageTaskSnapshot snapshot = await uploadTask.onComplete;
      image_url = await snapshot.ref.getDownloadURL();
    }
    info.photoUrl = image_url;
    await result.user.updateProfile(info);

    FirebaseUser u = result.user;
    if (u != null) {
      _db.collection('users').document(u.uid).setData(
          {
            'uid': u.uid,
            'lastSeen': DateTime.now(),
            'photoURL': image_url,
            'email': email,
            'displayName': name + " " + surname,
            'notCR':notCR,
            'year':year,
            'branch':branch,
            'roll':rollno
          }, merge: true);
      await u.reload();
      u = await _auth.currentUser();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('IsLoggedInFirebase' , true);
      return u;
    }
  }

  Future<FirebaseUser> SignIn({email, password}) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (email == null && password == null) {
      FirebaseUser u = await _auth.currentUser();
      if (u != null)
        {
          await _db.collection('users').document(u.uid).get().then((value){
            notCR=value['notCR'];
            year=value['year'];
            branch=value['branch'];
            rollno=value['roll'];
          });
        return u;}
    }
    try {
      AuthResult result = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      user = result.user;
      prefs.setBool('IsLoggedInFirebase', true);
      await _db.collection('users').document(user.uid).get().then((value){
        notCR=value['notCR'];
        year=value['year'];
        branch=value['branch'];
        rollno=value['roll'];
      });
      return user;
    }
    catch (error) {
      return null;
    }
  }
}