import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'home_page_stack_ui/home_page.dart';
import 'presentation/pages/0.appbar_features/2_app_bar_icons/settings_page.dart';
import 'presentation/pages/1.app_bar_pomodoro/premium_analytics/cartesian_premium.dart';
import 'presentation/pages/3.chips_blog/avoid_distractions.dart';
import 'presentation/pages/3.chips_blog/pomodoro_technique.dart';
import 'presentation/pages/3.chips_blog/productivity_hacks.dart';
import 'presentation/screens/auth_check_screen.dart';

const String HOME_ROUTE = '/';
const String LOGIN_ROUTE =
    '/login'; // Adjust this if you have a specific login route name.

final loggedOutRoute = RouteMap(
  routes: {
    HOME_ROUTE: (route) => const MaterialPage<void>(child: HomePage()),

    // ?  // * HOME PAGE AFTER LOGIN
    // '/app': (route) =>
    //     const MaterialPage<void>(child: HomePageAfterLogin()),

    // * CHIPS BLOG
    '/learn/productivity-hacks/techniques': (route) =>
        const MaterialPage<void>(child: ProductivityHacks()),
    '/learn/productivity-hacks/avoid-distractions': (route) =>
        const MaterialPage<void>(child: AvoidDistractions()),
    '/learn/the-pomodoro-technique/method': (route) =>
        const MaterialPage<void>(child: PomodoroTechnique()),
    // * SETTINGS ROUTE
    '/pomodoro-technique-settings': (route) =>
        const MaterialPage<void>(child: SettingsPage()),
    // * ANALYTICS ROUTE

    '/time-management-analytics': (route) =>
        const MaterialPage<void>(child: AuthCheckScreen()),
    // * ANALYTICS PREMIUM ROUTE
     '/time-management-analytics/premium': (route) =>
        const MaterialPage<void>(child: CartesianPremiumChart(title: '',)),
  },
);

final loggedInRoute = RouteMap(
  routes: {
    HOME_ROUTE: (route) => const MaterialPage<void>(child: HomePage()),

    // //? * HOME PAGE AFTER LOGIN
    // '/app': (route) =>
    //     const MaterialPage<void>(child: HomePageAfterLogin()),
    // * CHIPS BLOG
    '/learn/productivity-hacks/techniques': (route) =>
        const MaterialPage<void>(child: ProductivityHacks()),
    '/learn/productivity-hacks/avoid-distractions': (route) =>
        const MaterialPage<void>(child: AvoidDistractions()),
    '/learn/the-pomodoro-technique/method': (route) =>
        const MaterialPage<void>(child: PomodoroTechnique()),

    // * SETTINGS ROUTE
    '/pomodoro-technique-settings': (route) =>
        const MaterialPage<void>(child: SettingsPage()),
    // * ANALYTICS ROUTE
    '/time-management-analytics': (route) =>
        const MaterialPage<void>(child: AuthCheckScreen()),
    // * ANALYTICS PREMIUM ROUTE
     '/time-management-analytics/premium': (route) =>
        const MaterialPage<void>(child: CartesianPremiumChart(title: '',)),
  },
);
