# FileBot Usage Guide

Complete guide to using FileBot for renaming media files with Plex-optimized presets.

## Why FileBot?

FileBot provides:

- **Hardlink Support**: Move files without duplicating (save disk space)
- **Database Matching**: Accurate metadata from TMDB/TVDB
- **Batch Processing**: Rename entire libraries efficiently
- **Custom Formats**: Full control over naming schemes

## Hardlinks & Atomic Moves

When media and downloads are on the same filesystem, FileBot can hardlink instead of copy:

- **Hardlink**: Same file, two paths (instant, no space used)
- **Atomic Move**: Instant rename within same filesystem
- **Copy**: Duplicate file, slow, double space

See [Folder Structure Guide](folder-structure.md) for optimal layout following [TRaSH Guides](https://trash-guides.info/).

## Quick Reference

### Linux/macOS

```bash
# Test mode (safe preview)
./filebot-rename.sh movies /data/media/movies --action test

# Execute rename
./filebot-rename.sh movies /data/media/movies --action move
```

### Windows

```powershell
# Test mode (safe preview)
.\filebot-rename.ps1 -Type movies -Input "D:\data\media\movies" -Action test

# Execute rename
.\filebot-rename.ps1 -Type movies -Input "D:\data\media\movies" -Action move
```

## Content Types

### Movies

**Linux/macOS:**

```bash
./filebot-rename.sh movies /data/media/movies
```

**Windows:**

```powershell
.\filebot-rename.ps1 -Type movies -Input "D:\data\media\movies"
```

**Output format**: `{DATA_ROOT}/movies/{Title} ({Year}) {tmdb-12345}/Movie.mkv`

Features:

- TMDB ID-pinned folders for perfect Plex matching
- Edition detection (Theatrical, Director's Cut, Extended, etc.)
- Quality badges (720p, 1080p)
- Audio format badges (AAC for mobile, DTS/Atmos for home theater)
- Optional provider badges (AMZN, NF, DSNP, ATV, HMAX, PMTP, PEACOCK)

**Recommendation**: Use 720p with AAC for mobile-first setup (smaller files, faster streaming).

### TV Shows (TVDB)

**Linux/macOS:**

```bash
./filebot-rename.sh tv-tvdb /data/media/shows
```

**Windows:**

```powershell
.\filebot-rename.ps1 -Type tv-tvdb -Input "D:\data\media\shows"
```

**Output format**: `{DATA_ROOT}/shows/{Series} {tvdb-81189}/Season 01/S01E01-E02 - Title.mkv`

Features:

- TVDB ID-pinned folders
- Multi-episode support (`S01E01-E02-E03`)
- Full season and quality info

### TV Shows (TMDB)

**Linux/macOS:**

```bash
./filebot-rename.sh tv-tmdb /data/media/shows
```

**Windows:**

```powershell
.\filebot-rename.ps1 -Type tv-tmdb -Input "D:\data\media\shows"
```

Same as TVDB but uses TMDB database (better for some newer/regional shows).

### Sports

**Linux/macOS:**

```bash
./filebot-rename.sh sports /data/media/sports
```

**Windows:**

```powershell
.\filebot-rename.ps1 -Type sports -Input "D:\data\media\sports"
```

**Output format**: `{DATA_ROOT}/sports/{Series}/Season 2024/S2024E042.mkv`

Features:

- No episode titles (avoids spoilers)
- Year-based seasons
- Clean numbering

### Courses

**Linux/macOS:**

```bash
./filebot-rename.sh courses /data/media/courses
```

**Windows:**

```powershell
.\filebot-rename.ps1 -Type courses -Input "D:\data\media\courses"
```

**Output format**: `{DATA_ROOT}/courses/{Series}/Season 01/S01E01 - Lesson.mkv`

Treats educational content as TV series for easy Plex library organization.

## Advanced Usage

### Manual Query

Force specific title match:

```bash
filebot -rename /input \
  --db TheMovieDB \
  --q "The Matrix" \
  --format "@config/filebot/presets/movies.format" \
  --action test
```

### Strict Mode

Only rename if confident match:

```bash
filebot -rename /input \
  --db TheMovieDB \
  --format "@config/filebot/presets/movies.format" \
  -strict \
  --action test
```

### Filter by Extension

Only process specific file types:

```bash
filebot -rename /input \
  --db TheMovieDB \
  --format "@config/filebot/presets/movies.format" \
  --filter "f.video && f.ext =~ /mkv|mp4/" \
  --action test
```

### Custom Output Directory

Override output path:

```bash
filebot -rename /input \
  --output /custom/output/path \
  --db TheMovieDB \
  --format "@config/filebot/presets/movies.format" \
  --action move
```

## Tips

### Always Preview First

Use `--action test` to see what will happen before making changes:

```bash
./filebot-rename.sh movies /input --action test
```

Review the output, then run with `--action move`.

### Check Logs

Logs are saved to `logs/` directory:

- `movies.log`
- `tv-tvdb.log`
- `tv-tmdb.log`
- `sports.log`
- `courses.log`

### Fixing Mismatches

If FileBot picks wrong match:

1. Add year to filename: `Movie 2023.mkv`
2. Use manual query: `--q "Correct Title"`
3. Try alternate database (TVDB vs TMDB)

### Multi-Episode Detection

FileBot auto-detects multi-episode files if named properly:

- `Show.S01E01E02.mkv` → `S01E01-E02`
- `Show.S01E01-E02.mkv` → `S01E01-E02`
- `Show.1x01-1x02.mkv` → `S01E01-E02`

**Troubleshooting multi-episode detection**:

If FileBot treats multi-episode file as single episode, use `episodelist.findAll` in format expression:

```groovy
{ episodes ? episodes*.format('S%02dE%02d').join('-') : s00e00 }
```

Our presets include this fix by default.

## Format Expressions

Formats are stored in `config/filebot/presets/`:

- `movies.format` — Movies (TMDB)
- `tv-tvdb.format` — TV Shows (TVDB)
- `tv-tmdb.format` — TV Shows (TMDB)
- `sports.format` — Sports (no spoilers)
- `courses.format` — Educational content

To customize, edit the format files directly or see `config/filebot/format-expressions.md` for details.

## Troubleshooting

See [Troubleshooting Guide](troubleshooting.md#filebot) for common issues.
