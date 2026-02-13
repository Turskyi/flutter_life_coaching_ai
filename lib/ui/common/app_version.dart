import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersion extends StatefulWidget {
  const AppVersion({super.key});

  @override
  State<AppVersion> createState() => _AppVersionState();
}

class _AppVersionState extends State<AppVersion> {
  final Future<PackageInfo> _packageInfoFuture = PackageInfo.fromPlatform();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: _packageInfoFuture,
      builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
        if (snapshot.hasData) {
          final PackageInfo? packageInfo = snapshot.data;
          if (packageInfo != null) {
            return Center(
              child: Text(
                '${translate('app_version')}: ${packageInfo.version}+'
                '${packageInfo.buildNumber}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}
