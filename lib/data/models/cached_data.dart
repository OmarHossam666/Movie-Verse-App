class CachedData<T> {
  CachedData({required this.data, required this.timeStamp});

  final T data;
  final DateTime timeStamp;
}
