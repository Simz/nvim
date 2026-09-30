-- Define your commands here
local my_commands = {
  { label = "Cache flush", cmd = "!t3 cache:flush", notify = true },
  { label = "tmdt up", cmd = "!tmdt up ." },
  { label = "Database update schema", cmd = "!t3 database:updateschema", notify = true },
  { label = "Tail TYPO3 log", cmd = "!tail -f var/log/typo3_*.log" },
}

-- Autodiscover composer scripts from composer.json at the project root
local function get_composer_commands()
  local composer_path = vim.fn.getcwd() .. "/composer.json"
  if vim.fn.filereadable(composer_path) == 0 then
    return {}
  end

  local ok, decoded = pcall(vim.json.decode, table.concat(vim.fn.readfile(composer_path), "\n"))
  if not ok or type(decoded) ~= "table" or type(decoded.scripts) ~= "table" then
    return {}
  end

  local names = {}
  for name, _ in pairs(decoded.scripts) do
    table.insert(names, name)
  end
  table.sort(names)

  local commands = {}
  for _, name in ipairs(names) do
    table.insert(commands, { label = "composer " .. name, cmd = "!tme composer " .. name })
  end
  return commands
end

-- Autodiscover npm scripts from package.json at the project root and
-- recursively under packages/, grouped by the folder each package.json lives in.
local function get_package_commands()
  local cwd = vim.fn.getcwd()

  local package_json_paths = {}
  if vim.fn.filereadable(cwd .. "/package.json") == 1 then
    table.insert(package_json_paths, cwd .. "/package.json")
  end
  vim.list_extend(package_json_paths, vim.fn.glob(cwd .. "/packages/**/package.json", true, true))

  local groups = {}
  for _, path in ipairs(package_json_paths) do
    if not path:find("/node_modules/", 1, true) then
      local ok, decoded = pcall(vim.json.decode, table.concat(vim.fn.readfile(path), "\n"))
      if ok and type(decoded) == "table" and type(decoded.scripts) == "table" then
        local names = {}
        for name, _ in pairs(decoded.scripts) do
          table.insert(names, name)
        end
        table.sort(names)

        if #names > 0 then
          local dir = vim.fn.fnamemodify(path, ":h")
          local rel_dir = dir:sub(#cwd + 2)
          if rel_dir == "" then
            rel_dir = "."
          end

          -- Mount the whole package root, not just the package.json's own
          -- folder: these frontend configs reach outside their own folder
          -- via relative paths (e.g. site_epq's vite.config.ts reads
          -- `../Private` and writes to `../Public`), so a narrow mount
          -- leaves vite/tsc unable to resolve sibling sources and the build
          -- silently produces zero entrypoints.
          local package_root = cwd
          local rel_subpath = "."
          local pkg_name = rel_dir:match("^packages/([^/]+)/")
          if pkg_name then
            package_root = cwd .. "/packages/" .. pkg_name
            rel_subpath = dir:sub(#package_root + 2)
            if rel_subpath == "" then
              rel_subpath = "."
            end
          end

          table.insert(groups, {
            rel_dir = rel_dir,
            names = names,
            package_root = package_root,
            rel_subpath = rel_subpath,
          })
        end
      end
    end
  end

  table.sort(groups, function(a, b)
    return a.rel_dir < b.rel_dir
  end)

  local commands = {}
  for _, group in ipairs(groups) do
    table.insert(commands, { label = "──── " .. group.rel_dir .. " ────", separator = true })
    for _, name in ipairs(group.names) do
      -- Run against an ad-hoc container: mount the whole package root so
      -- it works regardless of which package the frontend service's own
      -- docker-compose.yml volume happens to be bound to.
      -- Double-quoted throughout: this whole string is later dropped into an
      -- outer single-quoted `zsh -ic '...'`, so no single quotes allowed here.
      local workdir = group.rel_subpath == "." and "/work" or ("/work/" .. group.rel_subpath)
      local run_cmd = string.format(
        'docker-compose run --rm -v "%s:/work" -w "%s" frontend sh -c "npm install && npm run %s"',
        group.package_root,
        workdir,
        name
      )
      table.insert(commands, {
        label = "npm run " .. name .. "  (" .. group.rel_dir .. ")",
        cmd = "!" .. run_cmd,
      })
    end
  end
  return commands
end

local function build_commands()
  local composer_commands = get_composer_commands()
  local package_commands = get_package_commands()

  local commands = vim.deepcopy(my_commands)

  if #composer_commands > 0 then
    table.insert(commands, { label = "──────── composer ────────", separator = true })
    vim.list_extend(commands, composer_commands)
  end

  if #package_commands > 0 then
    table.insert(commands, { label = "──────── npm (package.json) ────────", separator = true })
    vim.list_extend(commands, package_commands)
  end

  return commands
end

local function run_shell_select()
  vim.ui.select(build_commands(), {
    prompt = 'Select Shell Command:',
    format_item = function(item)
      return item.label
    end,
  }, function(choice)
    if choice and choice.separator then
      print("Selection cancelled")
    elseif choice then
        -- 1. Strip the '!' and any 'split | term' prefix from your table
      -- We want just the raw command: "t3 cache:flush"
      local pure_cmd = choice.cmd:gsub("^!", ""):gsub("split | term ", "")

      -- 2. Open a floating window
      local width, height, row, col
      if choice.notify then
        -- Small notification-style float, top right
        width = math.floor(vim.o.columns * 0.3)
        height = 6
        row = 1
        col = vim.o.columns - width - 1
      else
        width = math.floor(vim.o.columns * 0.8)
        height = math.floor(vim.o.lines * 0.8)
        row = math.floor((vim.o.lines - height) / 2)
        col = math.floor((vim.o.columns - width) / 2)
      end

      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
      })

      -- 3. Run the command via interactive zsh in the floating buffer
      vim.fn.termopen(string.format("zsh -ic '%s'", pure_cmd))

      -- 4. Enter insert mode automatically
      vim.cmd("startinsert")
    else
      print("Selection cancelled")
    end
  end)
end

-- Map <leader>r to the function
vim.keymap.set('n', '<leader>r', run_shell_select, { desc = 'Run shell command from menu' })
