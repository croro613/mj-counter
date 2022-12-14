import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mj_counter/provider/all_provider.dart';
import 'package:mj_counter/view/home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupProvider = ref.watch(groupInformationProvider);
    return groupProvider.when(
        data: (group) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) async {
              //初期画面に出てくるグループ
              ref.read(selectedKeyProvider.notifier).state =
                  await ref.read(countProvider.notifier).initialize(group);
            },
          );
          return MaterialApp(
            title: 'MJ counter',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.blue,
            ),
            home: HomePage(),
          );
        },
        error: (err, stack) => Container(
              padding: EdgeInsets.only(top: 50),
              child: Text(
                err.toString(),
                textDirection: TextDirection.ltr,
              ),
            ),
        loading: () => const CircularProgressIndicator());
  }
}
