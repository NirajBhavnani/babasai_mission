//Shared Preferences for maintaining users in firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Babasai
{
  static const String appName = 'babasai_mission';

  static SharedPreferences sharedPreferences;
  static FirebaseUser user;
  static FirebaseAuth auth;
  static Firestore firestore ;

  static final String userName = 'name';
  static final String userEmail = 'email';
  static final String userPhotoUrl = 'photoUrl';
  static final String userUID = 'uid';
  static final String userAvatarUrl = 'url';


}