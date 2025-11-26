# Kometa Templates

Starter YAML configurations for Kometa collections, overlays, and metadata.

## Quick Start

1. Copy templates to your Kometa config directory
2. Customize paths and settings
3. Reference in your main `config.yml`

## Available Templates

Add your custom templates here:

```text
templates/
├── collections/
│   ├── movies.yml      # Movie collections
│   └── tv.yml          # TV show collections
├── overlays/
│   └── resolution.yml  # Resolution/HDR overlays
└── metadata/
    └── studios.yml     # Studio metadata
```

## Resources

- [Kometa Defaults](https://github.com/Kometa-Team/Kometa/tree/master/defaults) - Built-in configs
- [Community Configs](https://github.com/Kometa-Team/Community-Configs) - User-contributed templates
- [Kometa Wiki](https://metamanager.wiki/) - Full documentation

## Example Collection

```yaml
collections:
  Best of 2024:
    plex_search:
      all:
        year: 2024
        audience_rating.gte: 8.0
    sort_title: "!01_Best of 2024"
    summary: "Top rated movies from 2024"
```
