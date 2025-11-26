# Contributing

Pull requests are welcome!

## Guidelines

### Code Style

- Follow existing code style and formatting
- Use meaningful variable names
- Add comments for complex logic
- Keep functions focused and modular

### Path Structure

- Follow [TRaSH Guides](https://trash-guides.info/) standards
- Use `/data` root structure in examples
- Avoid hardcoded personal paths
- Test with `paths.env` configuration system

### Documentation

- Update relevant `.md` files for new features
- Include usage examples
- Add troubleshooting section if applicable
- Reference TRaSH Guides where relevant

### Testing Workflow

#### FileBot Formats

Test all format changes with `--action test`:

```bash
# Test TV shows
filebot -rename "test/shows/" \
  --db TheTVDB \
  --format "@config/filebot/presets/tv-tvdb.format" \
  --action test

# Test movies
filebot -rename "test/movies/" \
  --db TheMovieDB \
  --format "@config/filebot/presets/movies.format" \
  --action test
```

Verify output:

- Database IDs present in folder names
- Multi-episode detection works
- Quality badges parse correctly
- Season folders named properly

#### Scripts

Test wrapper scripts on target platforms:

- **Windows**: PowerShell 5.1+ and PowerShell 7+
- **Linux**: bash, zsh
- **macOS**: zsh (default), bash

Check:

- Path handling (spaces, special characters)
- Error messages are clear
- Logging works correctly
- ENV variables load properly

#### Docker Configs

Validate Docker Compose files:

```bash
# Check syntax
docker-compose config

# Test build
docker-compose build

# Test run
docker-compose up -d
docker-compose logs
```

Verify:

- Volume mappings use correct paths
- Environment variables load from `.env`
- Services start without errors
- Logs are accessible

## Submitting

1. **Fork the repo**: Click "Fork" on GitHub
2. **Clone your fork**:

   ```bash
   git clone https://github.com/aherendeen/plex-setup.git
   cd plex-setup
   ```

3. **Create feature branch**:

   ```bash
   git checkout -b feature/amazing-feature
   ```

4. **Make changes and test** (see Testing Workflow above)
5. **Commit with clear message**:

   ```bash
   git commit -m "Add amazing feature
   
   - Improves X by doing Y
   - Adds Z configuration
   - Updates docs for feature"
   ```

6. **Push to your fork**:

   ```bash
   git push origin feature/amazing-feature
   ```

7. **Open pull request** on GitHub with:
   - Description of changes
   - Testing performed
   - Related issues (if any)

## PR Review Checklist

Before submitting, ensure:

- [ ] Code follows existing style
- [ ] All paths follow TRaSH Guides structure
- [ ] Documentation updated
- [ ] Tested on at least one platform
- [ ] No personal/sensitive info in commits
- [ ] Commit messages are clear
- [ ] PR description explains changes

## Questions?

Open an issue for:

- Feature requests
- Bug reports
- Documentation improvements
- General questions

Thank you for contributing! 🎉
