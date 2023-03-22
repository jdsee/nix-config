popman() {
  if [ ! -z "$BUFFER" ]; then
    CMD=$(echo "$BUFFER" | awk '{ print $1; }')
    tmux popup -EE -h 90% -w 90% man "$CMD"
  fi
}
