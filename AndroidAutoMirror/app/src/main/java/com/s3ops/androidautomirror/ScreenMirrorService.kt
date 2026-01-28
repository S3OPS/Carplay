package com.s3ops.androidautomirror

import android.app.*
import android.content.Context
import android.content.Intent
import android.graphics.PixelFormat
import android.hardware.display.DisplayManager
import android.hardware.display.VirtualDisplay
import android.media.ImageReader
import android.media.projection.MediaProjection
import android.media.projection.MediaProjectionManager
import android.os.Build
import android.os.IBinder
import android.util.DisplayMetrics
import android.util.Log
import android.view.WindowManager
import androidx.core.app.NotificationCompat

class ScreenMirrorService : Service() {

    private var mediaProjection: MediaProjection? = null
    private var virtualDisplay: VirtualDisplay? = null
    private var imageReader: ImageReader? = null
    
    private var screenDensity: Int = 0
    private var screenWidth: Int = 0
    private var screenHeight: Int = 0

    companion object {
        const val ACTION_START = "com.s3ops.androidautomirror.START"
        const val ACTION_STOP = "com.s3ops.androidautomirror.STOP"
        private const val NOTIFICATION_ID = 1001
        private const val CHANNEL_ID = "screen_mirror_channel"
        private const val TAG = "ScreenMirrorService"
        
        var isRunning = false
            private set
    }

    override fun onCreate() {
        super.onCreate()
        createNotificationChannel()
        
        val windowManager = getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val metrics = DisplayMetrics()
        windowManager.defaultDisplay.getMetrics(metrics)
        
        screenDensity = metrics.densityDpi
        screenWidth = metrics.widthPixels
        screenHeight = metrics.heightPixels
        
        Log.d(TAG, "Screen: ${screenWidth}x${screenHeight}, density: $screenDensity")
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        when (intent?.action) {
            ACTION_START -> {
                val resultCode = intent.getIntExtra("resultCode", Activity.RESULT_CANCELED)
                val data: Intent? = intent.getParcelableExtra("data")
                
                if (resultCode == Activity.RESULT_OK && data != null) {
                    startForeground(NOTIFICATION_ID, createNotification("Screen mirroring active"))
                    startScreenCapture(resultCode, data)
                    isRunning = true
                } else {
                    stopSelf()
                }
            }
            ACTION_STOP -> {
                stopScreenCapture()
                stopSelf()
            }
        }
        
        return START_NOT_STICKY
    }

    private fun startScreenCapture(resultCode: Int, data: Intent) {
        val mediaProjectionManager = 
            getSystemService(Context.MEDIA_PROJECTION_SERVICE) as MediaProjectionManager
        
        mediaProjection = mediaProjectionManager.getMediaProjection(resultCode, data)
        
        imageReader = ImageReader.newInstance(
            screenWidth,
            screenHeight,
            PixelFormat.RGBA_8888,
            2
        )
        
        imageReader?.setOnImageAvailableListener({ reader ->
            val image = reader.acquireLatestImage()
            if (image != null) {
                // Process the captured frame here
                // In a production app, you would:
                // 1. Encode the frame
                // 2. Stream it to Android Auto display
                // 3. Handle the buffer efficiently
                
                processFrame(image)
                image.close()
            }
        }, null)
        
        virtualDisplay = mediaProjection?.createVirtualDisplay(
            "ScreenMirrorDisplay",
            screenWidth,
            screenHeight,
            screenDensity,
            DisplayManager.VIRTUAL_DISPLAY_FLAG_AUTO_MIRROR,
            imageReader?.surface,
            null,
            null
        )
        
        Log.d(TAG, "Screen capture started")
    }

    private fun processFrame(image: android.media.Image) {
        // This is where frame processing would happen
        // For Android Auto integration, frames would be:
        // 1. Encoded (H.264/H.265)
        // 2. Sent to Android Auto display via Car App API
        // 3. Buffered for smooth playback
        
        // Note: Current Android Auto API limitations don't allow
        // arbitrary video content display like CarPlay does
    }

    private fun stopScreenCapture() {
        virtualDisplay?.release()
        imageReader?.close()
        mediaProjection?.stop()
        
        virtualDisplay = null
        imageReader = null
        mediaProjection = null
        
        isRunning = false
        Log.d(TAG, "Screen capture stopped")
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                "Screen Mirror Service",
                NotificationManager.IMPORTANCE_LOW
            ).apply {
                description = "Ongoing screen mirroring notification"
            }
            
            val notificationManager = 
                getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }

    private fun createNotification(text: String): Notification {
        val intent = Intent(this, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(
            this,
            0,
            intent,
            PendingIntent.FLAG_IMMUTABLE
        )
        
        val stopIntent = Intent(this, ScreenMirrorService::class.java).apply {
            action = ACTION_STOP
        }
        val stopPendingIntent = PendingIntent.getService(
            this,
            0,
            stopIntent,
            PendingIntent.FLAG_IMMUTABLE
        )

        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("Android Auto Mirror")
            .setContentText(text)
            .setSmallIcon(android.R.drawable.ic_menu_compass)
            .setContentIntent(pendingIntent)
            .addAction(
                android.R.drawable.ic_media_pause,
                "Stop",
                stopPendingIntent
            )
            .setOngoing(true)
            .build()
    }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onDestroy() {
        super.onDestroy()
        stopScreenCapture()
    }
}
