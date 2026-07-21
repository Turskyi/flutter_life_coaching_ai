# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /opt/hostedtoolcache/flutter/3.44.6-stable/x64/packages/flutter_tools/gradle/proguard-android.txt
# You can edit the include path and session by modifying the proguardFiles
# line in /Users/dmytro/development/multiplatform/Flutter/personal/production_projects/lifecoach/android/app/build.gradle.
#
# For more details, see
# http://developer.android.com/guide/developing/tools/proguard.html

# Flutter-specific ProGuard rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.embedding.**
