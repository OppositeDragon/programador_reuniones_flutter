enum Zoom {
  min(height: 778),
  midLow(height: 970),
  midHigh(height: 1258),
  max(height: 1642);

  const Zoom({required this.height});
  final double height;
}