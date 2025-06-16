gitbranchauthors() {
  git remote update origin --prune > /dev/null;
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

localip() {
  ip route get 1.1.1.1 | awk '{print $7}' | head --lines=1
}

publicip() {
  curl https://ipinfo.io/ip
}

# https://unix.stackexchange.com/a/112284
# Edit the /etc/default/grub and replace GRUB_DEFAULT=0 with GRUB_DEFAULT=saved
# sudo update-grub
rbwin ()
{
    windows_title=$(grep -i windows /boot/grub/grub.cfg | cut -d "'" -f 2)
    sudo grub-reboot "$windows_title" && sudo reboot
}
