# FileBot Format Expressions

Production-ready presets with ID-pinned folders, multi-episode support, and TRaSH Guides compliance.

## Quick Start

Import one-liners from `presets/*.format` or use expressions below.

## TV Shows (TVDB)

```groovy
/data/media/shows/{n}{(y && !(n =~ /(?i)\b${y}\b/)) ? " (${y})" : ""} {'{tvdb-' + tvdbid + '}'} / {"Season " + s.pad(2) + ((S && !(S ==~ /(?i)\s*\d+\s*$/)) ? " - " + S : "")} / { def ytag=(y && !(n =~ /(?i)\b${y}\b/)) ? " (${y})" : ""; def name=[ n + ytag, episodes ? episodes*.format('S%02dE%02d').join('-') : s00e00, (t ?: null) ].findAll{ it }.join(' - '); name }{ def srcRaw=(source?:''); def src=srcRaw.toUpperCase().replaceAll(/\s+|[^A-Z0-9]+/,'').replaceAll(/(2160|1080|720|480|360)P?/,''); def resDigits=(vf?:'').replaceAll(/[^0-9]/,''); def res=resDigits?resDigits+'P':''; def aud=(ac?:'').toUpperCase().replaceAll(/\s+|[^A-Z0-9]+/,''); def tag=((fn+' '+srcRaw).toUpperCase().find(/AMZN|AMAZON|DSNP|DISNEY|NF|NETFLIX|HMAX|MAX|HBO|APPLE ?TV\+?|ATV\+?|HULU|PARAMOUNT|PMTP|PEACOCK/)?:''); def prov= tag.matches(/AMZN|AMAZON/)?'AMZN': tag.matches(/DSNP|DISNEY/)?'DSNP': tag.matches(/NF|NETFLIX/)?'NF': tag.matches(/HMAX|MAX|HBO/)?'HMAX': tag.matches(/APPLE ?TV\+?|ATV\+?/)?'ATV': tag.matches(/PARAMOUNT|PMTP/)?'PARA': tag.matches(/HULU/)?'HULU': tag.matches(/PEACOCK/)?'PEACOCK':''; def ch = any{ channels }{ null }; def badge=[res,src,[aud,ch].findAll{it}.join(''),prov].findAll{it}.join('-'); badge?" [${badge}]":"" }
```

**Output**: `/data/media/shows/Breaking Bad {tvdb-81189}/Season 01/Breaking Bad - S01E01 - Pilot [720p-AMZN-AAC].mkv`

**Features**:

- Multi-episode safe: `S01E01-E02` for combined episodes
- Provider detection: AMZN, NF, DSNP, ATV, HMAX, PARA, HULU, PEACOCK
- Quality badges: resolution, source, audio codec
- Year disambiguation when needed

## TV Shows (TMDB)

```groovy
/data/media/shows/{n}{(y && !(n =~ /(?i)\b${y}\b/)) ? " (${y})" : ""} {'{tmdb-' + tmdbid + '}'} / {"Season " + s.pad(2) + ((S && !(S ==~ /(?i)\s*\d+\s*$/)) ? " - " + S : "")} / { def ytag=(y && !(n =~ /(?i)\b${y}\b/)) ? " (${y})" : ""; def name=[ n + ytag, episodes ? episodes*.format('S%02dE%02d').join('-') : s00e00, (t ?: null) ].findAll{ it }.join(' - '); name }{ def srcRaw=(source?:''); def src=srcRaw.toUpperCase().replaceAll(/\s+|[^A-Z0-9]+/,'').replaceAll(/(2160|1080|720|480|360)P?/,''); def resDigits=(vf?:'').replaceAll(/[^0-9]/,''); def res=resDigits?resDigits+'P':''; def aud=(ac?:'').toUpperCase().replaceAll(/\s+|[^A-Z0-9]+/,''); def tag=((fn+' '+srcRaw).toUpperCase().find(/AMZN|AMAZON|DSNP|DISNEY|NF|NETFLIX|HMAX|MAX|HBO|APPLE ?TV\+?|ATV\+?|HULU|PARAMOUNT|PMTP|PEACOCK/)?:''); def prov= tag.matches(/AMZN|AMAZON/)?'AMZN': tag.matches(/DSNP|DISNEY/)?'DSNP': tag.matches(/NF|NETFLIX/)?'NF': tag.matches(/HMAX|MAX|HBO/)?'HMAX': tag.matches(/APPLE ?TV\+?|ATV\+?/)?'ATV': tag.matches(/PARAMOUNT|PMTP/)?'PARA': tag.matches(/HULU/)?'HULU': tag.matches(/PEACOCK/)?'PEACOCK':''; def ch = any{ channels }{ null }; def badge=[res,src,[aud,ch].findAll{it}.join(''),prov].findAll{it}.join('-'); badge?" [${badge}]":"" }
```

