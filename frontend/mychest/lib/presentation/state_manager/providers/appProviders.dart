import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mychest/data/models/profile.dart';
import 'package:mychest/presentation/state_manager/ProfileStateNotifier.dart';
import 'package:mychest/presentation/state_manager/TokenNotifier.dart';

final ProfileNotifierProvider = StateNotifierProvider<ProfileNotifier, Profile>((ref) => ProfileNotifier());
final TokenNotifierProvider = StateNotifierProvider<TokenNotifier, String?>((ref)=>TokenNotifier());