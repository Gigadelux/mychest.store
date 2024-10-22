import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mychest/data/models/Banner.dart';
import 'package:mychest/data/models/Cart.dart';
import 'package:mychest/data/models/profile.dart';
import 'package:mychest/data/responseFormat/ObjectRequest.dart';
import 'package:mychest/presentation/state_manager/BannerStateNotifier.dart';
import 'package:mychest/presentation/state_manager/CartStateNotifier.dart';
import 'package:mychest/presentation/state_manager/ProfileStateNotifier.dart';
import 'package:mychest/presentation/state_manager/TokenNotifier.dart';

final ProfileNotifierProvider = StateNotifierProvider<ProfileNotifier, Profile>((ref) => ProfileNotifier());
final TokenNotifierProvider = StateNotifierProvider<TokenNotifier, String?>((ref)=>TokenNotifier());
final BannerStateNotifierProvider = StateNotifierProvider<BannerStatenotifier,ObjectRequest<BannerOffer>>((ref)=>BannerStatenotifier());
final CartNotifierProvider = StateNotifierProvider<Cartstatenotifier, ObjectRequest<Cart>>((ref)=>Cartstatenotifier());