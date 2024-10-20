import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mychest/core/API/BannerAPI.dart';
import 'package:mychest/data/models/Banner.dart';
import 'package:mychest/data/responseFormat/ObjectRequest.dart';

class BannerStatenotifier extends StateNotifier<ObjectRequest<BannerOffer>>{
  BannerStatenotifier():super(ObjectRequest(object: BannerOffer.empty()));
  Future<void> initialize()async{
    Map response = await BannerAPI().getBanner();
    BannerOffer b = BannerOffer.empty();
    print(response['status']);
    if(response['status']==200){
      b.setCategory = response['category'];
      b.setImage = response['image'];
    }
    ObjectRequest<BannerOffer> newState = state;
    newState.setObject = b;
    newState.setStatusCode = response['status'];
    newState.setErrorMessage = response['error'];
    state = newState;
  }
  void destroy(){
    state = ObjectRequest(object: BannerOffer.empty());
  }
}