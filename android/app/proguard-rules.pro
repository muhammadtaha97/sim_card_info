# R8 keep rules for the release build.
#
# Every rule here exists because something in this app is reached by
# reflection or by class name at runtime, which R8's static analysis cannot
# see. If a rule can be removed, it has to be removed with a release build and
# a pass on a real device, not by reading this file.

# --- Room, via androidx.work, via the Google Mobile Ads SDK ----------------
#
# Room loads its generated database implementation by name
# (Room.getGeneratedImplementation -> Class.forName on "<DatabaseName>_Impl"),
# so R8 sees WorkDatabase_Impl as unreachable and strips it. Two sibling apps
# crashed on launch from exactly this the moment anything pulled androidx.work
# into the build — and the ads SDK does.
-keep class * extends androidx.room.RoomDatabase { *; }
-keep class **_Impl { <init>(...); *; }
-keep @androidx.room.Entity class * { *; }
-dontwarn androidx.room.paging.**

# --- AdMob and Meta Audience Network mediation ----------------------------
#
# Mediation adapters are instantiated by class name from the ad response, so
# nothing in the app references FacebookMediationAdapter directly — the string
# only ever appears in AdMob's own config.
-keep class com.google.ads.mediation.** { *; }
-keep class com.facebook.ads.** { *; }
-dontwarn com.facebook.ads.**
-keep class com.facebook.infer.annotation.** { *; }
-dontwarn com.facebook.infer.annotation.**

# --- UMP consent SDK ------------------------------------------------------
#
# The form is rendered by the SDK's own web/native views, reached reflectively.
-keep class com.google.android.ump.** { *; }
-dontwarn com.google.android.ump.**

# --- Crash reporting readability ------------------------------------------
#
# Keeps file and line info so a Play-vitals stack trace points at real code.
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception
