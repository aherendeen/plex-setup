# Naming Conventions

Folder and file naming strategies for optimal Plex matching and organization.

## Core Principles

1. **ID-Pinned Folders**: Always include database IDs (`{tmdb-...}`, `{tvdb-...}`) in folder names for perfect Plex matching
2. **Clean Titles**: No dot separators, decade tags, or excessive metadata in folder names
3. **Quality Badges**: Include resolution, HDR/DV, and audio format in filenames
4. **Provider Badges**: Optional service tags (AMZN, NF, DSNP, etc.) for filtering
5. **No Spoilers**: Sports content omits episode titles
6. **Hardlinks-Ready**: Follow [TRaSH Guides](https://trash-guides.info/) structure for efficient disk usage

## TRaSH Guides Alignment

Our naming conventions follow TRaSH Guides recommendations:

- Single root directory (`/data`)
- Media and downloads on same filesystem
- No spaces in directory names (use hyphens or underscores if needed)
- Lowercase folder names for consistency
- Database IDs for perfect matching

See [Folder Structure Guide](folder-structure.md) for complete setup details.

## Movies

### Folder Structure

```text
/data/media/movies/
├── The Matrix (1999) {tmdb-603}/
│   └── The Matrix (1999) 720p AAC.mkv
├── Inception (2010) {tmdb-27205}/
│   └── Inception (2010) 1080p AAC.mkv
└── Blade Runner (1982) {tmdb-78}/
    ├── Blade Runner (1982) Theatrical 720p AAC.mkv
    └── Blade Runner (1982) Directors Cut 1080p DTS.mkv
```

### Naming Pattern

```text
{Title} ({Year}) {tmdb-ID}/{Title} ({Year}) [Edition] [Resolution] [HDR] [Audio].ext
```

**Examples**:

- `The Matrix (1999) {tmdb-603}/The Matrix (1999) 720p AAC.mkv` (mobile-friendly)
- `Inception (2010) {tmdb-27205}/Inception (2010) 1080p AAC.mkv`
- `Avatar (2009) {tmdb-19995}/Avatar (2009) Extended 720p AAC.mkv`

**Note**: 720p with AAC audio provides best balance for mobile/streaming. Use 1080p+ only when necessary.

### Editions

Detected editions (when applicable):

- `Theatrical`
- `Extended`
- `Director's Cut`
- `Unrated`
- `IMAX`

## TV Shows

### Folder Structure (TVDB)

```text
/data/media/shows/
├── Breaking Bad {tvdb-81189}/
│   ├── Season 01/
│   │   ├── S01E01 - Pilot 720p.mkv
│   │   └── S01E02 - Cat's in the Bag 720p.mkv
│   └── Season 02/
│       └── S02E01-E02 - Seven Thirty-Seven 720p.mkv
└── The Office {tvdb-73244}/
    ├── Season 01/
    └── Season 02/
```

### Naming Pattern

```text
{Series} {tvdb-ID}/Season {NN}/{S##E##[-E##]} - {Title} [Resolution] [Audio].ext
```

**Examples**:

- `Breaking Bad {tvdb-81189}/Season 01/S01E01 - Pilot 720p.mkv` (mobile-friendly)
- `The Office {tvdb-73244}/Season 02/S02E05 - Halloween 720p.mkv`

### Multi-Episode Files

Multi-episode files use range format:

- `S01E01-E02` (two episodes)
- `S01E01-E02-E03` (three episodes)

## Sports

### Folder Structure

```text
/data/sports/
├── UFC/
│   ├── Season 2024/
│   │   ├── S2024E042.mkv
│   │   └── S2024E043.mkv
│   └── Season 2025/
└── WWE/
    └── Season 2024/
```

### Naming Pattern

```text
{Series}/Season {Year}/{SYearE###}.ext
```

**Examples**:

- `UFC/Season 2024/S2024E042.mkv`
- `WWE/Season 2024/S2024E156.mkv`
- `Formula 1/Season 2025/S2025E008.mkv`

**Note**: Episode titles are omitted to avoid spoilers.

## Courses (Educational Content)

### Folder Structure

```text
/data/courses/
├── Python Programming {tvdb-...}/
│   ├── Season 01/
│   │   ├── S01E01 - Introduction to Python.mkv
│   │   └── S01E02 - Variables and Data Types.mkv
│   └── Season 02/
└── Data Structures {tvdb-...}/
    └── Season 01/
```

### Naming Pattern

```text
{Series} {tvdb-ID}/Season {NN}/{S##E##} - {Lesson Title}.ext
```

Courses are organized as TV series for easy Plex library management.

## Music

### Folder Structure

```text
/data/music/
├── Artist Name/
│   ├── Album Name (Year)/
│   │   ├── 01 - Track Title.flac
│   │   └── 02 - Track Title.flac
│   └── Another Album (Year)/
└── Various Artists/
    └── Compilation (Year)/
```

### Naming Pattern

```text
{Artist}/{Album} ({Year})/{Track} - {Title}.ext
```

Multi-disc albums:

```text
{Artist}/{Album} ({Year})/Disc {D}/{D-Track} - {Title}.ext
```

## Audiobooks

### Folder Structure

```text
/data/audiobooks/
├── Author Name/
│   ├── Book Title/
│   │   ├── 01 - Chapter 1.m4b
│   │   └── 02 - Chapter 2.m4b
│   └── Series Name/
│       ├── Book 1 - Title/
│       └── Book 2 - Title/
└── Various Authors/
```

### Naming Pattern

```text
{Author}/{Book Title}/{Part} - {Chapter}.ext
```

## Podcasts

### Folder Structure

```text
/data/podcasts/
├── Podcast Name/
│   ├── 2024-01-15 - Episode Title.mp3
│   └── 2024-01-22 - Episode Title.mp3
└── Another Podcast/
```

### Naming Pattern

```text
{Podcast}/{Date} - {Episode Title}.ext
```

## Quality Badges

### Recommended Resolutions

**Mobile-First Setup** (Best for streaming, smaller files):

- `720p` — Optimal for phones/tablets, efficient bandwidth
- `1080p` — Optional for TVs, larger files

**High-Quality Setup** (Home theater focus):

- `1080p` — Standard for TVs
- `2160p` (4K) — Premium content, large files, requires hardware support

**All Resolutions**:

- `480p`, `720p`, `1080p`, `2160p`

### HDR/Color

- `HDR` (generic HDR)
- `HDR10` (HDR10)
- `HDR10+` (HDR10 Plus)
- `DV` (Dolby Vision)
- `HLG` (Hybrid Log-Gamma)

### Audio

- `AAC` (AAC stereo)
- `DD` (Dolby Digital 5.1)
- `DD+` (Dolby Digital Plus)
- `Atmos` (Dolby Atmos)
- `DTS` (DTS)
- `DTS-HD MA` (DTS-HD Master Audio)
- `TrueHD` (Dolby TrueHD)

### Provider Badges (Optional)

- `AMZN` (Amazon Prime)
- `NF` (Netflix)
- `DSNP` (Disney+)
- `ATV` (Apple TV+)
- `HMAX` (HBO Max)
- `PMTP` (Paramount+)
- `PEACOCK` (Peacock)

## STARR Integration

These naming conventions align with Sonarr/Radarr when using recommended naming tokens:

**Radarr**:

```text
{Movie Title} ({Release Year}) {tmdb-{TmdbId}}/{Movie Title} ({Release Year}) {Edition Tags} {Quality Full}
```

**Sonarr**:

```text
{Series Title} {tvdb-{TvdbId}}/Season {season:00}/{Series Title} - {season:00}x{episode:00} - {Episode Title} {Quality Full}
```

See `docs/starr/` for detailed STARR configuration.

## Plex Matching

### Why ID-Pinned Folders?

Database IDs (`{tmdb-603}`, `{tvdb-81189}`) ensure Plex matches content correctly, even with:

- Foreign titles
- Special characters
- Multiple versions (remakes, reboots)
- Ambiguous names

### Plex Scanner Requirements

- Movies: Folder name must include year: `Movie (2023)`
- TV shows: Season folders must be named `Season 01`, `Season 02`, etc.
- Multi-episode: Use `S01E01-E02` or `S01E01E02` format

## Tips

### Avoid These

❌ Dot separators: `My.Movie.2023.mkv` (use spaces)
❌ Decade tags in folders: `Movies - 2020s/Movie (2023)/`
❌ Excessive metadata: `Movie.2023.BluRay.x264.DTS.1080p.mkv` (in folder name)

### Do This Instead

✅ Clean folders: `Movie (2023) {tmdb-12345}/`
✅ Metadata in filename: `Movie (2023) 1080p DTS.mkv`
✅ ID pins: `{tmdb-...}` or `{tvdb-...}` in folder names

### Testing Renames

Always preview with `--action test` before committing:

```bash
# Linux/macOS
./filebot-rename.sh movies /tmp/input --action test

# Windows
.\filebot-rename.ps1 -Type movies -Input "/path/to/input" -Action test
```

## Troubleshooting

See [Troubleshooting Guide](troubleshooting.md) for naming-related issues.
