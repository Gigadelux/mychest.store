import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mychest/data/models/profile.dart';
import 'package:mychest/data/repositories/profile_repo.dart';

class ProfileNotifier extends StateNotifier<Profile>{
  ProfileNotifier() : super(Profile.empty());
  Future<void> initialize()async{
    state = await ProfileRepo().initializeUser();
  }
}