**Use TMDB for**: Shows not on TVDB, regional content, newer releases.

## Movies (TMDB)

```groovy
/data/media/movies/{n} ({y}) {'{tmdb-'+tmdbid+'}'/{ def base = n + ' ('+y+')'; def ed = fn.matchAll(/(?i)extended|uncensored|remastered|unrated|uncut|director'?s?.cut|special.edition|redux|imax/)*.upperInitial()*.lowerTrail().unique().join(', '); def srcRaw=(source?:''); def src=srcRaw.toUpperCase().replaceAll(/\s+|[^A-Z0-9]+/,'').replaceAll(/(2160|1080|720|480|360)P?/,''); def res=(vf?:'').replaceAll(/[^0-9]/,''); res = res ? res+'P' : ''; def aud=(ac?:'').toUpperCase().replaceAll(/\s+|[^A-Z0-9]+/,''); def ch = any{ channels }{ null }; def prov=((fn+' '+srcRaw).toUpperCase().find(/AMZN|AMAZON|DSNP|DISNEY|NF|NETFLIX|HMAX|MAX|HBO|APPLE ?TV\+?|ATV\+?|HULU|PARAMOUNT|PMTP|PEACOCK/)?:''); def p= prov.matches(/AMZN|AMAZON/)?'AMZN': prov.matches(/DSNP|DISNEY/)?'DSNP': prov.matches(/NF|NETFLIX/)?'NF': prov.matches(/HMAX|MAX|HBO/)?'HMAX': prov.matches(/APPLE ?TV\+?|ATV\+?/)?'ATV': prov.matches(/PARAMOUNT|PMTP/)?'PARA': prov.matches(/HULU/)?'HULU': prov.matches(/PEACOCK/)?'PEACOCK':''; def badge=[res,src,[aud,ch].findAll{it}.join(''),p].findAll{it}.join('-'); [ base, ed? '('+ed+')':null, '{tmdb-'+tmdbid+'}', badge? '['+badge+']':null ].findAll{it}.join(' ') }
```

**Output**: `/data/media/movies/Blade Runner (1982) {tmdb-78}/Blade Runner (1982) Directors Cut [720p-AAC].mkv`

**Note**: 720p is optimal for mobile streaming; 1080p for home theater.

**Features**:

- Edition detection: Extended, Director's Cut, IMAX, Unrated, Redux, etc.
- TMDB ID in folder for Plex matching
- Multiple editions in same folder supported

## Sports (No Spoilers)

```groovy
/data/media/sports/{n}/{"Season "+s.pad(2)}/{n} - {s00e00}{' ['+vf+']'}
```

**Output**: `/data/media/sports/UFC/Season 2024/UFC - S2024E042 [720p].mkv`

**Features**:

- No episode titles (avoids spoilers)
- Year-based seasons
- Resolution badge only

## Courses (TV Structure)

```groovy
/data/media/courses/{n}{(y && !(n =~ /(?i)\b${y}\b/)) ? " (${y})" : ""}/Season {s.pad(2)}/{n} - S{s.pad(2)}E{e.pad(2)} - {t}
```

**Output**: `/data/media/courses/Python Programming/Season 01/Python Programming - S01E01 - Introduction.mkv`

## Testing

```bash
# Test without moving files
filebot -rename "input/" --db TheTVDB --format "@config/filebot/presets/tv-tvdb.format" --action test

# Execute rename
filebot -rename "input/" --db TheTVDB --format "@config/filebot/presets/tv-tvdb.format" --action move
```

## Customization

### Change Base Path

Edit `DATA_ROOT` in `config/paths.env`, or modify presets directly:

```groovy
/custom/path/movies/{n} ({y})...
```

### Disable Badges

Remove badge block from expression:

```groovy
# Remove this section:
{ def srcRaw=(source?:''); ... badge?" [${badge}]":"" }
```

### Custom Provider Tags

Add to provider detection regex:

```groovy
find(/AMZN|...|CUSTOM_TAG/)
```

## References

- [FileBot Documentation](https://www.filebot.net/naming.html)
- [TRaSH Guides](https://trash-guides.info/)
- [Groovy String Docs](https://groovy-lang.org/strings.html)
