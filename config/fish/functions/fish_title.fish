function fish_title
  set -l pwd (echo -n $PWD | sed 's/ /%20/g')
  printf '\a\033]7;file://localhost/%s' $pwd
end
