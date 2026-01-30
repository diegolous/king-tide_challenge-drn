import com.google.firebase.appdistribution.gradle.firebaseAppDistribution

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    // Add the Google services Gradle plugin
    id("com.google.gms.google-services")
    // Firebase App Distribution Gradle plugin
    id("com.google.firebase.appdistribution")
}

android {
    namespace = "com.diegolousx.kt_challenge"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.diegolousx.kt_challenge"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    flavorDimensions += "environment"
    productFlavors {
        create("prod") {
            dimension = "environment"
            applicationIdSuffix = ""
        }
        create("dev") {
            dimension = "environment"
            applicationIdSuffix = ".dev"
        }
        create("stg") {
            dimension = "environment"
            applicationIdSuffix = ".stg"
        }
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
            firebaseAppDistribution {
                artifactType = "APK"
                releaseNotes = System.getenv("FIREBASE_RELEASE_NOTES") ?: "Automated upload"
                val testersEnv = System.getenv("FIREBASE_TESTERS")
                if (!testersEnv.isNullOrBlank()) {
                    testers = testersEnv
                }
            }
        }
    }
}

dependencies {
    // Import the Firebase BoM
    implementation(platform("com.google.firebase:firebase-bom:34.8.0"))

    // Add other Firebase products you want to use
    // When using the BoM, don't specify versions in Firebase dependencies
}

flutter {
    source = "../.."
}
