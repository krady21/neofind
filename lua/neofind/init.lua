local fn = vim.fn

local M = {}

M.find = function(pattern)
    local cmd = { "fd", pattern, "--type", "file"}
    local files = {}

    local job_id = fn.jobstart(cmd, {
        stdout_buffered = true,
        on_stdout = function(_, data, _)
            files = data
        end
    })
    fn.jobwait({job_id}, 5000)

    return vim.tbl_map(function(f)
        if f == "" then
            return
        end
        return string.sub(f, 3, -1)
    end, files)
end

M.file_complete = function(base_path)
    local sep = "/"
    local split = vim.split(base_path, sep)

    local base_dir, partial_file = ".", ""
    if #split > 1 then
        base_dir = table.concat(vim.list_slice(split, 1, #split - 1), sep)
        partial_file = split[#split]
    end

    for name, type in vim.fs.dir(base_path) do
        vim.pretty_print(name, type)
    end
end

M.file_complete("~/")

return M
