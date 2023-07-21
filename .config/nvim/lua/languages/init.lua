local path = ... .. '.'
return {
    require(path .. 'go'),
    require(path .. 'javascript'),
    require(path .. 'lua'),
    require(path .. 'markdown'),
    require(path .. 'python'),
    require(path .. 'zig'),
}
