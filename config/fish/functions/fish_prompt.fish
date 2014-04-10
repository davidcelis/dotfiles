function fish_prompt
  # Powerline symbols
  set -g current_bg NONE
  set -g segment_separator \uE0B0
  set -g alt_segment_separator \uE0B1
  set -g branch_symbol \uE0A0

  # Colors
  set -l black  (set_color -o black)
  set -l red    (set_color -o red)
  set -l green  (set_color -o green)
  set -l yellow (set_color -o yellow)
  set -l blue   (set_color -o blue)
  set -l purple (set_color -o purple)
  set -l cyan   (set_color -o cyan)
  set -l white  (set_color -o white)
  set -l normal (set_color normal)

  prompt_segment blue black (prompt_pwd)

  # Git information
  set -g __git_branch_name (command git symbolic-ref --short -q HEAD ^/dev/null)

  if [ $__git_branch_name ]
    if not set -q -g __git_functions_defined
      set -g __git_functions_defined

      function _git_dirty
        echo (command git status -s --ignore-submodules=dirty)
      end

      function _git_ahead
        echo (command git log --format=oneline origin/$__git_branch_name..$__git_branch_name ^/dev/null)
      end

      function _git_behind
        echo (command git log --format=oneline $__git_branch_name..origin/$__git_branch_name ^/dev/null)
      end
    end

    set -l git_info "$purple$branch_symbol $white$__git_branch_name"

    if [ (_git_dirty) ]
      set git_info $git_info$yellow!
    end

    if [ (_git_ahead) ]
      set git_info $git_info$blue↑
    end

    if [ (_git_behind) ]
      set git_info $git_info$blue↓
    end

    prompt_segment black white $git_info
  end

  prompt_finish
  set_color normal
end
