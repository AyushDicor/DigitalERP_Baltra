import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")      // <-- use the Kotlin plugin id for KTS
    id("dev.flutter.flutter-gradle-plugin")
}

val localProperties = Properties().apply {
    val lpFile = rootProject.file("local.properties")
    if (lpFile.exists()) FileInputStream(lpFile).use { load(it) }
}

val flutterVersionCode: Int =
    localProperties.getProperty("flutter.versionCode")?.toIntOrNull() ?: 1
val flutterVersionName: String =
    localProperties.getProperty("flutter.versionName") ?: "1.0"

// ---- optional keystore (release) ----
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties").also { f ->
    if (f.exists()) FileInputStream(f).use { keystoreProperties.load(it) }
}

android {
    namespace = "com.globenex.erp"
    compileSdk = 36
    ndkVersion = "27.0.12077973"

    defaultConfig {
        applicationId = "com.globenex.erp"
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = flutterVersionCode          // <-- use variables
        versionName = flutterVersionName          // <--
        multiDexEnabled = true
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    signingConfigs {
        if (keystorePropertiesFile.exists()) {
            create("release") {
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
                val storePath = keystoreProperties["storeFile"] as String
                storeFile = file(storePath)
                storePassword = keystoreProperties["storePassword"] as String
            }
        }
    }

    buildTypes {
        getByName("debug") { }
        getByName("release") {
            signingConfig = if (keystorePropertiesFile.exists())
                signingConfigs.getByName("release")
            else
                signingConfigs.getByName("debug")

            // isMinifyEnabled = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                file("proguard-rules.pro")
            )
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation("androidx.multidex:multidex:2.0.1")
    // You can remove this; the Kotlin plugin adds stdlib automatically:
    // implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.8.22")
}
//
//
//
//plugins {
//    id("com.android.application")
//    id("kotlin-android")
//    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
//    id("dev.flutter.flutter-gradle-plugin")
//}
//
//android {
//    namespace = "com.dicorerp.app"
//    compileSdk = 35
//    ndkVersion =  "27.0.12077973"
//
//    compileOptions {
//        sourceCompatibility = JavaVersion.VERSION_11
//        targetCompatibility = JavaVersion.VERSION_11
//        isCoreLibraryDesugaringEnabled = true
//    }
//
//    kotlinOptions {
//        jvmTarget = JavaVersion.VERSION_11.toString()
//    }
//
//    defaultConfig {
//        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
//        applicationId = "com.dicorerp.app"
//        // You can update the following values to match your application needs.
//        // For more information, see: https://flutter.dev/to/review-gradle-config.
//        minSdk = 23
//        targetSdk = 35
//        versionCode = flutter.versionCode
//        versionName = flutter.versionName
//    }
//
//    buildTypes {
//        release {
//            // TODO: Add your own signing config for the release build.
//            // Signing with the debug keys for now, so `flutter run --release` works.
//            signingConfig = signingConfigs.getByName("debug")
////            proguardFiles(
////                    getDefaultProguardFile("proguard-android-optimize.txt"),
////                    file("proguard-rules.pro")
////            )
//        }
//    }
//}
//
//flutter {
//    source = "../.."
//}
//
//dependencies {
//
//    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.8.22")
//    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
//
//}
