# FFmpeg Recipes

Common FFmpeg commands for video processing, conversion, and optimization.

## Codec Recommendations

### When to Transcode

Generally, avoid transcoding unless necessary:

- **Direct play** is always better (original quality, no processing)
- Transcode only for compatibility or space savings
- Follow [TRaSH Guides Custom Formats](https://trash-guides.info/Radarr/Radarr-collection-of-custom-formats/) for quality tiers

### Codec Priorities

1. **H.265 (HEVC)**: Best compression, smaller files, broad device support
2. **H.264 (AVC)**: Maximum compatibility, larger files
3. **AV1**: Future-proof, excellent compression, limited device support (2024)

### Audio Codec Priorities

1. **AAC**: Best for mobile, universal compatibility, efficient streaming
2. **TrueHD/Atmos**: Home theater (lossless), large files
3. **DTS-HD MA**: Home theater (lossless)
4. **Opus**: Best lossy codec for lower bitrates

### Resolution Recommendations

**Mobile-First Setup** (recommended for most users):

- **720p**: Optimal quality/size ratio for phones, tablets, laptops
- **Bitrate**: 2-4 Mbps video, 128-192k AAC audio
- **Benefits**: Fast streaming, low bandwidth, smaller storage

**Home Theater Setup**:

- **1080p**: Standard for TVs, higher bitrate (5-8 Mbps)
- **Higher resolutions**: Possible but requires powerful hardware, larger storage

**Default recommendation**: Encode to 720p H.264 + AAC for best compatibility and size.

## Quick Reference

### Convert to H.264 (MP4)

```bash
ffmpeg -i input.mkv -c:v libx264 -preset medium -crf 23 -c:a aac -b:a 192k output.mp4
```

### Convert to H.265 (HEVC)

```bash
ffmpeg -i input.mkv -c:v libx265 -preset medium -crf 28 -c:a aac -b:a 192k output.mp4
```

### Extract Subtitles

```bash
# Extract first subtitle stream
ffmpeg -i input.mkv -map 0:s:0 output.srt

# Extract all subtitles
ffmpeg -i input.mkv -map 0:s -c copy subs
```

### Extract Audio

```bash
# Extract first audio stream
ffmpeg -i input.mkv -vn -map 0:a:0 -c:a copy audio.aac

# Extract to MP3
ffmpeg -i input.mkv -vn -map 0:a:0 -c:a libmp3lame -b:a 320k audio.mp3
```

### Batch Processing

```bash
# Linux/macOS
for f in *.mkv; do
    ffmpeg -i "$f" -c:v libx264 -preset medium -crf 23 -c:a aac -b:a 192k "${f%.mkv}.mp4"
done

# Windows PowerShell
Get-ChildItem *.mkv | ForEach-Object {
    ffmpeg -i $_.FullName -c:v libx264 -preset medium -crf 23 -c:a aac -b:a 192k "$($_.BaseName).mp4"
}
```

## Quality Presets

### High Quality (Archival)

```bash
ffmpeg -i input.mkv \
  -c:v libx264 \
  -preset slow \
  -crf 18 \
  -c:a aac \
  -b:a 256k \
  output.mp4
```

- **CRF 18**: Near-lossless quality
- **Preset slow**: Better compression, slower encoding
- **AAC 256k**: High audio quality

### Balanced (Recommended - Mobile-First)

```bash
ffmpeg -i input.mkv \
  -c:v libx264 \
  -preset medium \
  -crf 23 \
  -vf "scale=-2:720" \
  -c:a aac \
  -b:a 128k \
  output.mp4
```

- **720p**: Optimal for mobile streaming
- **CRF 23**: Default quality (good balance)
- **Preset medium**: Balanced speed/compression
- **AAC 128k**: Efficient audio for mobile

### TV/Desktop Quality

```bash
ffmpeg -i input.mkv \
  -c:v libx264 \
  -preset medium \
  -crf 21 \
  -vf "scale=-2:1080" \
  -c:a aac \
  -b:a 192k \
  output.mp4
```

- **1080p**: Standard for TVs
- **CRF 21**: Slightly higher quality
- **AAC 192k**: Standard audio quality

### Fast (Quick Mobile Encode)

```bash
ffmpeg -i input.mkv \
  -c:v libx264 \
  -preset fast \
  -crf 24 \
  -vf "scale=-2:720" \
  -c:a aac \
  -b:a 128k \
  output.mp4
```

- **720p**: Mobile-friendly resolution
- **CRF 24**: Efficient quality
- **Preset fast**: Quick encoding
- **AAC 128k**: Low audio bitrate

## Hardware Acceleration

### NVIDIA (CUDA)

```bash
ffmpeg -hwaccel cuda -hwaccel_output_format cuda -i input.mkv \
  -c:v h264_nvenc \
  -preset p4 \
  -cq 23 \
  -c:a aac -b:a 192k \
  output.mp4
```

### Intel (QuickSync)

```bash
ffmpeg -hwaccel qsv -c:v h264_qsv -i input.mkv \
  -c:v h264_qsv \
  -preset medium \
  -global_quality 23 \
  -c:a aac -b:a 192k \
  output.mp4
```

### macOS (VideoToolbox)

```bash
ffmpeg -hwaccel videotoolbox -i input.mkv \
  -c:v h264_videotoolbox \
  -b:v 5M \
  -c:a aac -b:a 192k \
  output.mp4
```

### Linux (VAAPI)

```bash
ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 \
  -hwaccel_output_format vaapi -i input.mkv \
  -c:v h264_vaapi \
  -qp 23 \
  -c:a aac -b:a 192k \
  output.mp4
```

## Advanced Operations

### Normalize Audio

```bash
# Two-pass loudness normalization
ffmpeg -i input.mkv -af loudnorm=print_format=json -f null -

# Apply measured values
ffmpeg -i input.mkv \
  -af loudnorm=I=-16:TP=-1.5:LRA=11:measured_I=-27:measured_TP=-5.3:measured_LRA=15 \
  -c:v copy -c:a aac -b:a 192k \
  output.mkv
```

### Resize Video

```bash
# Scale to 1080p
ffmpeg -i input.mkv -vf scale=1920:1080 -c:v libx264 -preset medium -crf 23 output.mp4

# Scale maintaining aspect ratio
ffmpeg -i input.mkv -vf scale=1920:-1 -c:v libx264 -preset medium -crf 23 output.mp4
```

### Burn Subtitles

```bash
# Burn first subtitle stream
ffmpeg -i input.mkv -vf subtitles=input.mkv -c:v libx264 -preset medium -crf 23 output.mp4

# Burn external SRT
ffmpeg -i input.mkv -vf subtitles=subs.srt -c:v libx264 -preset medium -crf 23 output.mp4
```

### Trim Video

```bash
# Cut from 00:01:30 for 60 seconds
ffmpeg -ss 00:01:30 -t 00:01:00 -i input.mkv -c copy output.mkv

# Cut from 00:01:30 to end
ffmpeg -ss 00:01:30 -i input.mkv -c copy output.mkv
```

### Concatenate Videos

```bash
# Create file list
echo "file 'part1.mkv'" > list.txt
echo "file 'part2.mkv'" >> list.txt
echo "file 'part3.mkv'" >> list.txt

# Concatenate
ffmpeg -f concat -safe 0 -i list.txt -c copy output.mkv
```

### Convert HDR to SDR

```bash
ffmpeg -i input_hdr.mkv \
  -vf zscale=t=linear:npl=100,format=gbrpf32le,zscale=p=bt709,tonemap=tonemap=hable:desat=0,zscale=t=bt709:m=bt709:r=tv,format=yuv420p \
  -c:v libx264 -preset medium -crf 23 \
  -c:a copy \
  output_sdr.mp4
```

## Inspection

### Get Video Info

```bash
ffprobe -hide_banner -i input.mkv
```

### Get Detailed Streams

```bash
ffprobe -hide_banner -show_streams -i input.mkv
```

### Get Format Info

```bash
ffprobe -hide_banner -show_format -i input.mkv
```

### Get Duration

```bash
ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 input.mkv
```

## Tips

### CRF Values

- **0**: Lossless (huge files)
- **17-18**: Visually lossless
- **23**: Default (recommended)
- **28**: Acceptable quality
- **35+**: Low quality

Lower CRF = higher quality + larger file size.

### Presets

- **ultrafast**: Fastest, largest files
- **fast**: Quick, decent compression
- **medium**: Default (balanced)
- **slow**: Better compression, slower
- **veryslow**: Best compression, very slow

### Check Hardware Support

```bash
# List available encoders
ffmpeg -encoders | grep -i nvenc  # NVIDIA
ffmpeg -encoders | grep -i qsv    # Intel
ffmpeg -encoders | grep -i videotoolbox  # macOS
ffmpeg -encoders | grep -i vaapi  # Linux
```

## Troubleshooting

See [Troubleshooting Guide](troubleshooting.md#ffmpeg) for common issues.
