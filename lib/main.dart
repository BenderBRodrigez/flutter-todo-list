import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CachedQuery.instance.configFlutter(
    config: QueryConfigFlutter(
      refetchOnResume: true,
      refetchOnConnection: true,
    ),
  );

  runApp(const App());
}
