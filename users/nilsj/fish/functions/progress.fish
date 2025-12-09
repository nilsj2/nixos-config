function progress --wraps='math (fd -e md | wc -l) / (fd -e md -e pdf | wc -l)' --description 'alias progress=math (fd -e md | wc -l) / (fd -e md -e pdf | wc -l)'
    math (fd -e md | wc -l) / (fd -e md -e pdf | wc -l) $argv
end
