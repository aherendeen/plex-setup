# Docker Compose Stacks

Docker configurations for Kometa and other media management tools.

## Quick Start

```bash
cd docker
cp .env.example .env
# Edit .env with your Plex token and API keys
docker-compose up -d
```

## Services

### Kometa

Automatically manages Plex collections, overlays, and metadata.

- **Image**: `kometateam/kometa:latest`
- **Schedule**: Runs daily at 6:00 AM (configurable via `KOMETA_TIMES`)
- **Config**: Place your `config.yml` in `docker/kometa-config/`

### Posterizarr (Optional)

Automated poster management. Uncomment in `docker-compose.yml` to enable.

## Configuration

1. Copy `.env.example` to `.env`
2. Set your `PLEX_TOKEN` and API keys
3. Adjust `MEDIA_ROOT` to your media directory
4. Create Kometa config at `docker/kometa-config/config.yml`

See [Kometa Guide](../docs/kometa-guide.md) for detailed configuration.

## Commands

```bash
# Start services
docker-compose up -d

# View logs
docker-compose logs -f kometa

# Run Kometa manually
docker-compose run --rm kometa

# Stop services
docker-compose down

# Update images
docker-compose pull
docker-compose up -d
```

## Volume Mappings

| Host Path | Container Path | Purpose |
|-----------|----------------|---------|
| `./kometa-config` | `/config` | Kometa configuration |
| `../kometa/assets` | `/assets` | Custom posters/artwork |
| `$MEDIA_ROOT` | `/data/media` | Media library (read-only) |
