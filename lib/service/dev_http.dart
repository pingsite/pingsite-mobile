import 'dart:io';

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    // host == 'dev.pingsite.io';
  }
}

HttpClient getHttpClient() {
  HttpClient client = HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  return client;
}
