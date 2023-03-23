import 'package:insta_riverpod/views/components/animations/lottie_animation_view.dart';
import 'package:insta_riverpod/views/components/animations/models/lottie_animation.dart';

class NoDataFoundAnimationView extends LottieAnimationView {
  const NoDataFoundAnimationView({super.key})
      : super(animation: LottieAnimation.noDataFound);
}
