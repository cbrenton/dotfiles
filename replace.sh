DOTFILES_DIR="$HOME/.dotfiles/configs"
TARGET_DIR="$HOME"

shopt -s dotglob nullglob

# Special-case full-directory symlinks
SPECIAL_DIRS=(".vim")

# First, link special top-level directories like `.vim`
for special in "${SPECIAL_DIRS[@]}"; do
  src_dir="$DOTFILES_DIR/$special"
  dest_dir="$TARGET_DIR/$special"

  if [[ -d "$src_dir" ]]; then
    if [[ -e "$dest_dir" && ! -L "$dest_dir" ]]; then
      echo "Backing up $dest_dir to $dest_dir.backup"
      mv "$dest_dir" "$dest_dir.backup"
    fi

    if [[ -L "$dest_dir" ]]; then
      rm "$dest_dir"
    fi

    ln -s "$src_dir" "$dest_dir"
    echo "Linked $src_dir → $dest_dir"
  fi
done

# Now handle everything else recursively
find "$DOTFILES_DIR" -type f | while read -r src_file; do
  # Skip special dir contents
  for skip in "${SPECIAL_DIRS[@]}"; do
    [[ "$src_file" == "$DOTFILES_DIR/$skip/"* ]] && continue 2
  done

  rel_path="${src_file#$DOTFILES_DIR/}"
  dest_file="$TARGET_DIR/$rel_path"
  dest_dir=$(dirname "$dest_file")

  mkdir -p "$dest_dir"

  if [[ -e "$dest_file" && ! -L "$dest_file" ]]; then
    echo "Backing up $dest_file to $dest_file.backup"
    mv "$dest_file" "$dest_file.backup"
  fi

  if [[ -L "$dest_file" ]]; then
    rm "$dest_file"
  fi

  ln -s "$src_file" "$dest_file"
  echo "Linked $src_file → $dest_file"
done
