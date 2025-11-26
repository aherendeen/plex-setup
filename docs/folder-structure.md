# Folder Structure

Optimal folder structure for Plex media servers based on [TRaSH Guides](https://trash-guides.info/File-and-Folder-Structure/).

## Overview

This structure enables:

- **Hardlinks**: Avoid duplicate storage when seeding torrents
- **Atomic Moves**: Instant file moves (no copy+delete)
- **Clean Organization**: Consistent paths for all applications

## Recommended Structure

```text
data/
├── torrents/
│   ├── movies/
│   ├── shows/
│   ├── music/
│   └── books/
├── usenet/
│   ├── incomplete/
│   └── complete/
│       ├── movies/
│       ├── shows/
│       ├── music/
│       └── books/
└── media/
    ├── movies/
    ├── shows/
    ├── music/
    ├── audiobooks/
    ├── podcasts/
    ├── musicvideos/
    ├── sports/
    └── courses/
```

## Key Principles

### Single Root

All media-related paths should exist under a single root (`/data`, `/mnt/storage`, `E:/data`, etc.). This ensures hardlinks work correctly.

**Bad** (multiple roots):

```text
/movies/
/tv/
/downloads/
```

**Good** (single root):

```text
/data/media/movies/
/data/media/shows/
/data/torrents/movies/
```

### Case Sensitivity

Use lowercase for consistency (Linux is case-sensitive):

- `movies` not `Movies`
- `shows` not `Shows`
- `data` not `Data`

### No Spaces

Avoid spaces in folder names:

- `musicvideos` not `music videos`
- `audiobooks` not `audio books`

## Application Paths

### FileBot

FileBot presets use `/data/media/` as the base:

- Movies: `/data/media/movies/`
- Shows: `/data/media/shows/`
- Sports: `/data/media/sports/`
- Courses: `/data/media/courses/`

Override by editing `config/paths.env`.

### Docker Containers

Map host path to `/data` in containers:

```yaml
volumes:
  - /mnt/storage/data:/data
```

All containers see the same filesystem, enabling hardlinks.

### Plex

Point Plex libraries at `/data/media/`:

- Movies: `/data/media/movies`
- TV Shows: `/data/media/shows`
- Music: `/data/media/music`

### Sonarr/Radarr

Configure:

- Sonarr library path: `/data/media/shows`
- Radarr library path: `/data/media/movies`
- Download client category: `/data/torrents/shows` or `/data/torrents/movies`

When import completes, Sonarr/Radarr will hardlink from `/data/torrents/` to `/data/media/` (instant, no duplication).

## Platform-Specific

### Linux/Docker

```bash
/data/
```

Set permissions:

```bash
sudo chown -R $USER:$USER /data
sudo chmod -R 775 /data
```

### Windows

```text
E:/data/
```

Use forward slashes in configs, even on Windows.

### macOS

```text
/Volumes/storage/data/
```

## Hardlinks Requirements

- **Same filesystem**: All paths must be on the same filesystem/volume
- **No network shares**: Use local mounts or Docker volumes
- **Supported filesystem**: ext4, xfs, btrfs, NTFS, APFS (not exFAT)

## Validation

Check if hardlinks work:

```bash
ls -lahi /data/media/movies/Movie.mkv
ls -lahi /data/torrents/movies/Movie.mkv
```

If inode numbers match, hardlinks are working.

## References

- [TRaSH Guides - Hardlinks](https://trash-guides.info/File-and-Folder-Structure/Hardlinks-and-Instant-Moves/)
- [TRaSH Guides - Docker Setup](https://trash-guides.info/File-and-Folder-Structure/How-to-set-up/Docker/)
