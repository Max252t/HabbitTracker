package com.example.habbit_tracker

import android.app.Application
import com.yandex.mapkit.MapKitFactory

class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        MapKitFactory.setLocale("ru_RU")
        MapKitFactory.setApiKey("5b0214fc-2e03-4f82-84e5-094e44a8c486")
    }
}

