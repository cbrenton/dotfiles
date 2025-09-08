DOTFILES_DIR="$HOME/.dotfiles/configs"
TARGET_DIR="$HOME"
SPECIAL_DIRS=(".vim")

DRY_RUN=false
[[ "$1" == "--dry-run" ]] && DRY_RUN=true

shopt -s dotglob nullglob

log() {
  if $DRY_RUN; then
    echo "[dry-run] $1"
  else
    echo "$1"
  fi
}

# Handle special full-directory symlinks
for special in "${SPECIAL_DIRS[@]}"; do
  src_dir="$DOTFILES_DIR/$special"
  dest_dir="$TARGET_DIR/$special"

  if [[ -d "$src_dir" ]]; then
    if [[ -e "$dest_dir" && ! -L "$dest_dir" ]]; then
      echo "Backing up $dest_dir to $dest_dir.backup"
      $DRY_RUN || mv "$dest_dir" "$dest_dir.backup"
    fi

    if [[ -L "$dest_dir" ]]; then
      log "Removing existing symlink $dest_dir"
      $DRY_RUN || rm "$dest_dir"
    fi

    log "Linking $src_dir → $dest_dir"
    $DRY_RUN || ln -s "$src_dir" "$dest_dir"
  fi
done

# Recursively symlink all other files
find "$DOTFILES_DIR" -type f | while read -r src_file; do
  # Skip files inside special directories
  for skip in "${SPECIAL_DIRS[@]}"; do
    [[ "$src_file" == "$DOTFILES_DIR/$skip/"* ]] && continue 2
  done

  rel_path="${src_file#$DOTFILES_DIR/}"
  dest_file="$TARGET_DIR/$rel_path"
  dest_dir=$(dirname "$dest_file")

  $DRY_RUN || mkdir -p "$dest_dir"

  if [[ -e "$dest_file" && ! -L "$dest_file" ]]; then
    log "Backing up $dest_file → $dest_file.backup"
    $DRY_RUN || mv "$dest_file" "$dest_file.backup"
  fi

  if [[ -L "$dest_file" ]]; then
    log "Removing existing symlink $dest_file"
    $DRY_RUN || rm "$dest_file"
  fi

  log "Linking $src_file → $dest_file"
  $DRY_RUN || ln -s "$src_file" "$dest_file"
done
