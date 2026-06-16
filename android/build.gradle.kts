//buildscript {
//    ext.kotlin_version = '1.7.10'
//    repositories {
//        google()
//        mavenCentral()
//    }
//
//    dependencies {
//        classpath 'com.android.tools.build:gradle:7.3.0'
//        classpath 'com.google.gms:google-services:4.3.13'
//        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
//    }
//}
//
//allprojects {
//    repositories {
//        google()
//        mavenCentral()
//    }
//}
//
//rootProject.buildDir = '../build'
//subprojects {
//    project.buildDir = "${rootProject.buildDir}/${project.name}"
//}
//subprojects {
//    project.evaluationDependsOn(':app')
//}
//
//tasks.register("clean", Delete) {
//    delete rootProject.buildDir
//}



buildscript {
    // Compatibility for older Flutter Android plugins that still reference `$kotlin_version`.
     extra["kotlin_version"] = "2.1.0"

}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)


subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    afterEvaluate {
        if (name == "battery_plus") {
            val androidExt = extensions.findByName("android")
            if (androidExt is groovy.lang.GroovyObject) {
                val namespace = runCatching { androidExt.getProperty("namespace") as String? }.getOrNull()
                if (namespace.isNullOrBlank()) {
                    androidExt.setProperty("namespace", "dev.fluttercommunity.plus.battery")
                }

                val compileOptions = runCatching { androidExt.getProperty("compileOptions") }.getOrNull()
                if (compileOptions is groovy.lang.GroovyObject) {
                    compileOptions.setProperty("sourceCompatibility", JavaVersion.VERSION_17)
                    compileOptions.setProperty("targetCompatibility", JavaVersion.VERSION_17)
                }

                val kotlinOptions = runCatching { androidExt.getProperty("kotlinOptions") }.getOrNull()
                if (kotlinOptions is groovy.lang.GroovyObject) {
                    kotlinOptions.setProperty("jvmTarget", "17")
                }
            }
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}
subprojects {
    configurations.all {
        resolutionStrategy.eachDependency {
            if (requested.group == "org.jetbrains.kotlin") {
               useVersion("2.1.0")

            }
        }
    }
}


tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
