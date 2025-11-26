# Kometa Assets

Custom poster and background images for Kometa collections and overlays.

## Directory Structure

```text
assets/
├── movies/
│   ├── Collection Name/
│   │   └── poster.jpg
│   └── Movie Title (Year)/
│       └── poster.jpg
├── shows/
│   ├── Collection Name/
│   │   └── poster.jpg
│   └── Show Title/
│       ├── poster.jpg
│       └── Season01.jpg
└── overlays/
    └── custom-overlay.png
```

## Poster Specifications

| Type | Resolution | Aspect Ratio | Format |
|------|------------|--------------|--------|
| Poster | 1000×1500 | 2:3 | JPG/PNG |
| Background | 1920×1080 | 16:9 | JPG/PNG |
| Season | 1000×1500 | 2:3 | JPG/PNG |

## Usage

1. Create folder matching library/collection name exactly
2. Add `poster.jpg` or `poster.png` inside
3. Kometa will automatically apply when `asset_folders: true` in config

## Resources

- [Kometa Asset Documentation](https://metamanager.wiki/en/latest/kometa/guides/assets/)
- [ThePosterDB](https://theposterdb.com/) - Community posters
- [FanArt.tv](https://fanart.tv/) - Official artwork
