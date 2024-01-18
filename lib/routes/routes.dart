import 'package:get/get.dart';
import 'package:kw_calculator/modules/dashboard/dashboard_binding.dart';
import 'package:kw_calculator/modules/dashboard/dashboard_view.dart';
import 'package:kw_calculator/modules/house_divisions/house_divisions_binding.dart';
import 'package:kw_calculator/modules/house_divisions/house_divisions_view.dart';
import 'package:kw_calculator/pages/macro_creation.dart';

appRoutes() => [
      GetPage(
        name: '/dashboard',
        page: () => const DashboardView(),
        binding: DashboardBinding(),
        //transition: Transition.leftToRightWithFade,
      ),
      GetPage(
        name: '/house_division',
        page: () => const HouseDivisionsView(),
        binding: HouseDivisionBinding(),
        //transition: Transition.leftToRightWithFade,
      ),
      GetPage(
        name: '/macroCreation',
        page: () => const MacroCreationPage(),
        //transition: Transition.leftToRightWithFade,
      ),
    ];
