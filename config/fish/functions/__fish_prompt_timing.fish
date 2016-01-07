function __fish_prompt_timing
  if test "$CMD_DURATION" -gt '100'
    set_color $fish_color_error

    if test "$CMD_DURATION" -lt '60000'
      printf '%.1fs ' (awk "BEGIN { print $CMD_DURATION / 1000 }")
    else if test "$CMD_DURATION" -lt '3600000'
      printf '%.1fm ' (awk "BEGIN { print $CMD_DURATION / 60000 }")
    else
      printf '%.1fh ' (awk "BEGIN { print $CMD_DURATION / 3600000 }")
    end

    set_color normal
  end
end
