vimconflicts() {
  vim "$(git diff --name-only --diff-filter=U | xargs)"
}

gitbranchauthors() {
  git remote update origin --prune > /dev/null;
  for branch in $(git branch -r | grep -v HEAD); do echo "$(git show --format=%an "$branch" | head -n 1): $branch"; done |
    sort -r |
    column -s ":" -t
}

gitcheckout() {
  git remote show origin | grep "HEAD branch" | sed 's/.*: //' | xargs -I '{}' git checkout -b "$1" '{}'
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

publicip() {
  curl https://ipinfo.io/ip
}

gitpullfilefromlastcommit() {
  msg=$(git log -1 --pretty=%B)
  git reset --soft HEAD~
  git reset "$1"
  git commit --message "$msg"
}

gitpr() {
    MAIN_BRANCH=$(git remote show origin | grep "HEAD branch" | sed 's/.*: //')
    BRANCH_NAME=$(git symbolic-ref -q HEAD | sed 's/.*\///')
    ISSUE_NR=$(git symbolic-ref -q HEAD | sed 's/.*-//')

    HEADER=''
    if [ "$1" != "" ]; then
        # Use message from command line
        HEADER="$1"
    else
        # Default to branch name
        HEADER="$BRANCH_NAME"
    fi

    MESSAGE=$(echo -e "$HEADER\n\ncloses #$ISSUE_NR")

    #Check if issue nr exists
    re='^[0-9]+$'
    if ! [[ $ISSUE_NR =~ $re ]] ; then
        MESSAGE="$HEADER"
    fi

    git push -u origin "$BRANCH_NAME"
    hub pull-request -b "$MAIN_BRANCH" -m "$MESSAGE"
    echo "PR for $BRANCH_NAME created"
}

# https://unix.stackexchange.com/a/112284
# Edit the /etc/default/grub and replace GRUB_DEFAULT=0 with GRUB_DEFAULT=saved
# sudo update-grub
rbwin ()
{
    windows_title=$(grep -i windows /boot/grub/grub.cfg | cut -d "'" -f 2)
    sudo grub-reboot "$windows_title" && sudo reboot
}
