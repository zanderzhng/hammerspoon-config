local wifiWatcher = nil

local listSSID = {"SSID1", "SSID2"}
local listLCTN = {"LCTN1", "LCTN2"}
local autoLCTN = "Automatic"

local function isSSIDInList (theSSID)
	for i, v in ipairs(listSSID)
	do
		if theSSID == v then
			hs.network.configuration.open():setLocation(listLCTN[i])
			return true
		end
	end
end

local function ssidChangedCallback()
  local lastSSID = hs.wifi.currentNetwork()
	if lastSSID ~= newSSID then
		if isSSIDInList(newSSID) == nil then
			hs.network.configuration.open():setLocation(autoLCTN)
		end
    lastSSID = newSSID
	end
end

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()
