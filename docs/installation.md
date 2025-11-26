# Installation Guide

Platform-specific instructions for installing FileBot, FFmpeg, ImageMagick, and Docker.

## Table of Contents

- [Windows](#windows)
- [macOS](#macos)
- [Linux](#linux)
  - [Ubuntu/Debian](#ubuntudebian)
  - [Alpine Linux](#alpine-linux)
  - [Proxmox/LXC](#proxmoxlxc)
- [Docker](#docker)

---

## Windows

### Using Winget (Recommended)

```powershell
# Run in PowerShell as Administrator
winget install FileBot
winget install FFmpeg
winget install ImageMagick
```

### Using Chocolatey

```powershell
choco install filebot ffmpeg imagemagick
```

### Manual Installation

- **FileBot**: Download from [filebot.net](https://www.filebot.net/)
- **FFmpeg**: Download from [ffmpeg.org](https://ffmpeg.org/download.html#build-windows)
- **ImageMagick**: Download from [imagemagick.org](https://imagemagick.org/script/download.php#windows)

Verify installation (tools should be in PATH):

```powershell
filebot -version
ffmpeg -version
magick -version
```

---

## macOS

### Using Homebrew (Recommended)

```bash
brew install filebot ffmpeg imagemagick
```

### Using MacPorts

```bash
sudo port install filebot ffmpeg imagemagick
```

### Manual Installation

- **FileBot**: Download from [filebot.net](https://www.filebot.net/)
- Install FFmpeg and ImageMagick from official sites or use package managers

### Verify Installation

```bash
filebot -version
ffmpeg -version
magick -version
```

---

## Linux

### Ubuntu/Debian

```bash
# Update package lists
sudo apt update

# Install FileBot (add PPA)
sudo add-apt-repository ppa:filebot/filebot
sudo apt update
sudo apt install filebot

# Install FFmpeg and ImageMagick
sudo apt install ffmpeg imagemagick

# Verify
filebot -version
ffmpeg -version
magick -version
```

### Alpine Linux

```bash
# Add community repository (if not already enabled)
echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

# Update and install
apk update
apk add openjdk11 ffmpeg imagemagick bash

# Install FileBot manually (no official Alpine package)
# Download from filebot.net and extract
wget https://get.filebot.net/filebot/FileBot_5.1.3/FileBot_5.1.3-portable.tar.xz
tar -xf FileBot_5.1.3-portable.tar.xz
ln -s /opt/filebot/filebot.sh /usr/local/bin/filebot

# Verify
filebot -version
ffmpeg -version
magick -version
```

### Proxmox/LXC

For Proxmox LXC containers, follow the Ubuntu/Debian instructions above. Ensure your container has:

- Sufficient privileges (unprivileged containers may need adjustments)
- Mounted media directories (add mount points in Proxmox UI)

Example LXC mount in `/etc/pve/lxc/<CTID>.conf`:

```text
mp0: /mnt/media,mp=/mnt/data/media
```

---

## Docker

Docker is optional but recommended for Kometa and other services.

### Docker on Windows

Download and install [Docker Desktop for Windows](https://docs.docker.com/desktop/install/windows-install/)

### Docker on macOS

Download and install [Docker Desktop for Mac](https://docs.docker.com/desktop/install/mac-install/)

### Docker on Linux

```bash
# Ubuntu/Debian
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Alpine
apk add docker docker-compose
rc-update add docker boot
service docker start

# Verify
docker --version
docker-compose --version
```

---

## Post-Installation

After installing tools, configure your environment:

1. **Copy example config**:

   ```bash
   cp config/paths.env.example config/paths.env
   ```

2. **Edit paths** to match your system:

   ```bash
   # Linux/macOS
   nano config/paths.env
   
   # Windows
   notepad config\paths.env
   ```

3. **Set up optimal folder structure**:

   See [Folder Structure Guide](folder-structure.md) for TRaSH Guides-compliant layout. Key points:
   
   - Use single root directory (`/data`)
   - Keep media, torrents, and usenet on same filesystem
   - Enable hardlinks for efficient disk usage
   - Avoid spaces in directory names

4. **Test FileBot**:

   **Linux/macOS:**

   ```bash
   ./filebot-rename.sh movies /data/media/movies --action test
   ```

   **Windows:**

   ```powershell
   .\filebot-rename.ps1 -Type movies -Input "D:\data\media\movies" -Action test
   ```

## Next Steps

- Review [FileBot Guide](filebot-guide.md) for detailed usage
- Check [Naming Guide](naming-guide.md) for conventions
- Configure Sonarr/Radarr following [TRaSH Guides](https://trash-guides.info/)

## Troubleshooting

See [Troubleshooting Guide](troubleshooting.md) for common installation issues.
