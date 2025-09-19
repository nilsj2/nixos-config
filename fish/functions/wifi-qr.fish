function wifi-qr --wraps='nmcli device wifi show-password' --description 'alias wifi-qr=nmcli device wifi show-password'
  nmcli device wifi show-password $argv
        
end
