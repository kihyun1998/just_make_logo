# Changelog

## 0.10.0

### Features
- Transparent background option (PNG export)
- Border radius option for rounded corner export

## 0.9.0

### Features
- Logo mode selection (Text Only / Image Only / Text + Image)
- Canvas padding option
- 7 logo fonts added (Bebas Neue, Pacifico, Lobster, Raleway, Permanent Marker, Black Han Sans, Noto Sans KR)
- 16:9 aspect ratio size presets (1920x1080, 1280x720)
- Image insertion with layout/ratio/gap/fit controls
- Custom color picker with + button
- Color preset save/load with SharedPreferences persistence
- Logo export (PNG/JPG/SVG) with scale options
- Dark mode theme (TweakcnTheme)
- Multi-line text input with configurable line count
- Font size control
- Cross-platform URL opening support

### Improvements
- Text scale changed to padding-based approach (max size by default, shrink with padding)
- Migrated state management to Riverpod codegen + SharedPreferences
- Modular file structure refactoring
- Pixel font data separation (alphabets, numbers, symbols)

### Bug Fixes
- Fixed option chip Row overflow by replacing with Wrap
- Added macOS sandbox entitlements for file picker
- Added macOS network permissions
