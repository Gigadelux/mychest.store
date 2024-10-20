import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mychest/data/models/Banner.dart';
import 'package:mychest/data/responseFormat/ObjectRequest.dart';
import 'package:mychest/presentation/state_manager/providers/appProviders.dart';
import 'package:mychest/presentation/widgets/universal/RequestWidgetTree.dart';

class Bannerwidget extends ConsumerStatefulWidget {
  const Bannerwidget({super.key});

  @override
  ConsumerState<Bannerwidget> createState() => _BannerwidgetConsumerState();
}

class _BannerwidgetConsumerState extends ConsumerState<Bannerwidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_)async{
        await ref.read(BannerStateNotifierProvider.notifier).initialize();
        setState(() {});
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return RequestWidgetTree(
      loadingWidget: const Text('loading', style: TextStyle(color: Colors.white),), 
      widget: Image.network(
        (ref.watch(BannerStateNotifierProvider).getObject).getImage, 
        width: MediaQuery.of(context).size.width,
        errorBuilder: (context, error, stackTrace) => Text('error loading image ${error.toString()}', style: const TextStyle(color: Colors.white),),
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Center(
              child: LinearProgressIndicator(
              value: 
                loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
              ),
            );
          }
        },
      ),
      containerSize: Size(MediaQuery.of(context).size.width, 500), 
      responsecodeTextSize: 30, 
      errorTextSize: 25,
      responseCode: ref.watch(BannerStateNotifierProvider).getStatusCode,
      responseMessage: ref.watch(BannerStateNotifierProvider).getErrorMessage,
    );
  }
}