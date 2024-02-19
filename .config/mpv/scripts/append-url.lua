local utils = require 'mp.utils'
local msg = require 'mp.msg'

function append(primary)
	local clipboard = get_clipboard(primary or false)
	if clipboard then
		mp.commandv("loadfile", clipboard, "append-play")
		mp.osd_message("URL appended: "..clipboard)
		msg.info("URL appended: "..clipboard)
	end
end

function handle(res, args, primary)
	if not res.error and res.status == 0 then
		return res.stdout
	else
		if not primary then
			append(true)
		end
	end
	return nil
end

function get_clipboard(primary)
	local args = {
		'xclip',
		'-selection',
		primary and 'primary' or 'clipboard',
		'-out'
	}
	return handle(utils.subprocess({ args = args }), args, primary)
end

mp.add_key_binding("ctrl+v", "appendURL", append)