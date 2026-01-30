package com.diegolousx.kt_challenge.widgets

import android.appwidget.AppWidgetManager
import android.content.Context
import android.net.Uri
import android.widget.RemoteViews
import android.content.SharedPreferences
import com.diegolousx.kt_challenge.MainActivity
import com.diegolousx.kt_challenge.R
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider

class CharacterWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences,
    ) {
        val favoritesCount = widgetData.getInt("favorites_count", 0)
        val lastUpdated = widgetData.getString("last_updated", "—") ?: "—"

        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.character_widget)
            views.setTextViewText(R.id.widget_favorites_count, favoritesCount.toString())
            views.setTextViewText(R.id.widget_last_updated, "Updated $lastUpdated")

            val launchIntent = HomeWidgetLaunchIntent.getActivity(context, MainActivity::class.java)
            views.setOnClickPendingIntent(R.id.widget_root, launchIntent)

            val refreshUri = Uri.parse("futurama://refresh")
            val refreshIntent = HomeWidgetBackgroundIntent.getBroadcast(context, refreshUri)
            views.setOnClickPendingIntent(R.id.widget_refresh, refreshIntent)

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
