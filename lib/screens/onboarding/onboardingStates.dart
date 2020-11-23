import 'package:easyGroceries/appStates.dart';
import 'package:easyGroceries/screens/onboarding/consts.dart';
import 'package:get/get.dart';

class OnboardingStates extends GetxController {
  static OnboardingStates get to => Get.find();

  final AppStates appStates = Get.put(AppStates());

  setOnboardingStep(value) {
    if (value == onboardingSlide.length)
      appStates.setIsOnboardingDone(true);
    else
      onboardingStep.value = value;
  }

  RxInt onboardingStep = 0.obs;
}
