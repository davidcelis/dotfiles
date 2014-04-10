function prompt_segment -d "Function to draw a segment"
  set -l bg
  set -l fg

  if [ -n "$argv[1]" ]
    set bg $argv[1]
  else
    set bg normal
  end

  if [ -n "$argv[2]" ]
    set fg $argv[2]
  else
    set fg normal
  end

  if [ "$current_bg" != 'NONE' -a "$argv[1]" != "$current_bg" ]
    set_color -b $bg
    set_color $current_bg
    echo -n "$segment_separator "
    set_color -b $bg
    set_color $fg
  else
    set_color -b $bg
    set_color $fg
    echo -n " "
  end

  set -g current_bg $argv[1]

  if [ -n "$argv[3]" ]
    echo -n -s $argv[3] " "
  end
end
