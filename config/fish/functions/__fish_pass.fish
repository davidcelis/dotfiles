function __fish_pass
  echo (security dump-keychain | grep '"srvr"' | cut -d '"' -f 4 -)
end
