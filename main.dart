import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:routemaster/routemaster.dart';

import 'infrastructure/data_sources/hive_services.dart';
import 'models/error_model.dart';
import 'presentation/notifiers/providers.dart';
import 'presentation/repository/auth_repository.dart';
import 'router.dart';

late Box box;

final container = ProviderContainer();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final notificationSelectedProvider = StateProvider<String?>((ref) => null);

Future main() async {
  debugPaintSizeEnabled = false;

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await HiveServices.openBox();

  if (html.Notification.supported) {
    bool browserNotificationsEnabled =
        html.Notification.permission == "granted";
    await HiveServices.saveNotificationSwitchState(browserNotificationsEnabled);
  }

  var initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  NotificationAppLaunchDetails? notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    debugPrint('notification payload: ');
  }

  runApp(
    const ProviderScope(
      overrides: [],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState {
  ErrorModel? errorModel;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    errorModel = await ref.read(authRepositoryProvider).getUserData();

    if (errorModel != null && errorModel!.data != null) {
      ref.read(userProvider.notifier).update((state) => errorModel!.data);
    }
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(timerInitProvider);
    ref.watch(soundInitProvider);
    ref.watch(colorInitProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Pomodoro Timer 2024',

      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      themeMode: ref.watch(themeModeProvider),
      routerDelegate: RoutemasterDelegate(routesBuilder: (context) {
        final user = ref.watch(userProvider);

        if (user != null && user.token.isNotEmpty) {
          return loggedInRoute;
        }
        return loggedOutRoute;
      }),
      routeInformationParser: const RoutemasterParser(),

      // home: const HomePage(),
    );
  }
}
