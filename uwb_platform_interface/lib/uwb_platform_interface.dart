library uwb_platform_interface;

//contains all de api calls defined by name. Sends request to method channel
// check the url launcher app for example code.

/// A Calculator.
abstract class UwbPlatform {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}




