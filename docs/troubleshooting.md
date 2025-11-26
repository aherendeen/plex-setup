# Troubleshooting

Common issues and solutions.

## FileBot

### "Command not found"

Ensure FileBot is installed and in PATH:

```bash
filebot -version
```

**Windows**: Add FileBot install directory to System PATH (use `where filebot` to find location)

**Linux/macOS**: Verify installation or create symlink:

```bash
sudo ln -s /opt/filebot/filebot.sh /usr/local/bin/filebot
```

### Not matching files

- Add year to filename: `Movie 2023.mkv`
- Use manual query: `--q "Movie Title"`
- Try different database: `--db TheMovieDB` vs `--db TheTVDB`

### Multi-episode not detected

Use the `episodelist.findAll` hack (see `config/filebot/format-expressions.md`).

## FFmpeg

### Conversion too slow

- Use faster preset: `-preset fast`
- Enable hardware acceleration: `-hwaccel auto` (GPU support varies by OS/hardware)

**Windows/NVIDIA**: Use `-hwaccel cuda -hwaccel_output_format cuda`

**macOS**: Use `-hwaccel videotoolbox`

**Linux/Intel**: Use `-hwaccel vaapi`

### Audio out of sync

- Use `-map 0:v -map 0:a` to preserve all tracks
- Check with `ffprobe -hide_banner -i file.mkv`

## Plex

### Not matching content

- Verify folder includes database ID: `{tmdb-12345}` or `{tvdb-81189}`
- Check season folders are named `Season 01`
- Refresh metadata in Plex: Library → Scan Files

### Wrong metadata

- Fix agent priority: Settings → Agents → [Library Type]
- Move "Plex Movie" or "Plex Series" to top
- Re-scan library

## Kometa

### Collection not updating

- Check `kometa/config/config.yml` → `run_order` includes `collections`
- Verify API keys are set in env
- Check logs: `docker logs kometa`

### Posters not applying

- Ensure `kometa/assets/posters/[Library]/[Collection].jpg` exists
- Check permissions: Kometa user needs read access
- Verify `asset_folders: true` in config

## Hardlinks

### FileBot copying instead of hardlinking

**Cause**: Source and destination on different filesystems.

**Solution**: Ensure media and downloads share same root filesystem:

```text
# Good (same filesystem)
/data/media/movies
/data/torrents/movies

# Bad (different filesystems)
/mnt/disk1/media/movies
/mnt/disk2/torrents/movies
```

See [Folder Structure Guide](folder-structure.md) for optimal layout.

### Verify hardlinks working

```bash
# Linux/macOS
ls -li /data/media/movies/Movie.mkv /data/torrents/movies/Movie.mkv
# Same inode = hardlink

# Windows PowerShell (adjust path to your setup)
fsutil hardlink list "/data/media/movies/Movie.mkv"
```

### Hardlinks not supported on filesystem

**Cause**: Filesystem doesn't support hardlinks (FAT32, exFAT, some network shares).

**Solution**: Use ext4 (Linux), NTFS (Windows), APFS/HFS+ (macOS), or BTRFS/ZFS.

## General

### Paths with spaces

Always quote paths:

```bash
# Linux/macOS
filebot -rename "/data/input" --output "/data/movies"

# Windows PowerShell
filebot -rename "/path/to/input" --output "/data/media/movies"
```

### Permission denied (Linux/Docker)

Fix ownership:

```bash
sudo chown -R $USER:$USER /data
```

### Slow transfers between folders

**Symptom**: FileBot takes long time moving files.

**Cause**: Copying across filesystems instead of atomic move/hardlink.

**Solution**: Use single root directory (`/data`) with media/torrents/usenet subdirs on same filesystem. See [TRaSH Guides](https://trash-guides.info/Hardlinks/Hardlinks-and-Instant-Moves/).
