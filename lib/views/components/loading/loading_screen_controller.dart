class LoadingScreenController {
  final bool Function() close;
  final bool Function(String text) update;

  const LoadingScreenController({
    required this.close,
    required this.update,
  });
}
