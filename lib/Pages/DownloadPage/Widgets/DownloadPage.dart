import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/DownLoadController/DownloadController.dart';
import 'package:provider/provider.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({
    super.key,
  });

  @override
  State<DownloadPage> createState() => DownloadPageState();
}

class DownloadPageState extends State<DownloadPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DownLoadController>();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: Screens.bodyheight(context),
      width: Screens.width(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {},
            child: Lottie.asset('assets/20479-settings.json',
                animate: true,
                repeat: true,
                height: Screens.padingHeight(context) * 0.2,
                width: Screens.width(context) * 0.2),
          ),
          SizedBox(
            height: Screens.bodyheight(context) * 0.01,
          ),
          Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Screens.width(context) * 0.3),
              child: LinearPercentIndicator(
                percent: context.watch<DownLoadController>().getpercent,
                progressColor: theme.primaryColor,
              )),
          SizedBox(
            height: Screens.bodyheight(context) * 0.01,
          ),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.3),
            child: Text(
              context.watch<DownLoadController>().loadingMsg,
              style: theme.textTheme.bodyLarge
                  ?.copyWith(color: Colors.black, fontSize: 15),
            ),

            // LinearProgressIndicator(
            //   backgroundColor: Colors.white,
            // )
          )
        ],
      ),
    );
  }
}
