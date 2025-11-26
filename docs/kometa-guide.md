# Kometa Setup Guide

Configure Kometa (formerly Plex Meta Manager) for collections, overlays, and playlists.

## Overview

Kometa automatically manages Plex metadata:

- **Collections**: Group movies/shows by genre, year, actor, franchise, etc.
- **Overlays**: Add resolution, HDR, and audio badges to posters
- **Playlists**: Create cross-library playlists

## Installation

### Docker (Recommended)

Works on all platforms (Windows, macOS, Linux).

1. **Navigate to docker directory**:

   ```bash
   cd plex-setup/docker
   ```

2. **Copy environment file**:

   ```bash
   cp .env.example .env
   ```

3. **Edit `.env`** with your Plex URL, token, and API keys:

   ```bash
   # Linux/macOS
   nano .env
   
   # Windows
   notepad .env
   ```

4. **Configure volume mappings** (in `docker-compose.yml`):

   ```yaml
   volumes:
     - /data/media:/data/media:ro  # TRaSH-compliant path
     - ./kometa/config:/config
     - ./kometa/assets:/assets
   ```

   Use your actual media root (e.g., `D:/data/media` for Windows, `/mnt/data/media` for Linux).

5. **Start Kometa**:

   ```bash
   docker-compose up -d
   ```

6. **Check logs**:

   ```bash
   docker-compose logs -f kometa
   ```

### Native Python (Alternative)

#### Windows

```powershell
pip install kometa
kometa --config kometa/config/config.yml
```

#### Linux/macOS

```bash
pip3 install kometa
kometa --config kometa/config/config.yml
```

## Configuration

### Basic Config

Edit `kometa/config/config.yml`:

```yaml
plex:
  url: http://localhost:32400
  token: YOUR_PLEX_TOKEN

tmdb:
  apikey: YOUR_TMDB_API_KEY

libraries:
  Movies:
    metadata_path:
      - config/movies.yml
    overlay_path:
      - config/overlays.yml
    
  TV Shows:
    metadata_path:
      - config/tv.yml
    overlay_path:
      - config/overlays.yml

settings:
  asset_folders: true
  asset_directory: assets/
  show_missing: true
  save_report: true
```

### Get Plex Token

1. **Web method**:
   - Open Plex Web App
   - Play any item
   - Click `...` → `Get Info` → `View XML`
   - Token is in URL: `X-Plex-Token=...`

2. **Settings method**:
   - Settings → General → Show Advanced
   - Network → Secure connections → Show token

### Get TMDB API Key

1. Create account at [themoviedb.org](https://www.themoviedb.org/)
2. Go to Settings → API → Request API Key
3. Choose "Developer" option
4. Fill out form
5. Copy API key (v3 auth)

## Collections

### Example Movie Collections

Create `kometa/config/movies.yml`:

```yaml
collections:
  Top Rated:
    imdb_list: https://www.imdb.com/search/title/?groups=top_250
    sort_title: "!01_Top Rated"
    summary: Top 250 movies on IMDb
  
  Marvel Cinematic Universe:
    tmdb_collection: 86311
    sort_title: "!02_MCU"
    summary: Marvel Cinematic Universe films
  
  Recently Added:
    plex_search:
      all:
        year.gte: 2020
    sort_title: "!03_Recent"
    summary: Movies from 2020 onwards
```

### Example TV Collections

Create `kometa/config/tv.yml`:

```yaml
collections:
  Trending:
    trakt_trending: 10
    sort_title: "!01_Trending"
    summary: Currently trending shows
  
  Sci-Fi:
    plex_search:
      all:
        genre: Science Fiction
    sort_title: "!02_Sci-Fi"
    summary: Science Fiction series
```

## Overlays

### Resolution + HDR Overlays

Create `kometa/config/overlays.yml`:

```yaml
overlays:
  720p:
    overlay:
      name: 720p
      pmm: resolution/720p
    plex_search:
      all:
        resolution: 720p
  
  1080p:
    overlay:
      name: 1080p
      pmm: resolution/1080p
    plex_search:
      all:
        resolution: 1080p
  
  HDR:
    overlay:
      name: HDR
      pmm: video_format/HDR
    plex_search:
      all:
        hdr: true
```

## Assets (Posters)

### Directory Structure

```text
kometa/assets/
├── Movies/
│   ├── The Matrix (1999)/
│   │   └── poster.jpg
│   ├── Inception (2010)/
│   │   └── poster.jpg
│   └── Top Rated/
│       └── poster.jpg
└── TV Shows/
    ├── Breaking Bad/
    │   ├── poster.jpg
    │   └── Season01.jpg
    └── Trending/
        └── poster.jpg
```

### Poster Requirements

- **Resolution**: 1000×1500 pixels (2:3 ratio)
- **Format**: JPG or PNG
- **Naming**:
  - Collection poster: `{Collection Name}/poster.jpg`
  - Movie/show poster: `{Movie/Show Title}/poster.jpg`
  - Season poster: `{Show Title}/Season##.jpg`

### Create Posters with ImageMagick

```bash
# Resize to Plex standard
magick input.jpg -resize 1000x1500^ -gravity center -extent 1000x1500 -quality 90 poster.jpg

# Batch process
for f in *.jpg; do
    magick "$f" -resize 1000x1500^ -gravity center -extent 1000x1500 -quality 90 "poster-$f"
done
```

## Running Kometa

### Docker

```bash
# Run once
docker-compose run --rm kometa

# Schedule with cron (Linux/macOS)
# Add to crontab: 0 6 * * * cd /path/to/plex-setup/docker && docker-compose run --rm kometa

# Schedule with Task Scheduler (Windows)
# Create task to run: docker-compose run --rm kometa
```

### Native Python

```bash
# Run once
kometa --config kometa/config/config.yml

# Schedule with cron (Linux/macOS)
0 6 * * * kometa --config /path/to/kometa/config/config.yml
```

## Advanced

### Run Order

Control what runs when in `config.yml`:

```yaml
settings:
  run_order:
    - collections
    - metadata
    - overlays
```

### Webhooks

Notify on completion:

```yaml
webhooks:
  error: https://discord.com/api/webhooks/...
  run_end: https://discord.com/api/webhooks/...
```

### Time Schedules

Run collections on different schedules:

```yaml
collections:
  Weekly Updated:
    trakt_trending: 20
    schedule: weekly(sunday)
  
  Monthly Classic:
    imdb_list: https://...
    schedule: monthly(1)
```

## Troubleshooting

### Collections Not Appearing

- Check `run_order` includes `collections`
- Verify API keys are valid
- Check logs: `docker-compose logs kometa`

### Posters Not Applying

- Ensure `asset_folders: true` in config
- Check directory structure matches library names
- Verify poster naming (must match collection/item exactly)

### Rate Limiting

Kometa may hit API rate limits. Solutions:

- Increase delay between requests in config
- Use caching (enabled by default)
- Schedule runs during off-peak hours

For more issues, see [Troubleshooting Guide](troubleshooting.md#kometa).

## Resources

- [Kometa Wiki](https://metamanager.wiki/)
- [Default Configs](https://github.com/Kometa-Team/Kometa/tree/master/defaults)
- [Community Configs](https://github.com/Kometa-Team/Community-Configs)
