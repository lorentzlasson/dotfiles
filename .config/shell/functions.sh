gitbranchauthors() {
  git remote update origin --prune >/dev/null
  for branch in $(git branch -r | grep -v HEAD); do echo "$(git show --format=%an "$branch" | head -n 1): $branch"; done |
    sort -r |
    column -s ":" -t
}

# e.g.
# replace_all ./some/path foo bar
replace_all() {
  local dir="$1"
  local old="$2"
  local new="$3"

  # Replace in file contents
  fd --type file . "$dir" --exec sd "$old" "$new" {}

  # Replace in filenames
  for file in $(fd --type file "$old" "$dir"); do
    mv "$file" "${file//$old/$new}"
  done
}

process_using_port() {
  lsof -i :"$1"
}

kill_port() {
  local pid
  pid=$(ss --listening --tcp --numeric --processes | awk "/:$1 /" | grep -oP 'pid=\K[0-9]+')
  [ -n "$pid" ] && kill "$pid"
}

busy_ports() {
  (
    echo "PROCESS PORT"
    ss --listening --tcp --numeric --processes |
      awk 'NR>1 {
        match($0, /:([0-9]+) /, port)
        match($0, /users:\(\("([^"]+)"/, proc)
        if (port[1] >= 1000 && port[1] <= 10000 && proc[1])
          print proc[1], port[1]
      }' |
      sort --unique
  ) | column --table
}

pretty_path() {
  echo "$PATH" | tr ':' '\n'
}

localip() {
  ip route get 1.1.1.1 | awk '{print $7}' | head --lines=1
}

# router usually
defaultgatewayip() {
  ip route get 1.1.1.1 | awk '{print $3}' | head --lines=1
}

publicip() {
  curl https://ipinfo.io/ip
}

decode_jwt() {
  echo "$1" | cut --delimiter='.' --fields=2 | base64 --decode 2>/dev/null | jq .
}

# https://unix.stackexchange.com/a/112284
# Edit the /etc/default/grub and replace GRUB_DEFAULT=0 with GRUB_DEFAULT=saved
# sudo update-grub
rbwin() {
  windows_title=$(grep -i windows /boot/grub/grub.cfg | cut -d "'" -f 2)
  sudo grub-reboot "$windows_title" && sudo reboot
}
