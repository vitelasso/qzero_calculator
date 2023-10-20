import 'package:get/get.dart';
import 'package:kw_calculator/pages/calculation_result.dart';
import 'package:kw_calculator/pages/dashboard.dart';
import 'package:kw_calculator/pages/division_calculation.dart';
import 'package:kw_calculator/pages/macro_creation.dart';

appRoutes() => [
      GetPage(
        name: '/dashboard',
        page: () => const DashboardPage(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/macroCreation',
        page: () => const MacroCreationPage(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/kwCalc',
        page: () => KwCalc(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
        name: '/calculationResult',
        page: () => const CalculationResultPage(),
        middlewares: [MyMiddelware()],
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(milliseconds: 500),
      ),
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print(page?.name);
    return super.onPageCalled(page);
  }
}
