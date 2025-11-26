# Plex Setup Toolkit

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20A%20Coffee-support-yellow?logo=buy-me-a-coffee&logoColor=white)](https://www.buymeacoffee.com/aherendeen)

Production-ready FileBot, FFmpeg, and Kometa configurations for Plex media servers. Implements TRaSH Guides best practices for optimal hardlinks and atomic moves.

## Features

- **FileBot Presets**: ID-pinned folders, multi-episode support, provider/quality badges
- **FFmpeg Recipes**: Hardware-accelerated encoding, format conversion, subtitle extraction
- **Kometa Integration**: Docker configs for collections, overlays, metadata management
- **TRaSH-Compliant**: Folder structure optimized for hardlinks and instant moves
- **Cross-Platform**: Works on Windows, macOS, Linux (Docker or native)

## Quick Start

```bash
git clone https://github.com/aherendeen/plex-setup.git
cd plex-setup
cp config/paths.env.example config/paths.env
# Edit config/paths.env with your data root
```

See [Installation Guide](docs/installation.md) for platform-specific setup.

## Usage

### Linux/macOS

```bash
# Test FileBot rename (safe preview)
./filebot-rename.sh movies /data/media/movies --action test

# Execute rename
./filebot-rename.sh movies /data/media/movies --action move
```

### Windows

```powershell
# Test FileBot rename (safe preview)
.\filebot-rename.ps1 -Type movies -Input "D:\data\media\movies" -Action test

# Execute rename
.\filebot-rename.ps1 -Type movies -Input "D:\data\media\movies" -Action move
```

## Structure

```text
plex-setup/
├── filebot-rename.ps1      # Windows rename script
├── filebot-rename.sh       # Linux/macOS rename script
├── config/
│   ├── paths.env.example   # Environment configuration
│   ├── filebot/            # FileBot format presets
│   │   ├── format-expressions.md
│   │   └── presets/
│   └── mp3tag/             # MP3Tag configurations
├── docker/
│   ├── docker-compose.yml  # Kometa Docker stack
│   ├── .env.example        # Docker environment
│   └── kometa-config/      # Kometa runtime config
├── docs/                   # Guides and documentation
├── kometa/
│   ├── assets/             # Custom posters/artwork
│   └── templates/          # YAML templates
├── logs/                   # Output logs (gitignored)
└── scripts/                # Additional automation
```

## Documentation

- [Installation Guide](docs/installation.md)
- [Folder Structure](docs/folder-structure.md)
- [FileBot Guide](docs/filebot-guide.md)
- [FFmpeg Guide](docs/ffmpeg-guide.md)
- [Kometa Guide](docs/kometa-guide.md)
- [Naming Conventions](docs/naming-guide.md)
- [Troubleshooting](docs/troubleshooting.md)

## Naming Examples

### Movies

```text
Avatar (2009) {tmdb-19995}/
└── Avatar (2009) {tmdb-19995} [1080P-BLURAY-AAC].mkv
```

### TV Shows

```text
Breaking Bad {tvdb-81189}/
└── Season 01/
    └── Breaking Bad - S01E01-E02 - Pilot [720P-HDTV-AAC].mkv
```

## Requirements

- FileBot 5.0+
- FFmpeg 6.0+
- ImageMagick 7.0+ (optional)
- Docker (optional, for Kometa)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

MIT
