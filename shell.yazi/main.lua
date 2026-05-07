-- Makes the box and run the command
local function run_shell(isblock, noskip)
	local value, event = ya.input({
		title = "Shell" .. (isblock and (noskip and " (block no skip)" or " (block)") or ""),
		pos = { "top-center", y = 3, w = 40 },
	})

	local is_nu = ((Url(os.getenv("SHELL")).name == "nu") and true or false)
	local echo_cmd = (is_nu and "print" or "echo -e")
	local wait_cmd = (is_nu and "input" or "read")
	local noskip_cmd = (noskip and echo_cmd .. " 'Press [Enter] to continue'; " .. wait_cmd .. ";" or "")

	if event == 1 then
		ya.emit("shell", {
			"YAZI_SHELL_SKIP_CMD=true $SHELL -ic " .. ya.quote(value .. ";" .. noskip_cmd .. "exit", true),
			block = isblock,
			confirm = true,
		})
	end
end

return {
	entry = function(self, jobs)
		local action = jobs.args[1]
		if not action then
			return
		end
		-- Block
		if action == "block" then
			run_shell(true, false)
			-- No block
		elseif action == "noblock" then
			run_shell(false, false)
			-- Block, no skip
		elseif action == "noskip" then
			run_shell(true, true)
		end
	end,
}
