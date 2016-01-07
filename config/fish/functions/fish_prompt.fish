function fish_prompt
  set -l last_status $status

  # Command timing
  echo -n -s (__fish_prompt_timing)

  # PWD
  set_color cyan
  echo -n (__fish_prompt_pwd)
  set_color normal

  # Git
  printf '%s ' (__fish_prompt_git ' %s')
  set_color normal

  if not test $last_status -eq 0
    set_color $fish_color_error
  end

  echo -n -s '% '

  set_color normal
end
