DOTFILES_DIR="$HOME/.dotfiles/configs"
TARGET_DIR="$HOME"

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

link_dir() {
  local src_dir="$1"
  local dest_dir="$2"

  if [[ -e "$dest_dir" && ! -L "$dest_dir" ]]; then
    log "Backing up $dest_dir → $dest_dir.backup"
    $DRY_RUN || mv "$dest_dir" "$dest_dir.backup"
  fi

  if [[ -L "$dest_dir" ]]; then
    log "Removing existing symlink $dest_dir"
    $DRY_RUN || rm "$dest_dir"
  fi

  log "Linking $src_dir → $dest_dir"
  $DRY_RUN || ln -s "$src_dir" "$dest_dir"
}

link_file() {
  local src_file="$1"
  local dest_file="$2"

  $DRY_RUN || mkdir -p "$(dirname "$dest_file")"

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
}

# Symlink each subdirectory of .config/ as a whole unit
config_src="$DOTFILES_DIR/.config"
config_dest="$TARGET_DIR/.config"
if [[ -d "$config_src" ]]; then
  $DRY_RUN || mkdir -p "$config_dest"
  for src_dir in "$config_src"/*/; do
    dir_name=$(basename "$src_dir")
    link_dir "$src_dir" "$config_dest/$dir_name"
  done
fi

# Symlink .vim as a whole directory
if [[ -d "$DOTFILES_DIR/.vim" ]]; then
  link_dir "$DOTFILES_DIR/.vim" "$TARGET_DIR/.vim"
fi

# Symlink all other top-level files individually (skip .config and .vim)
find "$DOTFILES_DIR" -mindepth 1 -maxdepth 1 -type f | while read -r src_file; do
  rel_path="${src_file#$DOTFILES_DIR/}"
  link_file "$src_file" "$TARGET_DIR/$rel_path"
done
