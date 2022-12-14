---@type Ellyb
local Ellyb = Ellyb(...);

if Ellyb.Popups then
	return
end

-- Lua imports
local format = string.format;

-- Ellyb imports
local EditBoxes = Ellyb.EditBoxes;

-- Ellyb imports
local ORANGE = Ellyb.ColorManager.ORANGE;

local Popups = {};
Ellyb.Popups = Popups;

---@type Frame
local URLPopup = Ellyb_StaticPopOpenUrl;
URLPopup.Button.Text:SetText(_G.OKAY);
EditBoxes.makeReadOnly(URLPopup.Url);
EditBoxes.selectAllTextOnFocus(URLPopup.Url);
EditBoxes.looseFocusOnEscape(URLPopup.Url);
-- Clear global variable
_G["Ellyb_StaticPopOpenUrl"] = nil;

local function dismissPopup()
	HideUIPanel(URLPopup);
end
URLPopup.Url:HookScript("OnEnterPressed", dismissPopup);
URLPopup.Url:HookScript("OnEscapePressed", dismissPopup);

--- Open a popup with an autofocused text field to let the user copy the URL
---@param url string @ The URL we want to let the user copy
---@param customText string @ A custom text to display, instead of the default hint to copy the URL
---@param customShortcutInstructions string @ A custom text for the copy and paste shortcut instructions.
function Popups:OpenURL(url, customText, customShortcutInstructions)
	local popupText = customText and (customText .. "\n\n") or "";
	if not customShortcutInstructions then
		customShortcutInstructions = Ellyb.loc.COPY_URL_POPUP_TEXT;
	end
	popupText = popupText .. format(customShortcutInstructions, ORANGE(Ellyb.System.SHORTCUTS.COPY), ORANGE(Ellyb.System.SHORTCUTS.PASTE));
	URLPopup.Text:SetText(popupText);
	URLPopup.Url:SetText(url);
	URLPopup:SetHeight(120 + URLPopup.Text:GetHeight());
	URLPopup:Show();
end