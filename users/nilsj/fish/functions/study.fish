function study --wraps='hx ' --wraps='open  & hx ' --description 'alias study=open  & hx '
    open $argv[1] &
    hx $argv[1]
end
