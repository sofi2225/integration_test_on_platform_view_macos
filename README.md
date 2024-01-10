# Tests for flutter_inline_webview_macos

Im using a project of [kosei Akaboshi (akaboshinit)](https://github.com/akaboshinit) as an integration_tests_on_platform_view_macos use of AppKitView in macOS. 


# ISSUE
Overview
The problem: interacting with the webview using gestures throws an exception.
The root cause: Rendering native web views on MacOS from Flutter involves loading them into a native platform view (an object that extends the native swift NSView class).
Platform views creation feature for MacOS is still in development stage as of 3rd January, 2023, so there are many methods which are still missing their corresponding implementation, such as support for Gestures.

Platform view for other plaforms like IOS and Andorid is fully implemented, not the case for MacOS. 
That is preventing us to use the same solution across all platforms. 

# Stepts to Repoduce manually: 

1. Run ```flutter run -d macos```

2. Press 'load:"youtube.com"' button and wait for the page to load 

3. Click on any element inside the webview. 
*  Can replace the click gesture with other gestures such as scroll, select text. 

4. Check the console output and check for the following exception: 

``` 
[ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: MissingPluginException(No implementation found for method rejectGesture on channel flutter/platform_views)
#0      MethodChannel._invokeMethod (package:flutter/src/services/platform_channel.dart:320:7)
<asynchronous suspension>
```

## To run the same on IOS 

1. Replace the first step with `flutter run -d ["YourDeviceID"]` and reasume from step 2.
( On this situation you ll se that the behavouur works as expected and no exceptions are thrown )


## To run the tests: 

To run tap test in macos run :  `flutter test integration_test/test_macos.dart -d macos`

To run tap test in ios run : `flutter test integration_test/test_ios.dart -d ["YourDeviceID"]`




## Gestures that are needed to implement, in order of Priority:

### Priority 1: 
## Tap:  
    GIVEN Go to a page in AppKitView (E.g. "https://youtube.com" )
    WHEN Perform a simple mouse click in any tab
    THEN I can perform a click in the tab  
    AND No exceptions are thrown 
    AND the im redirected to correct page

(*) And all other getures are "no op" ("do nothing", "no impact") and do not throw exceptions. 


### Priority 2: 
## Scrolling:  
    GIVEN Go to a page in AppKitView 
    WHEN Scrolling up and down with mouse wheel. 
    THEN Page moves in the correct direction. 
## Select text:  
    GIVEN Go to a page in AppKitView that has text. (E.g "https://en.wikipedia.org/wiki/English_language")
    WHEN Click on a word without link
    AND Drag until more than one word is selected (without lifting click) 
    THEN A menu with options should be displayed. 
           

 ### Priority 3: 
    Right click 
    Zoom in 
    Zoom out 
    Arrow Up
    Arrow Down 
    Scrolling by dragging (Click on the mouse wheekl and drag through the screen)
    Copy (CTRL +C)





