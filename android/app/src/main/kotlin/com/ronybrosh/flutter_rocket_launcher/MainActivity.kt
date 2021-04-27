package com.ronybrosh.flutter_rocket_launcher

import android.content.Context
import android.os.Bundle
import android.view.View
import io.flutter.embedding.android.DrawableSplashScreen
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.SplashScreen

class MainActivity : FlutterActivity() {
    inner class RocketLauncherSplashScreen : SplashScreen {
        override fun createSplashView(context: Context, savedInstanceState: Bundle?): View {
            return DrawableSplashScreen.DrawableSplashScreenView(context).apply {
                setSplashDrawable(resources.getDrawable(R.drawable.launch_background, theme))
            }
        }

        override fun transitionToFlutter(onTransitionComplete: Runnable) {
            onTransitionComplete.run()
        }
    }

    override fun provideSplashScreen(): SplashScreen {
        return RocketLauncherSplashScreen()
    }
}
