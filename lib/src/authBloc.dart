import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/userModel.dart';
//import '../services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

final RegExp regExpEmail = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

class AuthBloc {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _Appuser = BehaviorSubject<User>();
  final _errorMessage = BehaviorSubject<String>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
 // final FirestoreService _firestoreService = FirestoreService();

  //Get Data
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get isValid => CombineLatestStream.combine2(email, password, (email,password)=> true);
  Stream<AppUser> get user => _Appuser.stream;
  Stream<String> get errorMessage => _errorMessage.stream;
  String get userId => _user.value.userId;

  //Set Data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  dispose(){
    _email.close();
    _password.close();
    _Appuser.close();
    _errorMessage.close();
  }
  //FirebaseService
    Firestore _db = Firestore.instance;

  Future<void> addUser(AppUser user) {
    return _db.collection('users').document(user.userId).setData(user.toMap());
  }

  Future<User> fetchUser(String userId) {
    return _db
        .collection('users')
        .document(userId)
        .get()
        .then((snapshot) => User.fromFirestore(snapshot.data));
  }
  //Transformers
  final validateEmail = StreamTransformer<String,String>.fromHandlers(handleData: (email, sink){
    if (regExpEmail.hasMatch(email.trim())){
      sink.add(email.trim());
    }else {
      sink.addError('Must Be Valid Email Address');
    }
  });

    final validatePassword = StreamTransformer<String,String>.fromHandlers(handleData: (password, sink){
    if (password.length >= 8){
      sink.add(password.trim());
    }else {
      sink.addError('8 Character Minimum');
    }
  });

  //Functions
  signupEmail() async{
    try{
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(email: _email.value.trim(), password: _password.value.trim());
      var user = User(userId: authResult.user.uid, email: _email.value.trim());
      await addUser(user);
      _user.sink.add(user);
    } on PlatformException catch (error){
      print(error);
      _errorMessage.sink.add(error.message);
    }
  }



    loginEmail() async{
    try{
      AuthResult authResult = await _auth.signInWithEmailAndPassword(email: _email.value.trim(), password: _password.value.trim());
      var user = await fetchUser(authResult.user.uid);
      _user.sink.add(user);
    } on PlatformException catch (error){
      print(error);
      _errorMessage.sink.add(error.message);
    }
  }

  Future<bool> isLoggedIn() async {
    var firebaseUser = await _auth.currentUser();
    if (firebaseUser == null) return false;

    var user = await fetchUser(firebaseUser.uid);
    if (user == null) return false;

    _user.sink.add(user);
    return true;
  }

  logout() async {
    await _auth.signOut();
    _user.sink.add(null);
  }

  clearErrorMessage(){
    _errorMessage.sink.add('');
  }

}
