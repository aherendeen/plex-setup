# MP3Tag Format Presets

Format strings for MP3Tag: Convert → Tag - Filename or Actions.

## Music (Standard)

Single disc albums:

```text
$replace(%_path%,%_filename_ext%,)%albumartist%\%album% (%year%)\$num(%track%,2) - %artist% - %title%
```

Multi-disc albums:

```text
$replace(%_path%,%_filename_ext%,)%albumartist%\%album% (%year%)\CD$num(%discnumber%,1)\$num(%track%,2) - %artist% - %title%
```

## Audiobooks

```text
$replace(%_path%,%_filename_ext%,)$if2(%albumartist%,%artist%)\%album%$if(%year%, (%year%),)\$num(%track%,2) - $if2(%albumartist%,%artist%) - %album%$if(%title%, - %title%,)
```

## Podcasts

```text
$replace(%_path%,%_filename_ext%,)%album%\%album% - $num(%track%,3) - %title%
```

## Classical Music

With composer and conductor:

```text
$replace(%_path%,%_filename_ext%,)%composer%\%album% (%year%) - %conductor%\$num(%track%,2) - %title%
```

## Soundtracks

```text
$replace(%_path%,%_filename_ext%,)Soundtracks\%album% (%year%)\$num(%track%,2) - %artist% - %title%
```

## Compilation Albums

```text
$replace(%_path%,%_filename_ext%,)Compilations\%album% (%year%)\$num(%track%,2) - %artist% - %title%
```

## Usage

1. **Convert → Tag - Filename**: Paste format string
2. **Preview**: Check output before applying
3. **Convert**: Execute rename

For repeated use, save as Action:

1. **Convert → Actions**
2. **New Action Group**
3. **Add Action**: Format value (from Tag-Filename template)
4. **Save** with descriptive name

## Path Configuration

These formats use `$replace(%_path%,%_filename_ext%,)` to maintain current directory structure. To change base path, modify in MP3Tag settings:

**Tools → Options → Directories**: Set your music root directory.

## Validation

After tagging, verify:

- Track numbers padded correctly
- Year in parentheses
- No invalid filename characters
- Proper artist/albumartist distinction

## Advanced

### Custom Separators

Replace ` - ` with custom separator:

```text
%albumartist%\%album% (%year%)\$num(%track%,2). %artist%. %title%
```

### Feat. Artist Handling

```text
$num(%track%,2) - $regexp(%artist%, \(feat.*\),,1) - %title%
```

Removes "(feat. ...)" from filenames.

### Various Artists

```text
$if($eql(%albumartist%,Various Artists),Various Artists\%album% (%year%)\$num(%track%,2) - %artist% - %title%,%albumartist%\%album% (%year%)\$num(%track%,2) - %title%)
```
