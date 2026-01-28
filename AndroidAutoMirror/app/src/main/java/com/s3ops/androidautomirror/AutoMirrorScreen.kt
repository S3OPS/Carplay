package com.s3ops.androidautomirror

import android.content.Context
import android.content.Intent
import androidx.car.app.CarContext
import androidx.car.app.Screen
import androidx.car.app.model.*

class AutoMirrorScreen(carContext: CarContext) : Screen(carContext) {

    override fun onGetTemplate(): Template {
        return ListTemplate.Builder()
            .setSingleList(createItemList())
            .setTitle("Android Auto Mirror")
            .setHeaderAction(Action.APP_ICON)
            .build()
    }

    private fun createItemList(): ItemList {
        return ItemList.Builder()
            .addItem(
                Row.Builder()
                    .setTitle("Start Screen Mirroring")
                    .setBrowsable(false)
                    .setOnClickListener {
                        startMirroringFromAuto()
                    }
                    .build()
            )
            .addItem(
                Row.Builder()
                    .setTitle("Stop Screen Mirroring")
                    .setBrowsable(false)
                    .setOnClickListener {
                        stopMirroringFromAuto()
                    }
                    .build()
            )
            .addItem(
                Row.Builder()
                    .setTitle("Status")
                    .addText(if (ScreenMirrorService.isRunning) "Mirroring Active 🟢" else "Ready")
                    .build()
            )
            .build()
    }

    private fun startMirroringFromAuto() {
        // Note: We can't directly start MediaProjection from Android Auto
        // User needs to start it from the phone app first
        
        carContext.getSharedPreferences("mirror_prefs", Context.MODE_PRIVATE)
            .edit()
            .putBoolean("start_requested", true)
            .apply()
        
        CarToast.makeText(
            carContext,
            "Please start mirroring from your phone",
            CarToast.LENGTH_LONG
        ).show()
        
        invalidate()
    }

    private fun stopMirroringFromAuto() {
        val serviceIntent = Intent(carContext, ScreenMirrorService::class.java).apply {
            action = ScreenMirrorService.ACTION_STOP
        }
        carContext.startService(serviceIntent)
        
        CarToast.makeText(
            carContext,
            "Mirroring stopped",
            CarToast.LENGTH_SHORT
        ).show()
        
        invalidate()
    }
}
