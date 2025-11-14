
CFG_DIR=/home/shayan/.config/

# setup eza themes
export EZA_ICONS_AUTO=always
export EZA_CONFIG_DIR="$CFG_DIR/eza"

# starship initialization
eval "$(starship init bash)"
STARSHIP_SRC="$CFG_DIR/starship"
eval "$(mustache $STARSHIP_SRC/starship_vars.json $STARSHIP_SRC/starship.mustache > $CFG_DIR/starship.toml)"
export STARSHIP_CONFIG="$CFG_DIR/starship.toml"

# LS_COLORS interferes with eza themes, so unset
unset LS_COLORS

export VISUAL=nvim
