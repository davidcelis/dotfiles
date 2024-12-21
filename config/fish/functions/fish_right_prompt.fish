function fish_right_prompt
  set -l red (set_color red)
  set -l normal (set_color normal)
  set -l error (set_color $fish_color_error)

  if contains asdf (functions)
    set -l ruby_version (fast-asdf-version ruby)

    if asdf where ruby &> /dev/null
      echo $red$ruby_version$normal
    else
      echo $error$ruby_version$normal
    end
  end
end
