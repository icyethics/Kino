-- Hooking the click function
local _o_click = Card.click
function Card:click() 
    local _ret = _o_click(self)

    if self.config.center.click then 
        self.config.center.click(self)
    end

    return _ret
end