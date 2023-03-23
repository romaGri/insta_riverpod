enum LottieAnimation {
  loading(name: 'loading'),
  noDataFound(name: 'no_data_found'),
  empty(name: 'empty'),
  error(name: 'error'),
  smallError(name: 'small_error');

  final String name;
  const LottieAnimation({required this.name});
}
