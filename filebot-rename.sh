#!/usr/bin/env bash
# ========================================================================
# FileBot Rename Script - Cross-Platform
# Usage: ./filebot-rename.sh <type> <input-folder>
# Types: movies, tv-tvdb, tv-tmdb, sports, courses
# ========================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${SCRIPT_DIR}/config"
LOGS_DIR="${SCRIPT_DIR}/logs"

# Load paths if available
if [[ -f "${CONFIG_DIR}/paths.env" ]]; then
    source "${CONFIG_DIR}/paths.env"
fi

# Ensure logs directory exists
mkdir -p "${LOGS_DIR}"

usage() {
    echo "Usage: $0 <type> <input-folder> [--action test|move]"
    echo ""
    echo "Types:"
    echo "  movies      - Rename movies (TMDB)"
    echo "  tv-tvdb     - Rename TV shows (TVDB)"
    echo "  tv-tmdb     - Rename TV shows (TMDB)"
    echo "  sports      - Rename sports (no spoilers)"
    echo "  courses     - Rename courses as TV"
    echo ""
    echo "Examples:"
    echo "  $0 movies /path/to/movies --action test"
    echo "  $0 tv-tvdb /path/to/shows --action move"
    exit 1
}

# Check arguments
[[ $# -lt 2 ]] && usage

TYPE="$1"
INPUT="$2"
ACTION="${3:---action}"
ACTION_MODE="${4:-test}"

# Validate type and set format
case "$TYPE" in
    movies)
        DB="TheMovieDB"
        FORMAT="@${CONFIG_DIR}/filebot/presets/movies.format"
        LOG="${LOGS_DIR}/movies.log"
        ;;
    tv-tvdb)
        DB="TheTVDB"
        FORMAT="@${CONFIG_DIR}/filebot/presets/tv-tvdb.format"
        LOG="${LOGS_DIR}/tv-tvdb.log"
        ;;
    tv-tmdb)
        DB="TheMovieDB"
        FORMAT="@${CONFIG_DIR}/filebot/presets/tv-tmdb.format"
        LOG="${LOGS_DIR}/tv-tmdb.log"
        ;;
    sports)
        DB="TheTVDB"
        FORMAT="@${CONFIG_DIR}/filebot/presets/sports.format"
        LOG="${LOGS_DIR}/sports.log"
        ;;
    courses)
        DB="TheTVDB"
        FORMAT="@${CONFIG_DIR}/filebot/presets/courses.format"
        LOG="${LOGS_DIR}/courses.log"
        ;;
    *)
        echo "Error: Unknown type '$TYPE'"
        usage
        ;;
esac

# Run FileBot
echo "FileBot: Renaming $TYPE..."
echo "Input: $INPUT"
echo "Database: $DB"
echo "Action: $ACTION_MODE"
echo "Log: $LOG"
echo ""

filebot -rename "$INPUT" \
    --db "$DB" \
    --format "$FORMAT" \
    -non-strict \
    --log-file "$LOG" \
    "$ACTION" "$ACTION_MODE"

echo ""
echo "Done! Check log: $LOG"
