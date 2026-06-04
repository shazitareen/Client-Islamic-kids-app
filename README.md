# islamic_kids_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

This is an excellent feature request from your client, but Claude's suggested approach has a few **hidden pitfalls** that you need to be careful of before you start building.

Here is my breakdown of Claude's suggestions and the best way to handle your client's requirements:

### 1. The Video Sourcing Problem (Don't use YouTube) ⚠️

**Claude's Suggestion:** Use `youtube_player_flutter` for zero hosting cost.
**My Opinion:** I strongly advise **AGAINST** using YouTube, especially for an Islamic app (and particularly if this is the toddler/kids app you've been working on).

- **The Problem:** YouTube embeds often inject display ads, overlay branding, and most importantly, they show "Related Videos" when paused or finished. Having inappropriate or random YouTube algorithm suggestions pop up during a "How to Pray" tutorial will completely ruin the professional, safe environment of the app.
- **The Solution:** Use the official Flutter `video_player` package and either:
  1. **Bundle them locally:** If you compress the videos well (e.g., 480p format), 5 prayer videos might only take up 20-30MB. The Play Store limit is 150MB, so you can likely just put the `.mp4` files right in your app's `assets` folder. It offers true offline support and zero ads.
  2. **Cache from Cloud (Firebase/AWS):** Host the raw `.mp4` on a cheap bucket, stream it using `flutter_cache_manager` + `video_player` so it plays instantly and saves to their phone for the next time.

### 2. The Audio/Video Sync Trap ⏱️

**Claude's Suggestion:** Use `just_audio` for the 3 speeds, alongside a video embed.
**My Opinion:** If you use separate packages for audio and video, you're going to have an alignment nightmare. If the user selects the `0.5x` slower speed on `just_audio`, the audio recitation will be half as fast, but the person in the video will continue moving at normal speed. The physical actions (Ruku, Sujood) will end while the audio is still playing!

- **The Solution:** Combine them. Make sure the video files you use *already have the audio in them*. The standard Flutter `video_player` natively supports changing playback speed through `controller.setPlaybackSpeed(double speed)`. If you do it this way, slowing the file to `0.75x` will automatically slow down both the reciter's voice *and* the visual movements of the person praying so they stay perfectly in sync.

### 3. Pricing - Don't Undervalue Yourself 💰

**Claude's Suggestion:** $25–$30.
**My Opinion:** $30 is too low for this, especially if you are the one who has to go hunt down the videos, cut them, and compress them.

- **Quote $50 - $80.** Building out the nested menus (5 Prayers -> Fard/Sunnah -> Player UI), implementing a custom video player overlay with playback controls and speed toggles, and handling the asset sourcing takes effort.
- *Negotiation Tip:* Tell the client: *"I can definitely add this. Building a custom video player with adjustable recitation speeds that syncs with the visuals is a solid addition. I can do it for $60 if you provide the mp4 video files you want to use, or $80 if I need to source, edit, and compress the video materials myself."*

### My Recommended Implementation Plan

```yaml
packages needed:
- video_player        # Handles both the video and the synced audio
- chewie              # (Optional) Gives you a beautiful, pre-built video UI so you don't have to build pause/play buttons from scratch
- shared_preferences  # To save the user's preferred speed (e.g. 1.0x, 0.75x, 0.5x)
```

**Structure:**

1. **Prayer List Screen (Fajr, Dhuhr, etc.)**
2. **Sub-Menu (2 Sunnah, 2 Fard)**
3. **Player Screen:** A clean UI featuring the `chewie` customized video player containing the `.mp4`. Below the video player, you place 3 stylish pill buttons for (`Slow`, `Normal`, `Fast`) which simply trigger `_controller.setPlaybackSpeed(...)`.

**Summary to give your client:**
You can tell Numan: *"Yes, we can absolutely do this! To keep the app perfectly ad-free and professional, I will build a custom internal video player rather than linking to YouTube (which shows ads). The player will feature a 3-speed toggle that synchronously slows down both the recitation and the prayer movements so the user can easily follow along offline."*
