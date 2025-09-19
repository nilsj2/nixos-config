function langref
    set dir (zig any list-installed | grep (zig version) | sed 's/^[^ ]*\t//' )
    open $dir/doc/langref.html
end
