class Logger {
  static d(String tag, String msg) {
    print(' --------------------------------------------------');
    print('| ${new DateTime.now()} D/$tag: $msg');
    print(' --------------------------------------------------');
  }
}
