# Scripts

Automation and helper scripts for media processing workflows.

## Included

### Root Scripts

- `filebot-rename.sh` - FileBot wrapper (Linux/macOS)
- `filebot-rename.ps1` - FileBot wrapper (Windows)

These scripts simplify FileBot invocation by automatically loading presets and logging output.

## Custom Scripts

Add custom automation here. Common use cases:

### Batch FFmpeg Encoding

```bash
#!/usr/bin/env bash
# Encode all MKVs in directory to H.264
for f in "$1"/*.mkv; do
    ffmpeg -i "$f" -c:v libx264 -preset medium -crf 23 -c:a aac -b:a 192k "${f%.mkv}.mp4"
done
```

### Scheduled Kometa Execution

```bash
#!/usr/bin/env bash
# Run Kometa via Docker
cd /path/to/plex-setup/docker
docker-compose run --rm kometa
```

### Post-Processing Hook (Plex Scan)

```bash
#!/usr/bin/env bash
# Trigger Plex library scan after FileBot completes
# Replace LIBRARY_ID and TOKEN with your values
curl -X POST "http://localhost:32400/library/sections/LIBRARY_ID/refresh?X-Plex-Token=TOKEN"
```

### Hardlink Verification

```bash
#!/usr/bin/env bash
# Check if two files are hardlinked (Linux/macOS)
file1="$1"
file2="$2"

inode1=$(ls -i "$file1" | awk '{print $1}')
inode2=$(ls -i "$file2" | awk '{print $1}')

if [ "$inode1" = "$inode2" ]; then
    echo "✓ Files are hardlinked"
else
    echo "✗ Files are NOT hardlinked"
fi
```

## Best Practices

- Use absolute paths in scripts
- Follow [TRaSH Guides](https://trash-guides.info/) folder structure
- Make scripts executable: `chmod +x script.sh`
- Log output for debugging: `script.sh 2>&1 | tee -a script.log`
- Test with small datasets before batch operations
- Use `--action test` for FileBot operations before `--action move`

## Platform-Specific Notes

### Linux/macOS (Bash/Zsh)

- Use shebang: `#!/usr/bin/env bash`
- Check bash version: `bash --version` (4.0+ recommended)
- Use `"${variable}"` for paths with spaces

### Windows (PowerShell)

- Use `.ps1` extension
- Run as Administrator when needed
- Set execution policy if blocked: `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`
- Use `"$variable"` for paths with spaces


