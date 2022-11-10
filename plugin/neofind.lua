local command = vim.api.nvim_create_user_command

if vim.g.loaded_neofind == 1 then
  return
end

command("Fd", function(opts)
    local cmd = string.format("edit %s", opts.fargs[1])
    vim.cmd(cmd)
end, {
    nargs = 1,
    complete = function(arg_lead, _, _)
        return require("neofind").find(arg_lead)
    end
})
