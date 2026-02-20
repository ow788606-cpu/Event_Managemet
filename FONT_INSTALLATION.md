# Inter Font Installation Instructions

## Download Inter Font Files

1. Go to: https://fonts.google.com/specimen/Inter
2. Click "Download family" button
3. Extract the ZIP file
4. Copy these files from the `static` folder to `assets/fonts/`:
   - Inter-Regular.ttf
   - Inter-Medium.ttf
   - Inter-SemiBold.ttf
   - Inter-Bold.ttf

## Alternative: Direct Download Links

Or download directly from GitHub:
https://github.com/rsms/inter/releases/latest

## After Adding Fonts

1. Run: `flutter pub get`
2. Run: `flutter clean`
3. Run: `flutter run`

## Current Status

The pubspec.yaml is already configured to use Inter font.
You just need to add the font files to the `assets/fonts/` directory.

## Font Files Needed

```
event/
  assets/
    fonts/
      Inter-Regular.ttf
      Inter-Medium.ttf
      Inter-SemiBold.ttf
      Inter-Bold.ttf
```
