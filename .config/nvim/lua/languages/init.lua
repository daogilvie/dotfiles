local path = ... .. '.'
return {
    require(path .. 'go'),
    require(path .. 'javascript'),
    require(path .. 'julia'),
    require(path .. 'lua'),
    require(path .. 'markdown'),
    require(path .. 'python'),
    require(path .. 'terraform'),
    require(path .. 'zig'),
}
