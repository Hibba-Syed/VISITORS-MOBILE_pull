# Keep ML Kit text recognition core classes
-keep class com.google.mlkit.vision.text.TextRecognizer { *; }
-keep class com.google.mlkit.vision.text.latin.** { *; }

# Optional: Keep any other internal ML Kit classes related to text
-keep class com.google.mlkit.vision.text.** { *; }

# Prevent warnings from unused language-specific recognizers
-dontwarn com.google.mlkit.vision.text.chinese.**
-dontwarn com.google.mlkit.vision.text.japanese.**
-dontwarn com.google.mlkit.vision.text.korean.**
-dontwarn com.google.mlkit.vision.text.devanagari.**
