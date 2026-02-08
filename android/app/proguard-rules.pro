# Keep rules for Flutter plugins / common libraries.
# Flutter already ships with a default set of keep rules; this file is for app-specific additions.

# --- Firebase / Google Play Services ---
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

# If you use Gson/Json reflection in your models (adjust packages as needed):
# -keepclassmembers class your.package.model.** { <fields>; }

# --- FlutterLocalNotifications / AwesomeNotifications (often use reflection) ---
-dontwarn me.carda.awesome_notifications.**
-dontwarn com.dexterous.**

# --- Kotlin metadata ---
-keep class kotlin.Metadata { *; }

# If you face runtime crashes after enabling minify, add targeted keep rules based on the stacktrace.

