local command_center = require("command_center")

command_center.add({
  {
    desc = "Docker - docker-compose stop",
    cmd = "<CMD>!docker-compose stop<CR>",
  },  {
    desc = "Docker - docker-compose up",
    cmd = "<CMD>!docker-compose up<CR>",
  },  {
    desc = "CDK - cdk synth --all",
    cmd = "<CMD>FloatermNew! cdk synth<CR>",
  },  {
    desc = "CDK - cdk deploy --all",
    cmd = "<CMD>FloatermNew! cdk deploy --all<CR>",
  },  {
    desc = "Diffview",
    cmd = "<CMD>DiffviewOpen<CR>",
  },  {
    desc = "Diffview current file",
    cmd = "<CMD>DiffviewFileHistory %<CR>",
  },  {
    desc = "reload",
    cmd = "<CMD>source $MYVIMRC<CR>",
  },
})
require('telescope').load_extension('command_center')
