#!/usr/bin/env bash
# Shared helpers for the mise tasks in ../mise.toml. Source this file, do not run it.
set -euo pipefail

ROOT="${MISE_CONFIG_ROOT:?run this through mise (mise run <task>)}"
HF_VERSION="${HYPERFRAMES_VERSION:?HYPERFRAMES_VERSION is set in mise.toml}"

# The pinned HyperFrames CLI. Every project renders with the same engine version.
hf() { npx --yes "hyperframes@${HF_VERSION}" "$@"; }

# A project is any direct subfolder that has a hyperframes.json.
list_projects() {
  local f
  for f in "$ROOT"/*/hyperframes.json; do
    [ -e "$f" ] && basename "$(dirname "$f")"
  done
  return 0
}

# resolve_project [name] -> sets PROJECT and PROJECT_DIR.
# With no name it uses the only project, or lists them and stops.
resolve_project() {
  local name="${1:-}"
  if [ -z "$name" ]; then
    local all count
    all="$(list_projects)"
    count="$(printf '%s\n' "$all" | grep -c . || true)"
    if [ "$count" -eq 1 ]; then
      name="$all"
    else
      echo "Which project? Pass one of:" >&2
      printf '  %s\n' $all >&2
      exit 1
    fi
  fi
  name="${name%/}"
  if [ ! -f "$ROOT/$name/hyperframes.json" ]; then
    echo "'$name' is not a HyperFrames project (no hyperframes.json in $ROOT/$name)." >&2
    exit 1
  fi
  PROJECT="$name"
  PROJECT_DIR="$ROOT/$name"
}

# landscape | portrait | square, read from the root composition's data-width/data-height.
orientation() {
  local w h
  w="$(grep -oE 'data-width="[0-9]+"' "$PROJECT_DIR/index.html" | head -1 | grep -oE '[0-9]+' || true)"
  h="$(grep -oE 'data-height="[0-9]+"' "$PROJECT_DIR/index.html" | head -1 | grep -oE '[0-9]+' || true)"
  if [ -z "$w" ] || [ -z "$h" ] || [ "$w" -gt "$h" ]; then echo landscape
  elif [ "$h" -gt "$w" ]; then echo portrait
  else echo square; fi
}

# render_project <1080p|4k> [extra hyperframes render flags...]
# Writes <project>/renders/<project>-<label>.mp4. 4K supersamples the same layout, nothing is re-authored.
render_project() {
  local label="$1"; shift
  local orient preset out
  orient="$(orientation)"
  case "$label" in
    1080p) preset="$orient" ;;
    4k)    preset="$orient-4k" ;;
    *) echo "unknown render target '$label'" >&2; exit 1 ;;
  esac
  mkdir -p "$PROJECT_DIR/renders"
  out="$PROJECT_DIR/renders/$PROJECT-$label.mp4"
  # a trimmed render must never replace the full one
  case " $* " in *" --start "*|*" --end "*) out="$PROJECT_DIR/renders/$PROJECT-$label-partial.mp4" ;; esac
  echo "▶ $PROJECT → $label ($preset, quality ${HF_QUALITY:-delivery})"
  ( cd "$PROJECT_DIR" && hf render . --resolution "$preset" -q "${HF_QUALITY:-delivery}" -o "$out" --quiet "$@" )
  echo "✔ $out"
}
