local function runDefault(tags)
  return function() require "overseer".run_template({ tags = { tags, "default" } }) end
end

return {
  "stevearc/overseer.nvim",
  opts = {
    strategy = {
      "toggleterm",
      direction = setmetatable({}, { __tostring = require "style".vertOrHoriz }),
    },
    default_template_prompt = "always",
    templates = { "builtin", "index" },
  },
  keys = {
    { "<F1>", runDefault("compile"), desc = "Compile file" },
    { "<F2>", runDefault("run"), desc = "Run file" },
    { "<F3>", runDefault("makefile"), desc = "Update makefile" },
    { "<F4>", runDefault("build"), desc = "Build project" },
    { "<F5>", runDefault("test"), desc = "Test project" },
    { "<F6>", runDefault("launch"), desc = "Run project" },
  },
  cmd = { "OverseerToggle", "OverseerRun" },
}
