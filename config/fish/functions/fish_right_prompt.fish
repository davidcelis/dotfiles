function fish_right_prompt
  set -g current_bg NONE
  set -g segment_separator \uE0B2

  if contains fry (functions)
    echo (set_color red)$segment_separator
    prompt_segment red black (fry current)

    set_color -b normal
    set -g current_bg NONE
  end
end
