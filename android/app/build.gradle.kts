import java.util.Base64

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

fun dartDefineValue(key: String): String? {
    val dartDefines = providers.gradleProperty("dart-defines").orNull ?: return null
    return dartDefines
        .split(",")
        .mapNotNull { encoded ->
            runCatching {
                String(Base64.getDecoder().decode(encoded), Charsets.UTF_8)
            }.getOrNull()
        }
        .firstOrNull { it.startsWith("$key=") }
        ?.substringAfter("=")
        ?.takeIf { it.isNotBlank() }
}

val kakaoNativeAppKey =
    dartDefineValue("KAKAO_NATIVE_APP_KEY")
        ?: providers.gradleProperty("KAKAO_NATIVE_APP_KEY").orNull
        ?: providers.environmentVariable("KAKAO_NATIVE_APP_KEY").orNull
        ?: ""

android {
    namespace = "team.choikkang.dalbitsuwon"
    // permission_handler_android 등 최신 라이브러리가 SDK 37 이상을 요구하므로
    // Flutter 기본값 대신 명시적으로 37 이상을 지정한다.
    compileSdk = maxOf(flutter.compileSdkVersion, 37)
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "team.choikkang.dalbitsuwon"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        manifestPlaceholders["kakaoNativeAppKey"] = kakaoNativeAppKey
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
