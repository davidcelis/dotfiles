function e
  if [ (count $argv) -gt 0 ]
    code $argv
  else
    set -l out (mktemp -d)

    cat > $out/stdin
    code $out/stdin
  end
end
