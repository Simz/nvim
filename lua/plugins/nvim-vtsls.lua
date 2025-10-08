
return {
    "yioneko/nvim-vtsls",
    config = function()
        require('vtsls').config({
            -- customize handlers for commands
            handlers = {
                source_definition = function(err, locations)
                end,
                file_references = function(err, locations)
                end,
                code_action = function(err, actions)
                end,
            },
            -- automatically trigger renaming of extracted symbol
            refactor_auto_rename = true,
        })
    end
}
