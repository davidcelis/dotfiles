function fish_right_prompt
  set -l red (set_color red)
  set -l normal (set_color normal)
  set -l error (set_color $fish_color_error)

  if type -q rv
    set -l ruby_version (rv ruby pin | awk '{print $NF}')

    if rv ruby find $ruby_version &> /dev/null
      echo $red$ruby_version$normal
    else
      echo $error$ruby_version$normal
    end
  end
end
