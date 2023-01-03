import 'package:browser/screen/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Homeprovider? homeprovidertrue;
  Homeprovider? homeproviderfalse;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  InAppWebViewController? inAppWebViewController;



  @override
  Widget build(BuildContext context) {

    homeprovidertrue = Provider.of<Homeprovider>(context,listen: true);
    homeproviderfalse = Provider.of<Homeprovider>(context,listen: false);

    return SafeArea(child: Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse("https://www.google.co.in/")),
        onLoadStart: (controller,uri){
          inAppWebViewController = controller;
          homeproviderfalse!.changeNewUrl(uri.toString());
        },
        onLoadStop: (controller,uri){
          inAppWebViewController = controller;
          homeproviderfalse!.changeNewUrl(uri.toString());
        },
        onLoadError: (controller,uri,code,message){
          inAppWebViewController = controller;
          homeproviderfalse!.changeNewUrl(uri.toString());
        },
        onProgressChanged: (controller,progress){},

        androidOnPermissionRequest: (contoller,_,resources)async{
          return PermissionRequestResponse(
            resources: resources,
            action: PermissionRequestResponseAction.GRANT
          );
        },
        initialOptions: options,
      ),
    ));
  }
}
