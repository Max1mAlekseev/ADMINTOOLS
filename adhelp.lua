script_name("ADMINTOOLS") 
script_author("usenko")  
script_version_number(4) 
script_dependencies("SAMPFUNCS, SAMP") 
script_properties('work-in-pause') 
local q = require "lib.samp.events"  
require("lib.moonloader")  
require 'luairc' 
local effil = require("effil") 
local main_color = 0xFFFFFF 
local inicfg = require 'inicfg'
local dlstatus = require('moonloader').download_status
local imgui = require 'imgui'
local encoding = require 'encoding'
local Matrix3X3 = require "matrix3x3"
local Vector3D = require "vector3d"
encoding.default = 'CP1251'
u8 = encoding.UTF8
require "lib.sampfuncs"
local copas = require("copas")
local requests = require("requests")
local fa = require 'faIcons'
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
local themes = import 'resource/imgui_themes.lua'
local keys = require 'vkeys'
local arrs = {
    arr_fractls = {'1 PD', '2 ARMY', '3 EMS', '4 NEWS', '6 TAXI', '7 FBI'},
    arr_fractsf = {'8 PD', '9 ARMY', '10 EMS', '11 NEWS', '13 TAXI', '14 FBI'},
    arr_fractlv = {'15 PD', '16 ARMY', '17 EMS', '18 NEWS', '20 TAXI', '21 FBI'},
    arr_famls = {'5 VAGOS', '1 BALLAS', '20 GROVE', '39 AZTEC'},
    arr_famsf = {'38 LCN', '41 TRIADS', '42 YAKUZA', '43 RM'},
    arr_famlv = {'44 COYOTES', '45 SOA', '46 HAMC', '47 OUTLAWS'},
    arr_themes = {'PURPLE', 'BLACK', 'RED', 'VIOLET', 'VIOLET 2' , 'BLASTHACK'},
    arr_fs = {'None', 'Box', 'Kung Fu', 'Kneehead'},
    arr_st = {'US', 'AF', 'RC'},
    idfractspec = {},

}
local onepomet = true
local privet = false
local fractlscombo  = imgui.ImInt(0)
local fractsfcombo  = imgui.ImInt(0)
local fractlvcombo  = imgui.ImInt(0)
local famlscombo  = imgui.ImInt(0)
local famsfcombo  = imgui.ImInt(0)
local famlvcombo  = imgui.ImInt(0)
local skinpng = {}
local MODEL = 0
local settingsi = imgui.ImBool(false)
frall = false
avinfon = false
local sh = {}
lvlcolor1 = 'ffb273'
chat_id = '954803445'
token = '1TrBtH0' 
acn = 1
local updateid 
local firstsp = true
local lastnicksp = ''

local nickfractspec = {}
local rankfractspec = {}

local houseNumbers = {}

local freezeActive = false
local freezeEnd = 0
local freezeX, freezeY, freezeZ = 0, 0, 0

local pendingId = nil
local gethereScheduled = false
local gethereTime = 0

local ffi = require("ffi")
ffi.cdef[[ unsigned long GetTickCount(); ]]
local function getTickCount() return ffi.C.GetTickCount() end

local fly = false
function urlencode (str)
   str = string.gsub (str, "([^0-9a-zA-Z !'()*._~-])", -- locale independent
      function (c) return string.format ("%%%02X", string.byte(c)) end)
   str = string.gsub (str, " ", "+")
   return str
end
local ttt = {}
local vvv = {}
local sizeywin = 100
local dhistcheckad = '123123'
local lala = {'dm', 'дм', 'DM', 'kill', 'кил', 'убил', 'ДМ', 'помех', 'дб', 'ДБ', 'KILL', 'db', 'DB', 'убийст'}
local chrep = {'osk', 'оск', 'mg', 'мг', 'MG', 'caps', 'капс', 'flood', 'spam', 'флуд', 'спам', 'fg', 'фг', 'фанг', 'fungame', 'FG', 'ФГ', 'ОСК', 'Osk', 'ock', 'flud'}
local descc = {'desc', 'деск', 'описание', 'DESC', 'ДЕСК', 'Desc', 'Деск', 'desk'}
local cheat = {'cheat', 'чит', 'ЧИТ', 'CHEAT', 'Cheat', 'спидх', 'sh', 'SH', 'сх', 'СХ', 'GM', 'gm', 'ГМ', 'гм', 'fly', 'FLY', 'флай', 'ФЛАЙ', 'рван', 'rvan', 'РВАН', 'RVAN'}
local aviats = {'avia', 'авиа', 'самол', 'верт', 'АВИА', 'samol'}

local aviaid = {417, 425, 447, 460, 476, 488, 497, 511, 513, 512, 519, 520, 548, 553, 563, 577, 593, 592, 487, 469}

local Config = inicfg.load({
    Settings = {
        amessini = false,
        achatini = false,
        ROFF = false,
        AutoGodMod = false,
        ChlogHelp = false,
        DescHelp = false,
        JailHelp = false,
        AutoGhost = false,
        IdKillList = false,
        ServerCarHeal = false,
        AutoUnd = false,
        ServerFlipCar = false,
        OnlyRep = false,
        SpecPlayerCheck = false,
        NotifyRep = false,
        RepColor = 'c46caa',
        ACHColor = '1f9137',
        Colors = false,
        Theme = 1,
        usekey = VK_Y,
        WhReport = false,
        FastScreen = false,
        AutoReact = false,
        AutoReactvar = false,
        AutoReactslet = false,
        PedGodMod = false,
        CarGodMod = false,
        WhAvia = false,
        SpawnOnAdmWorld = false,
        AirBrake = false,
        Airspeedcar = 1.5,
        Airspeedped = 0.3,
        Airkey = 161,
        AutoScreen = false,
        RenderNavigac = false,
        ClickWarp = false,
        AntiA = false,
        SpeedHack = false,
        TracerBullet = false,
        myFs = 0,
        mySt = 0,
        ReportUved = false,
        ChlogWindow = false,
        oskfind = false,
        showupdatewin = true,
        tag = true,
        RMH = true, 
        chathelp = false,
        autorcrime = false,
        offaames = false,
        autoflush = false,
        automegapun = false,
        antiw = false,
        bindmenu = true, 
        camhack = false,
        idchat = false,
        ipfind = false,
        BnSpeed = 25,
        ShKey = false,
        ispec = true,
        StartAttempt = 0,
        admplusfix = false,
    },
    Window = {
        RepX = 100,
        RepY = 100,
        ChlX = 100,
        ChlY = 800,
        GdX = 100, 
        GdY = 800,
    },
    Spawn = {
        SX = 0,
        SY = 0,
        SZ = 0,
        Active = false,
    },
    arr_osk = {},
    arr_ip = {},
    arr_name = {'Vlad_', 'Vanya_', 'Vasya_', 'Katya_', 'Petya_', 'Dima_', 'Sasha_', 'Tolya_', 'Senya_', 'Tema_', 'Borya_', 'Vitya_', 'Nastya_', 'Lera_', 'Vera_', 'Vika_', 'Gelya_', 'Grisha_', 'Slava_', 'Vadik_', 'Gena_', 'Roma_', 'Sema_', 'Stas_', 'Lenya_', 'Olya_', 'Kolya_', 'Stepa_'},
}, 'ahelp.ini')
inicfg.save(Config, 'ahelp.ini')
if Config.Settings.tag == true then
    tag = '{7172ee}[ADMINTOOLS]: {FFFFFF}'
else
    tag = '{ffffff}'
end
update_state = false
local themescombo = imgui.ImInt(Config.Settings.Theme-1)
local combos = {
    fscombo = imgui.ImInt(Config.Settings.myFs),
    stcombo = imgui.ImInt(Config.Settings.mySt)
}
local win = {
     chlwind = imgui.ImBool(false),
     speccheckwind = imgui.ImBool(false),
     updatewin = imgui.ImBool(Config.Settings.showupdatewin),
     second_window_state = imgui.ImBool(false),
     fractspecwin = imgui.ImBool(false),
     jailwind = imgui.ImBool(false),
     banwind = imgui.ImBool(false),
     nakazwind = imgui.ImBool(false),
     chlogwind = imgui.ImBool(false),
     mutetime = imgui.ImBool(false),
     main2 = imgui.ImBool(false),
     descwind = imgui.ImBool(false),
     deadwind = imgui.ImBool(false),
     information = imgui.ImBool(false),
     mmain = imgui.ImBool(false),
     mainwin = imgui.ImBool(false),
     reportwin = imgui.ImBool(false),
     carclickwin = imgui.ImBool(false),
     aobwin = imgui.ImBool(false),
     rlogwin = imgui.ImBool(false),
}
local sliders = {
    airpedslider = imgui.ImFloat(Config.Settings.Airspeedped),
    bnspeedslider = imgui.ImFloat(Config.Settings.BnSpeed)
}
local script_vers = 4
local script_vers_text = "4.81"

local update_url = "https://raw.githubusercontent.com/Max1mAlekseev/ADMINTOOLS/main/update.ini" 
local update_path = getWorkingDirectory() .. "/update.ini" 

local script_url = "https://github.com/Max1mAlekseev/ADMINTOOLS/blob/main/adhelp.luac?raw=true" 
local script_path = thisScript().path

local tbuffer = imgui.ImBuffer(256)
local activatesk = true
local inv = imgui.ImBool(Config.Settings.ROFF)
local specstat = false
local check1 = imgui.ImBool(Config.Settings.achatini)
local check2 = imgui.ImBool(Config.Settings.amessini)
local agm = imgui.ImBool(Config.Settings.AutoGodMod)
local desch = imgui.ImBool(Config.Settings.DescHelp)
local chlogh = imgui.ImBool(Config.Settings.ChlogHelp)
local jailh = imgui.ImBool(Config.Settings.JailHelp)
local ghost = imgui.ImBool(Config.Settings.AutoGhost)
local idkl = imgui.ImBool(Config.Settings.IdKillList)
local cheal = imgui.ImBool(Config.Settings.ServerCarHeal)
local autou = imgui.ImBool(Config.Settings.AutoUnd)
local GMped = imgui.ImBool(Config.Settings.OnlyRep)
local speccheck = imgui.ImBool(Config.Settings.SpecPlayerCheck)
local nrep = imgui.ImBool(Config.Settings.NotifyRep)
local whrep = imgui.ImBool(Config.Settings.WhReport)
local screenint = imgui.ImBool(Config.Settings.FastScreen)
local autoreac = imgui.ImBool(Config.Settings.AutoReact)
local autoreacvar = imgui.ImBool(Config.Settings.AutoReactvar)
local autoreacslet = imgui.ImBool(Config.Settings.AutoReactslet)
local pedgm = imgui.ImBool(Config.Settings.PedGodMod)
local cargm = imgui.ImBool(Config.Settings.CarGodMod)
local aviawh = imgui.ImBool(Config.Settings.WhAvia)
local admwsp = imgui.ImBool(Config.Settings.SpawnOnAdmWorld)
local colorschb = imgui.ImBool(Config.Settings.Colors)
local imair = imgui.ImBool(Config.Settings.AirBrake)
local proscrin = imgui.ImBool(Config.Settings.AutoScreen)
local navigac = imgui.ImBool(Config.Settings.RenderNavigac)
local imcw = imgui.ImBool(Config.Settings.ClickWarp)
local destadm = imgui.ImBool(Config.Settings.AntiA)
local chhelp = imgui.ImBool(Config.Settings.chathelp)
local autorc = imgui.ImBool(Config.Settings.autorcrime)
local offaa = imgui.ImBool(Config.Settings.offaames)
local checkboxes = {
    speedh = imgui.ImBool(Config.Settings.SpeedHack),
    ruv = imgui.ImBool(Config.Settings.ReportUved),
    winch = imgui.ImBool(Config.Settings.ChlogWindow),
    auflush = imgui.ImBool(Config.Settings.autoflush),
    aumegapun = imgui.ImBool(Config.Settings.automegapun),
    antiwant = imgui.ImBool(Config.Settings.antiw),
    cmh = imgui.ImBool(Config.Settings.camhack),
    idc = imgui.ImBool(Config.Settings.idchat),
    ipf = imgui.ImBool(Config.Settings.ipfind),
    sk = imgui.ImBool(Config.Settings.ShKey),
    isp = imgui.ImBool(Config.Settings.ispec),
    apf = imgui.ImBool(Config.Settings.admplusfix),
}
local idwinrep
local ffi = require 'ffi'
local memory = require 'memory'
local getBonePosition = ffi.cast("int (__thiscall*)(void*, float*, int, bool)", 0x5E4280)

ffi.cdef[[
struct stKillEntry
{
    char					szKiller[25];
    char					szVictim[25];
    uint32_t				clKillerColor; // D3DCOLOR
    uint32_t				clVictimColor; // D3DCOLOR
    uint8_t					byteType;
} __attribute__ ((packed));

struct stKillInfo
{
    int						iEnabled;
    struct stKillEntry		killEntry[5];
    int 					iLongestNickLength;
    int 					iOffsetX;
    int 					iOffsetY;
    void			    	*pD3DFont; // ID3DXFont
    void		    		*pWeaponFont1; // ID3DXFont
    void		   	    	*pWeaponFont2; // ID3DXFont
    void					*pSprite;
    void					*pD3DDevice;
    int 					iAuxFontInited;
    void 		    		*pAuxFont1; // ID3DXFont
    void 			    	*pAuxFont2; // ID3DXFont
} __attribute__ ((packed));
]]
local key, server, ts
local autojail = false
function imgui.BeforeDrawFrame()
  if fa_font == nil then
    local font_config = imgui.ImFontConfig()
    font_config.MergeMode = true
    fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fontawesome-webfont.ttf', 14.0, font_config, fa_glyph_ranges)
  end
end

ffi.cdef[[
int __stdcall GetVolumeInformationA(
    const char* lpRootPathName,
    char* lpVolumeNameBuffer,
    uint32_t nVolumeNameSize,
    uint32_t* lpVolumeSerialNumber,
    uint32_t* lpMaximumComponentLength,
    uint32_t* lpFileSystemFlags,
    char* lpFileSystemNameBuffer,
    uint32_t nFileSystemNameSize
);
]]
local serial = ffi.new("unsigned long[1]", 0)
ffi.C.GetVolumeInformationA(nil, nil, 0, serial, nil, nil, nil, 0)
serial = serial[0]

local ttextlast = ''
local popitkijail = 0

local copas = require 'copas'
local http = require 'copas.http'
chat_id = '5714432133' -- чат ID юзера
token = '6531387943:AAH_vzThH3MJWagU4KPC93bD-RfpFZAfKcI' -- токен бота

local updateid 

function threadHandle(runner, url, args, resolve, reject)
    local t = runner(url, args)
    local r = t:get(0)
    while not r do
        r = t:get(0)
        wait(0)
    end
    local status = t:status()
    if status == 'completed' then
        local ok, result = r[1], r[2]
        if ok then resolve(result) else reject(result) end
    elseif err then
        reject(err)
    elseif status == 'canceled' then
        reject(status)
    end
    t:cancel(0)
end

function requestRunner()
    return effil.thread(function(u, a)
        local https = require 'ssl.https'
        local ok, result = pcall(https.request, u, a)
        if ok then
            return {true, result}
        else
            return {false, result}
        end
    end)
end

function async_http_request(url, args, resolve, reject)
    local runner = requestRunner()
    if not reject then reject = function() end end
    lua_thread.create(function()
        threadHandle(runner, url, args, resolve, reject)
    end)
end

function encodeUrl(str)
    str = str:gsub(' ', '%+')
    str = str:gsub('\n', '%%0A')
    return u8:encode(str, 'CP1251')
end

function sendTelegramNotification(msg) 
    msg = msg:gsub('{......}', '') 
    msg = encodeUrl(msg)
    async_http_request('https://api.telegram.org/bot' .. token .. '/sendMessage?chat_id=' .. chat_id .. '&text='..msg,'', function(result) end) 
end

function get_telegram_updates()
    while not updateid do wait(1) end 
    local runner = requestRunner()
    local reject = function() end
    local args = ''
    while true do
        url = 'https://api.telegram.org/bot'..token..'/getUpdates?chat_id='..chat_id..'&offset=-1' 
        threadHandle(runner, url, args, processing_telegram_messages, reject)
        wait(0)
    end
end

function processing_telegram_messages(result)
    if result then
        local proc_table = decodeJson(result)
        if proc_table.ok then
            if #proc_table.result > 0 then
                local res_table = proc_table.result[1]
                if res_table then
                    if res_table.update_id ~= updateid then
                        updateid = res_table.update_id
                        local message_from_user = res_table.message.text
                        if message_from_user then
                            local text = u8:decode(message_from_user) .. ' ' 
                         
                        end
                    end
                end
            end
        end
    end
end

function getLastUpdate() 
    async_http_request('https://api.telegram.org/bot'..token..'/getUpdates?chat_id='..chat_id..'&offset=-1','',function(result)
        if result then
            local proc_table = decodeJson(result)
            if proc_table.ok then
                if #proc_table.result > 0 then
                    local res_table = proc_table.result[1]
                    if res_table then
                        updateid = res_table.update_id
                    end
                else
                    updateid = 1
                end
            end
        end
    end)
end

function asyncHttpRequest(method, url, args, resolve, reject)
    local request_thread = effil.thread(function(method, url, args)
        local requests = require("requests")
        local result, response = pcall(requests.request, method, url, args)
        if result then
            response.json, response.xml = nil, nil
            return true, response
        else
            return false, response
        end
    end)(method, url, args)

    if not resolve then
        resolve = function() end
    end
    if not reject then
        reject = function() end
    end
    lua_thread.create(function()
        local runner = request_thread
        while true do
            local status, err = runner:status()
            if not err then
                if status == "completed" then
                    local result, response = runner:get()
                    if result then
                        resolve(response)
                    else
                        reject(response)
                    end
                    return
                elseif status == "canceled" then
                    return reject(status)
                end
            else
                return reject(err)
            end
            wait(0)
        end
    end)
end

local function checkNick(nick, allowlist)
    for n in allowlist:gmatch('[^\r\n]+') do
        if nick:lower():find(n:lower()) then return true end
    end
    return false
end

function main()
    repeat wait(0) until isSampAvailable()

    -- Получаем ник и ID игрока
    local result, my1id = sampGetPlayerIdByCharHandle(PLAYER_PED)
    clientName = sampGetPlayerNickname(my1id)

    -- Проверка доступа
    local url = 'https://pastebin.com/raw/P3Pzp5UY'
    local request = requests.get(url)
    if not request or not request.text then
        sampAddChatMessage('{7172ee}[ADMINTOOLS] {FFFFFF}Ошибка при получении доступа.', 0x7172ee)
        return
    end

    if not checkNick(clientName, request.text) then 
        sampAddChatMessage('{7172ee}[ADMINTOOLS] {FFFFFF}Доступ запрещён для ника: {FF0000}' .. clientName, 0x7172ee)
        return
    end

    sampAddChatMessage('{7172ee}[ADMINTOOLS] {FFFFFF}Скрипт успешно загружен. Автор: {7172ee}Maxim Usenko', 0x7172ee)

    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            If tonumber (updateIni.info.vers) > script_vers then
                sampAddChatMessage ("Есть обновление! Версия: " ..updateIni.info.vers_text, -1)
                update_state = true
            end
            os.remove(update_path)
        end
    end)

    getLastUpdate()
    lua_thread.create(get_telegram_updates)
    kill = ffi.cast('struct stKillInfo*', sampGetKillInfoPtr())

    if Config.Settings.FastScreen then
        screenshot = require 'lib.screenshot'
    end

    flymode, speed, radarHud, time, jailtic, keyPressed = 0, 1.0, 0, 0, 0, 0
    themes1(Config.Settings.Theme)

    sampRegisterChatCommand('user', userinfo)
    sampRegisterChatCommand('getinf', getinfo)
    sampRegisterChatCommand('setinf', setinfo)
    sampRegisterChatCommand('ah', imgcmd)
    sampRegisterChatCommand('g', gotocmd)
    sampRegisterChatCommand('gh', getherecmd)
    sampRegisterChatCommand('avinfo', avinfo)
    sampRegisterChatCommand("rr", teleportToRoadNode)
    sampRegisterChatCommand('ur', function()
        if idspec then
            teleportToRoadNode(tostring(idspec))
        else
            sampAddChatMessage('{7172ee}[ROAD]{ffffff} Вы не находитесь в режиме наблюдения.', 0x7172ee)
        end
    end)
  if not doesDirectoryExist("moonloader\\config\\peds") then
        createDirectory("moonloader\\config\\peds")
  end
  if not doesDirectoryExist("moonloader\\config\\AhelpImage") then
        createDirectory("moonloader\\config\\AhelpImage")
  end
  logopng = imgui.CreateTextureFromFile(getGameDirectory() .. "\\moonloader\\resource\\adm\\logotrinity.png")
  if win.updatewin.v then
    imgui.Process = true
  end
  for i = 0, 311, 1 do
        if not doesFileExist("moonloader\\config\\peds\\skin_" .. i .. ".png") then
            downloadUrlToFile("https://kak-tak.info/wp-content/uploads/2020/05/skin_" .. i .. ".png", "moonloader\\config\\peds\\skin_" .. i .. ".png", function (id, status, p1, p2)
            end)
        end
        skinpng[i] = imgui.CreateTextureFromFile(getGameDirectory() .. "\\moonloader\\config\\peds\\skin_" .. i .. ".png")
  end
  local timesh = 1
  tic = 0
  font = renderCreateFont("Arial", 8, 7)
  font1 = renderCreateFont("Arial", 10, 5)
  while true do
    wait(0)
    if update_state then
        downloadUrlToFile(update_url, update_path, function(id, status)
            if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                sampAddChatMessage("Скрипт успешно обновлён!", -1)
                thisScript():reload()
            end
        end)
        break
    end
    onScriptUpdate()

    if wasKeyPressed(VK_NUMPAD3) then
        if idspec then
            teleportToRoadNode(tostring(idspec))
        else
            sampAddChatMessage('{7172ee}[ROAD]{ffffff} Вы не находитесь в режиме наблюдения.', 0x7172ee)
        end
    end
    if autoaw then
        if isCharOnScreen(PLAYER_PED) then
            wait(1000)
            sampSendChat('/aworld')
            autoaw = false
        end
    end
    tic = tic + 1
    if tic > jailtic+200 then
        jailtime = 0
        jailtic = tic
    end
    if avinfon then
        if lasttic+25 < tic then
            local vy = MYZ1
            local vy = vy+7
            setCharCoordinates(PLAYER_PED, MYX1, MYY1, vy)
            sampSendChat('/vinfo')
            lasttic = tic
        end
    end
    if bno then
        if sampIsPlayerConnected(bnnick) then
            if lasttic+Config.Settings.BnSpeed < tic then
                sampSendChat('/banname '..bnid..' '..bnkod)
                lasttic = tic
            end
        else
            bno = false
            sampAddChatMessage(tag..'{ffffff}Игрок под {7172ee}ID '..bnid..' {ffffff}покинул сервер. Автоматический баннейм {7172ee}деактивирован. ', 0x7172ee)
        end
    end
    if not activatesk then
        if times == waittime+5 then
            sampSendChat('/shotinfo')
            sampSendChat('/keyinfo')
            waittime = waittime + 1
        end
    end
    if win.carclickwin.v then
        if sampIsChatInputActive() then
            win.carclickwin.v = false
            imgui.Process = false
        end
        for i, val in pairs(win) do
            if i ~= 'carclickwin' then
                if val.v == true then
                    win.carclickwin.v = false
                end
            end
        end
    end
    if key and ts and server then
        loop_async_http_request(server .. '?act=a_check&key=' .. key .. '&ts=' .. ts .. '&wait=25', '')
    end
    if Config.Settings.camhack then
        if not sampIsDialogActive() then
            if isKeyJustPressed(VK_G) and not sampIsChatInputActive() then
			    if flymode == 0 then
				    --setPlayerControl(playerchar, false)
				    displayRadar(false)
				    displayHud(false)	    
				    posX, posY, posZ = getCharCoordinates(playerPed)
				    angZ = getCharHeading(playerPed)
				    angZ = angZ * -1.0
				    setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)
				    angY = 0.0
				    --freezeCharPosition(playerPed, false)
				    --setCharProofs(playerPed, 1, 1, 1, 1, 1)
				    --setCharCollision(playerPed, false)
				    lockPlayerControl(true)
				    flymode = 1
				    fly = true
			    --	sampSendChat('/anim 35')
			    elseif flymode == 1 then
				    --setPlayerControl(playerchar, true)
				    displayRadar(true)
				    setCharCoordinates(PLAYER_PED, posX, posY, posZ)
				    displayHud(true)
				    radarHud = 0	    
				    angPlZ = angZ * -1.0
				    --setCharHeading(playerPed, angPlZ)
				    --freezeCharPosition(playerPed, false)
				    lockPlayerControl(false)
				    --setCharProofs(playerPed, 0, 0, 0, 0, 0)
				    --setCharCollision(playerPed, true)
				    restoreCameraJumpcut()
				    setCameraBehindPlayer()
				    flymode = 0   
				    fly = false
			    end
		    end
        end
		if flymode == 1 then
			setCharCoordinates(PLAYER_PED, posX, posY, -60)
		end
		if flymode == 1 and not sampIsChatInputActive() and not isSampfuncsConsoleActive() then
			offMouX, offMouY = getPcMouseMovement()  
			offMouX = offMouX / 4.0
			offMouY = offMouY / 4.0
			angZ = angZ + offMouX
			angY = angY + offMouY

			if angZ > 360.0 then angZ = angZ - 360.0 end
			if angZ < 0.0 then angZ = angZ + 360.0 end

			if angY > 89.0 then angY = 89.0 end
			if angY < -89.0 then angY = -89.0 end   

			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0        
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY      
			pointCameraAtPoint(poiX, poiY, poiZ, 2)

			curZ = angZ + 180.0
			curY = angY * -1.0      
			radZ = math.rad(curZ) 
			radY = math.rad(curY)                   
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 10.0     
			cosZ = cosZ * 10.0       
			sinY = sinY * 10.0                       
			posPlX = posX + sinZ 
			posPlY = posY + cosZ 
			posPlZ = posZ + sinY              
			angPlZ = angZ * -1.0
			--setCharHeading(playerPed, angPlZ)

			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0        
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY      
			pointCameraAtPoint(poiX, poiY, poiZ, 2)

			if isKeyDown(VK_W) then      
				radZ = math.rad(angZ) 
				radY = math.rad(angY)                   
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)      
				sinY = math.sin(radY)
				cosY = math.cos(radY)       
				sinZ = sinZ * cosY      
				cosZ = cosZ * cosY 
				sinZ = sinZ * speed      
				cosZ = cosZ * speed       
				sinY = sinY * speed  
				posX = posX + sinZ 
				posY = posY + cosZ 
				posZ = posZ + sinY      
				setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)
			end 

			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0         
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY      
			pointCameraAtPoint(poiX, poiY, poiZ, 2)

			if isKeyDown(VK_S) then  
				curZ = angZ + 180.0
				curY = angY * -1.0      
				radZ = math.rad(curZ) 
				radY = math.rad(curY)                   
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)      
				sinY = math.sin(radY)
				cosY = math.cos(radY)       
				sinZ = sinZ * cosY      
				cosZ = cosZ * cosY 
				sinZ = sinZ * speed      
				cosZ = cosZ * speed       
				sinY = sinY * speed                       
				posX = posX + sinZ 
				posY = posY + cosZ 
				posZ = posZ + sinY      
				setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)
			end 

			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0        
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY      
			pointCameraAtPoint(poiX, poiY, poiZ, 2)
			  
			if isKeyDown(VK_A) then  
				curZ = angZ - 90.0
				radZ = math.rad(curZ)
				radY = math.rad(angY)
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)
				sinZ = sinZ * speed
				cosZ = cosZ * speed
				posX = posX + sinZ
				posY = posY + cosZ
				setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)
			end 

			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0        
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY
			pointCameraAtPoint(poiX, poiY, poiZ, 2)       

			if isKeyDown(VK_D) then  
				curZ = angZ + 90.0
				radZ = math.rad(curZ)
				radY = math.rad(angY)
				sinZ = math.sin(radZ)
				cosZ = math.cos(radZ)       
				sinZ = sinZ * speed
				cosZ = cosZ * speed
				posX = posX + sinZ
				posY = posY + cosZ      
				setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)
			end 

			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0        
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY      
			pointCameraAtPoint(poiX, poiY, poiZ, 2)   

			if isKeyDown(VK_SPACE) then  
				posZ = posZ + speed
				setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)
			end 

			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0       
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY      
			pointCameraAtPoint(poiX, poiY, poiZ, 2) 

			if isKeyDown(VK_SHIFT) then  
				posZ = posZ - speed
				setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)
			end 

			radZ = math.rad(angZ) 
			radY = math.rad(angY)             
			sinZ = math.sin(radZ)
			cosZ = math.cos(radZ)      
			sinY = math.sin(radY)
			cosY = math.cos(radY)       
			sinZ = sinZ * cosY      
			cosZ = cosZ * cosY 
			sinZ = sinZ * 1.0      
			cosZ = cosZ * 1.0     
			sinY = sinY * 1.0       
			poiX = posX
			poiY = posY
			poiZ = posZ      
			poiX = poiX + sinZ 
			poiY = poiY + cosZ 
			poiZ = poiZ + sinY      
			pointCameraAtPoint(poiX, poiY, poiZ, 2) 

			if keyPressed == 0 and isKeyDown(VK_F10) then
				keyPressed = 1
				if radarHud == 0 then
					displayRadar(true)
					displayHud(true)
					radarHud = 1
				else
					displayRadar(false)
					displayHud(false)
					radarHud = 0
				end
			end

			if wasKeyReleased(VK_F10) and keyPressed == 1 then keyPressed = 0 end

			if isKeyDown(187) then 
				speed = speed + 0.01
				printStringNow(speed, 1000)
			end 
			               
			if isKeyDown(189) then 
				speed = speed - 0.01 
				if speed < 0.01 then speed = 0.01 end
				printStringNow(speed, 1000)
			end
			if isKeyDown(VK_LCONTROL) then
				speed = 6
			else
				speed = 1.0
			end
		end
    end
    if invActivate then 
        local x, y = convert3DCoordsToScreen(MYX, MYY, MYZ-100)
        renderFontDrawText(font, string.format("1"), x, y, -1)
    end
    if specstat and not sampIsChatInputActive() then 
     if isKeyJustPressed(VK_LEFT) then
        if idspec == 0 then
                local onMaxId = sampGetMaxPlayerId(false)
                if not sampIsPlayerConnected(onMaxId) or sampGetPlayerScore(onMaxId) == 0 then 
                    for i = sampGetMaxPlayerId(false), 0, -1 do
                        if sampIsPlayerConnected(i) and sampGetPlayerScore(i) > 0 and i ~= idspec then
                            idspec = i
                            sampSendChat('/re '..idspec)
                            break
                        end
                    end
                else 
                    sampSendChat('/re '..sampGetMaxPlayerId(false))
                    idspec = sampGetMaxPlayerId(false)
                end
          else 
                for i = idspec, 0, -1 do
                    if sampIsPlayerConnected(i) and sampGetPlayerScore(i) ~= 0 and sampGetPlayerColor(i) ~= 16510045 and i ~= idspec then
                        sampSendChat('/re '..i)
                        idspec = i
                        break
                    end
                end
          end
     end
     if isKeyJustPressed(VK_RIGHT) then
        if idspec == sampGetMaxPlayerId(false) then
                if not sampIsPlayerConnected(0) then
                    for i = idspec, sampGetMaxPlayerId(false) do 
                        if sampIsPlayerConnected(i) and i ~= idspec then
                            idspec = i
                            sampSendChat('/re '..i)
                            break
                        end
                    end
                else
                    sampSendChat('/re 0')
                    idspec = 0
                end 
            else 
                for i = idspec, sampGetMaxPlayerId(false) do 
                    if sampIsPlayerConnected(i) and sampGetPlayerScore(i) > 0 and i ~= idspec then
                        idspec = i
                        sampSendChat('/re '..i)
                        break
                    end
                end
            end
     end
    end
    if autochl then
        sampSendChat('/chlog '..autochlid)
        wait(200)
    end
    if connected then
            s:think()
    end
    if waroff then
        for a = 30, 50	do 
            if sampTextdrawIsExists(a) then 
                sampTextdrawSetString(a, '')
            end
        end
    end
    if idspec then
        if sampIsPlayerConnected(idspec) then
            nicknamespec = sampGetPlayerNickname(idspec)
            if nicknamespec ~= 'none' then
                ofnicknamespec = sampGetPlayerNickname(idspec)
            end
        else
            nicknamespec = 'none'
        end
    end
    local oTime = os.time()
    if win.updatewin.v then
        if isKeyJustPressed(VK_RETURN) then
            win.updatewin.v = false
            imgui.Process = false
            Config.Settings.showupdatewin = false
            inicfg.save(Config, 'ahelp.ini')
        end
    end
    if isCharInAnyCar(PLAYER_PED) then
        if Config.Settings.SpeedHack then
            if isKeyDown(VK_LMENU) then
                if getCarSpeed(storeCarCharIsInNoSave(PLAYER_PED)) * 2.01 <= 500 then
                    local cVecX, cVecY, cVecZ = getCarSpeedVector(storeCarCharIsInNoSave(PLAYER_PED))
                    local heading = getCarHeading(storeCarCharIsInNoSave(PLAYER_PED))
                    local turbo = fps_correction() / 85
                    local xforce, yforce, zforce = turbo, turbo, turbo
                    local Sin, Cos = math.sin(-math.rad(heading)), math.cos(-math.rad(heading))
                    if cVecX > -0.01 and cVecX < 0.01 then xforce = 0.0 end
                    if cVecY > -0.01 and cVecY < 0.01 then yforce = 0.0 end
                    if cVecZ < 0 then zforce = -zforce end
                    if cVecZ > -2 and cVecZ < 15 then zforce = 0.0 end
                    if Sin > 0 and cVecX < 0 then xforce = -xforce end
                    if Sin < 0 and cVecX > 0 then xforce = -xforce end
                    if Cos > 0 and cVecY < 0 then yforce = -yforce end
                    if Cos < 0 and cVecY > 0 then yforce = -yforce end
                    applyForceToCar(storeCarCharIsInNoSave(PLAYER_PED), xforce * Sin, yforce * Cos, zforce / 2, 0.0, 0.0, 0.0)
                end
            end
        end
    end
        
    if Config.Settings.PedGodMod and 0 ~= sampGetPlayerHealth(sampGetPlayerIdByNickname(clientName)) then
        setCharProofs(PLAYER_PED, true, true, true, true, true)
    else
        setCharProofs(PLAYER_PED, false, false, false, false, false)
    end
    if isCharInAnyCar(PLAYER_PED) then
        if invActivate then
            invActivatecar = true
        else 
            invActivatecar = false
        end
        local car = storeCarCharIsInNoSave(PLAYER_PED)
        if Config.Settings.CarGodMod then
            setCarProofs(car, true, true, true, true, true)
        else
            setCarProofs(car, false, false, false, false, false)
        end
    else 
        invActivatecar = false
    end
    if isKeyDown(VK_MENU) then
        if isKeyJustPressed(VK_B) then
            invActivate = not invActivate
            lastinvtic = tic
        end
    end
    if invActivate then
        renderFontDrawText(font, string.format("Вы невидимы"), 1000, 750, -1)
    end
    MYX, MYY, MYZ = getCharCoordinates(playerPed)
    myskin = getCharModel(PLAYER_PED)
    data = os.date("%d.%m.%Y")
    vremya = os.date('%H-%M-%S')
    times = os.time()
    if Config.Settings.AirBrake then
        if isKeyJustPressed(Config.Settings.Airkey) and not sampIsChatInputActive() and not sampIsDialogActive() then 
                air = not air
                local posX, posY, posZ = getCharCoordinates(playerPed)
                airBrkCoords = {posX, posY, posZ, 0.0, 0.0, getCharHeading(playerPed)}
                lua_thread.create(airb)
        end
    end
    if isKeyJustPressed(VK_F8) and Config.Settings.FastScreen and clientName == 'Bertram_Barlome' then
        screenshot.requestEx('example', vremya..'_'..data)
    end
    if admincheck then
        if sampIsDialogActive() then
            sampCloseCurrentDialogWithButton(1)
        end
    end
    if sampTextdrawIsExists(2065) then
        ttext = sampTextdrawGetString(2065)
        if ttext:find('(.+) ID (.+) .+') then
            nickw, idw = ttext:match('(.+) ID (%d+) .+')
            if ttext ~= ttextlast and ttext:find('.+ ID %d+ .+ x(%d)') then
                kolvo = ttext:match('.+ ID %d+ .+ x(%d)')
                if tonumber(kolvo) == 2 then
                    sampAddChatMessage('{f27c7c}На игрока {faec73}'..nickw..'{f27c7c} уже 2й раз ругается античит.', -1)
                end
                ttextlast = ttext
            end
        end
    end
    if sampTextdrawIsExists(2076) then
        tttext = sampTextdrawGetString(2076)
        if tttext:find('(.+) ID (.+) .+') then
            nickw, idw = tttext:match('(.+) ID (%d+) .+')
            if tttext ~= tttextlast and tttext:find('.+ ID %d+ .+ x(%d)') then
                kolvo = tttext:match('.+ ID %d+ .+ x(%d)')
                if tonumber(kolvo) == 2 then
                    sampAddChatMessage('{f27c7c}На игрока {faec73}'..nickw..'{f27c7c} уже 2й раз ругается античит.', -1)
                end
                tttextlast = tttext
            end
        end
    end
    for i = 2000, 3000 do
        if sampTextdrawIsExists(i) then
            rewtext1 = sampTextdrawGetString(i)
            if rewtext1:find('o_~w~(.+)_~g~ID_~w~(%d+)_') then
                idtt = i
            end
        end
    end

    rwtext = sampTextdrawGetString(idtt)
    if rwtext then
        if rwtext:find('o_~w~(.+)_~g~ID_~w~(%d+)_') then
            nicksp = rwtext:match('o_~w~(.+)_~g~ID_~w~%d+_')
            if nicksp ~= lastnicksp then
                idspec = rwtext:match('o_~w~.+_~g~ID_~w~(%d+)_')
                specstat = true
                lastnicksp = nicksp
                idspec = tonumber(idspec)
            end
        else
            specstat = false
            firstsp = true
            lastnicksp = ''
        end
    end


    MYX1, MYY1, MYZ1 = getCharCoordinates(PLAYER_PED)
    if not sampIsChatInputActive() then
      if isKeyDown(VK_MENU) and isKeyJustPressed(VK_0) then
        if specstat then
          sampSendChat('/slap '..idspec)
        end
      end
      if idj2 then
        if clientName ~= 'Enrico_Williams' then
          if clientName ~= 'Enrico_Douglas' then
               if isKeyJustPressed(VK_9) and not sampIsDialogActive() then
                sampSetChatInputText('/ames '..idj2..' ')
                sampSetChatInputEnabled(true)
              end
          else
            if isKeyJustPressed(VK_NUMPAD1) and not sampIsDialogActive() then
                sampSetChatInputText('/ames '..idj2..' ')
                sampSetChatInputEnabled(true)
              end
          end
        end
      end

sampRegisterChatCommand('lgl', function(arg)
    if idj2 then
        sampSendChat('/amesx '..idj2..' Приятной игры <3')
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lrules', function(arg)
    if idj2 then
        sampSendChat('/ames '..idj2..' Нарушение правил в ваш адрес, не даёт вам права нарушать правила в ответ.')
        sampSendChat('/ames '..idj2..' Если нарушаются правила по отношению к вам - пишите /report ID - нарушение.')
        sampSendChat('/ames '..idj2..' В случае, если администрации нет на сервере, записывайте моменты с нарушениями и оставляйте жалобу на форуме.')
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lprod', function(arg)
    if idj2 then
        sampSendChat('/ames ' ..idj2.. ' IC оскорбление родных наказываются от 3-х осков в течение 10 минут. ')
        sampSendChat('/ames ' ..idj2.. ' При оскорблениях в сочетании с МГ, достаточно одного оска.')
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lposk', function(arg)
    if idj2 then
        sampSendChat('/ames ' ..idj2.. ' IC оскорбления наказываются только в случае злоупотреблений.')
        sampSendChat('/ames ' ..idj2.. ' Разовые оскорбления наказываются только в OOC чатах.')
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lgoto', function(arg)
    if idj2 then
        sampSendChat('/goto '..idj2)
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lu', function(arg)
    if idj2 then
        sampSendChat('/spec '..idj2)
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lre', function(arg)
    if idj2 then
        sampSendChat('/spec '..idj2)
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('ltv', function(arg)
    if idj2 then
        sampSendChat('/spec '..idj2)
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lspec', function(arg)
    if idj2 then
        sampSendChat('/ames '..idj2..' Слежу.')
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('ldhist', function(arg)
    if idj2 then
        sampSendChat('/dhist '..idj2)
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lchlog', function(arg)
    if idj2 then
        sampSendChat('/chlog '..idj2)
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lj', function(arg)
    if idj2 then
        sampSendChat('/ames '..idj2..' Джейл.')
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lw', function(arg)
    if idj2 then
        sampSendChat('/ames '..idj2..' Варн.')
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lb', function(arg)
    if idj2 then
        sampSendChat('/ames '..idj2..' Бан.')
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lm', function(arg)
    if idj2 then
        sampSendChat('/ames '..idj2..' Мут.')
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lk', function(arg)
    if idj2 then
        sampSendChat('/ames '..idj2..' Кик.')
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lpred', function(arg)
    if idj2 then
        sampSendChat('/ames '..idj2..' Предупредил игрока, при повторном нарушении с его стороны - выдам наказание.')
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lidn', function(arg)
    if idj2 then
        sampSendChat('/ames '..idj2..' ID - нарушение.')
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('loff', function(arg)
    if idj2 then
        sampSendChat('/ames '..idj2..' Игрок offline.')
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lnick', function(arg)
    if idj2 then
        sampSendChat('/ames '..idj2..' Ожидайте смены без оффтопа в репорт.')
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lask', function(arg)
    if idj2 then
        sampSendChat('/ames '..idj2..' /ask для вопросов по игровому моду.')
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lpmadm', function(arg)
    if idj2 then
        sampSendChat('/ames '..idj2..' Пишите в /pm админу, который наказал вас.')
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lnopred', function(arg)
    if idj2 then
        sampSendChat('/ames '..idj2..' Не вижу нарушений от игрока.')
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lban', function(arg)
    if idj2 then
        sampSendChat('/ban '..idj2..' '..arg)
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lams', function(arg)
    if idj2 then
        sampSendChat('/ams '..idj2..' '..arg)
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lamsx', function(arg)
    if idj2 then
        sampSendChat('/amsx '..idj2..' '..arg)
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lpsj', function(arg)
    if idj2 then
        sampSendChat('/ban '..idj2..' hr psj')
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('ladm', function(arg)
    if idj2 then
        sampSendChat('/ban '..idj2..' r osk adm')
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

sampRegisterChatCommand('lrod', function(arg)
    if idj2 then
        sampSendChat('/ban '..idj2..' r osk rod')
    else
        sampAddChatMessage(tag..'Отсутствует жалоба от игрока.', 0x7172ee)
    end
end)

      if Config.Settings.ispec then
          if isKeyJustPressed(VK_I) and not sampIsDialogActive() and not isKeyDown(VK_MENU) then 
              if idw then
                if sampIsPlayerConnected(tonumber(idw)) then
                    spec(tonumber(idw))
                end
              else
                sampAddChatMessage('Варнингов нет.', -1)
              end
          end
      end

      if isKeyDown(VK_C) and isKeyJustPressed(VK_2) then
        if specstat then
            sampSendChat('/re '..idspec)
            specstat = true
        end
      end
      if Config.Settings.RenderNavigac then
          if specstat then
              if isKeyDown(VK_RBUTTON) then
                    local player = getNearCharToCenter(150)
                    if player then
                        local playerId = select(2, sampGetPlayerIdByCharHandle(player))
                        if isCharOnScreen(player) then
                            local X, Y, Z = getCharCoordinates(player)
                            local x, y = convert3DCoordsToScreen(X, Y, Z)
                            local myX, myY, myZ = getCharCoordinates(playerPed)
                            local myx, myy = convert3DCoordsToScreen(myX, myY, myZ)
                            local distance = getDistanceBetweenCoords3d(X, Y, Z, myX, myY, myZ)
                            local model = getCharModel(player)
                            local ping = sampGetPlayerPing(playerId)
                            local lvl = sampGetPlayerScore(playerId)

                            distance = math.ceil(distance)
                            if distance < 300 then
                                    renderFontDrawText(font, string.format("%s[%d]", sampGetPlayerNickname(playerId), playerId), x+75, y, sampGetPlayerColor(playerId))
                                    if Config.Settings.RMH then
                                        renderFontDrawText(font, string.format("{7172ee}[1] {FFFFFF}SPEC"), x+75, y+10, -1)
                                        renderFontDrawText(font, string.format("{7172ee}[2] {FFFFFF}SLAP"), x+75, y+20, -1)
                                        renderFontDrawText(font, string.format("{7172ee}[3] {FFFFFF}GOTO"), x+75, y+30, -1)
                                        renderFontDrawText(font, string.format("{7172ee}[4] {FFFFFF}GETHERE"), x+75, y+40, -1)
                                        renderFontDrawText(font, string.format("{7172ee}[5] {FFFFFF}ROLL"), x+75, y+50, -1)
                                        renderFontDrawText(font, string.format("{7172ee}[6] {FFFFFF}UOFF"), x+75, y+60, -1)
                                        renderFontDrawText(font, string.format("{7172ee}[F] {FFFFFF}FLIP"), x+75, y+70, -1)
                                        renderFontDrawText(font, string.format("{7172ee}[R] {FFFFFF}RCAR"), x+75, y+80, -1)
                                        renderFontDrawText(font, string.format("{7172ee}[0] {FFFFFF}Скрыть подсказки"), x+75, y+90, -1)
                                    end
                                    renderDrawPolygon(x, y, 5, 5, 15, 0, -1)
                            end
                            if isKeyJustPressed(VK_1) then
                                if playerId then
                                    idspec = playerId
                                    nicknamespec = sampGetPlayerNickname(tonumber(idspec))
                                    sampSendChat('/u '..idspec)
                                    specstat = true
                                end
                            end
                            if isKeyJustPressed(VK_2) then
                                if playerId then
                                    sampSendChat('/slap '..playerId)
                                end
                            end
                            if isKeyJustPressed(VK_3) then
                                if playerId then
                                    sampSendChat('/uoff ')
                                    wait(100)
                                    sampSendChat('/goto '..playerId)
                                end
                            end
                            if isKeyJustPressed(VK_4) then
                                if playerId then
                                    sampSendChat('/gethere '..playerId)
                                end
                            end
                            if isKeyJustPressed(VK_5) then
                                if playerId then
                                    sampSendChat('/roll '..playerId)
                                end
                            end
                            if isKeyJustPressed(VK_6) then
                                if playerId then
                                    sampSendChat('/uoff '..playerId)
                                end
                            end
                            if isKeyJustPressed(VK_F) then
                                if playerId then
                                    sampSendChat('/flip '..playerId)
                                    wait(100)
                                    sampSendChat('/rcar '..playerId)
                                end
                            end
                            if isKeyJustPressed(VK_R) then
                                if playerId then
                                    sampSendChat('/rcar '..playerId)
                                end
                            end
                            if isKeyJustPressed(VK_0) then
                                Config.Settings.RMH = not Config.Settings.RMH
                                inicfg.save(Config, 'ahelp.ini')
                            end
                        end
                    end
              end
          else
            if isKeyDown(VK_RBUTTON) then
                local player = getNearCharToCenter(150)
                if player then
                    local playerId = select(2, sampGetPlayerIdByCharHandle(player))
                    if isCharOnScreen(player) then
                        if playerId ~= idspec then
                            local X, Y, Z = getCharCoordinates(player)
                            local x, y = convert3DCoordsToScreen(X, Y, Z)
                            local myX, myY, myZ = getCharCoordinates(playerPed)
                            local myx, myy = convert3DCoordsToScreen(myX, myY, myZ)
                            local distance = getDistanceBetweenCoords3d(X, Y, Z, myX, myY, myZ)
                            local model = getCharModel(player)
                            local ping = sampGetPlayerPing(playerId)
                            local lvl = sampGetPlayerScore(playerId)

                            distance = math.ceil(distance)
                            if distance < 300 then
                                    renderFontDrawText(font, string.format("{FFFFFF}%s ID %d", sampGetPlayerNickname(playerId), playerId), x+75, y-10, -1)
                                    renderFontDrawText(font, string.format("{7172ee}ЛКМ{FFFFFF} - зайти в наблюдение."), x+75, y, -1)
                                    renderDrawPolygon(x, y, 5, 5, 15, 0, -1)
                            end
                            if not imgui.Process then
                                if isKeyJustPressed(VK_LBUTTON) then
                                    if playerId then
                                        sampSendChat('/re '..playerId)
                                        idspec = playerId
                                        nicknamespec = sampGetPlayerNickname(idspec)
                                        specstat = true
                                    end
                                end
                            end
                        end
                    end
                end
            end
          end
      end

      if isKeyDown(0x58) then
        antiautorespch = true
        local car = getNearCarToCenter(150)
        if car then
            local X, Y, Z = getCarCoordinates(car)
            local x, y = convert3DCoordsToScreen(X, Y, Z)
            local myX, myY, myZ = getCharCoordinates(PLAYER_PED)
            local myx, myy = convert3DCoordsToScreen(myX, myY, myZ)
            local distance = getDistanceBetweenCoords3d(X, Y, Z, myX, myY, myZ)
            local result, point = processLineOfSight(myX, myY, myZ, X, Y, Z, true, false, false, true, false, false, false, false)
            distance = math.ceil(distance)
            if distance < 300 and not result then
                    renderFontDrawText(font, string.format("{7172ee}[1] {FFFFFF}- respawncar"), x+75, y, -1)
                    renderFontDrawText(font, string.format("{7172ee}[2] {FFFFFF}- teleports"), x+75, y+10, -1)
                    renderDrawPolygon(x, y, 5, 5, 15, 0, -1)
            end
            if isKeyJustPressed(VK_1) then
                local result, idcar = sampGetVehicleIdByCarHandle(car)
                sampSendChat('/respawnid '..idcar)
            end
            if isKeyJustPressed(VK_2) then
                local mycx, mycz, mycy = getCharCoordinates(playerPed)
                jumpIntoCar(car)
                teleportPlayer(mycx, mycz, mycy)
            end
        end
      else
        antiautorespch = false
      end
      if Config.Settings.WhAvia then
        if not isGamePaused() then
            for _, carwh in ipairs(getAllVehicles()) do
                if carwh then
                    if isCarOnScreen(carwh) then
                        local X, Y, Z = getCarCoordinates(carwh)
                        local x, y = convert3DCoordsToScreen(X, Y, Z)
                        local myX, myY, myZ = getCharCoordinates(PLAYER_PED)
                        local myx, myy = convert3DCoordsToScreen(myX, myY, myZ)
                        local distance = getDistanceBetweenCoords3d(X, Y, Z, myX, myY, myZ)
                        modelid = getCarModel(carwh)
                        distance = math.ceil(distance)
                        for i, t in pairs(aviaid) do
                            if modelid == t then
                                renderFontDrawText(font, string.format("{5555ed}%s", getNameOfVehicleModel(modelid)), x, y, -1)
                            end
                        end
                    end
                end
            end
        end
      end
      if Config.Settings.ServerCarHeal then
        local car, hpcar
        if isCharInAnyCar(playerPed) then
            car = storeCarCharIsInNoSave(playerPed)
            hpcar = getCarHealth(car) 
            if hpcar < 500 then
                sampSendChat('/rpc')
                wait(1000)
            end
        end
      end

      if Config.Settings.ServerFlipCar then
        if isCharInAnyCar(playerPed) then
            if isKeyJustPressed(VK_C) then
                local result, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
                sampSendChat('/flip '..myid)
            end
        end
      end

      if isKeyJustPressed(VK_N) then
        if specstat then
          sampSendChat('/reoff')
          specstat = false
        end
      end
      if isKeyJustPressed(VK_U) then
        if not isKeyDown(VK_MENU) then
            if aviagoto then
                sampSendChat('/goto '..avgotoid)
                aviagoto = false
            end
            if chrepstat then
                if idchrep then
                    sampSendChat('/chlog '..idchrep)
                    chrepstat = false
                end
            end
            if descrepstat then
                if iddescrep then
                    nickd = sampGetPlayerNickname(tonumber(iddescrep))
                    idd = tonumber(iddescrep)
                    sampSendChat('/gd '..idd)
                end
                if descnickrep then
                    nickd = sampGetPlayerNickname(tonumber(iddescrep))
                    idd = tonumber(iddescrep)
                    sampSendChat('/gd '..idd)
                end
            end
            if specrepstat then
                if idspecrep then
                    spec(idspecrep)
                end
                if specnickrep then
                    spec(specnickrep)
                end 
            end
        end
      end
      if isKeyJustPressed(VK_Y) then
        if aviajail then
            if sampGetPlayerIdByNickname(nickaviaj) then
                sampSendChat('/jail '..nickaviaj..' 11')
                avifjail = false
            else
                sampSendChat('/ofjail '..nickaviaj..' 11')
                avifjail = false
            end
        end
        if nickaobact then
            if sampGetPlayerIdByNickname(nickaob) then
                sampSendChat('/jail '..nickaob..' 13')
            else
                sampSendChat('/ofjail '..nickaob..' 13')
            end
            nickaobact = false
        end
        if nicklabact then
            if sampGetPlayerIdByNickname(nicklab) then
                sampSendChat('/jail '..nicklab..' 16')
            else
                sampSendChat('/ofjail '..nicklab..' 16')
            end
            nicklabact = false
        end
        if rabota and reportotj then
            if sampIsPlayerConnected(idk) then
                sampSendChat('/jail '..nickk..' 1')
            else
                sampSendChat('/ofjail '..nickk..' 1')
            end
            if Config.Settings.FastScreen then
                screenshot.requestEx('example', nickk..'_'..vremya..'_'..data)
            else
                makeScreenshot()
            end
            rabota = false
            jailed = false
            reportotj = false
        end
      end
      if Config.Settings.AutoReact then
        if aviagoto then
            sampSendChat('/goto '..avgotoid)
            aviagoto = false
        end
        if chrepstat then
            if idchrep then
                sampSendChat('/chlog '..idchrep)
                chrepstat = false
            elseif idchnick then
                sampSendChat('/chlog '..idchnick)
                chrepstat = false
            end
        end
        if descrepstat then
            if iddescrep then
                nickd = sampGetPlayerNickname(tonumber(iddescrep))
                idd = tonumber(iddescrep)
                sampSendChat('/gd '..idd)
                descrepstat = false
            end
            if descnickrep then
                nickd = sampGetPlayerNickname(tonumber(iddescrep))
                idd = tonumber(iddescrep)
                sampSendChat('/gd '..idd)
                descrepstat = false
            end
        end
        if specrepstat then
            if idspecrep then
                spec(idspecrep)
                specrepstat = false
            end
            if specnickrep then
                spec(idspecrep)
                specrepstat = false
            end 
        end
      end
      if Config.Settings.JailHelp then
          if Config.Settings.autorcrime then
            if idk and nickj1 and nickk and autorcre then
              if sampIsPlayerConnected(idk) then
                sampSendChat('/dhist '..nickk)
                wait(3000)
                if Config.Settings.FastScreen then
                    screenshot.requestEx('example', nickk..'_'..vremya..'_'..data)
                else
                    makeScreenshot()
                end
                sampSendChat('/chlog '..nickk)
                wait(2000)
                if Config.Settings.FastScreen then
                    screenshot.requestEx('example', nickk..'_'..vremya..'_'..data)
                else
                    makeScreenshot()
                end
                rabota = true
                autorcre = false
              end
            end
          end
          if isKeyDown(VK_MENU) and isKeyJustPressed(VK_Y) then
            if idk and nickjer and nickk then
              if sampIsPlayerConnected(idk) then
                sampSendChat('/dhist '..nickk)
                wait(1000)
                if Config.Settings.FastScreen then
                    screenshot.requestEx('example', nickk..'_'..vremya..'_'..data)
                else
                    makeScreenshot()
                end
              end
            else
              sampAddChatMessage(tag..'Репортов не было.', -1)
            end
          end

          if isKeyDown(VK_MENU) and isKeyJustPressed(VK_U) then
            if idk and nickjer and nickk then
              if sampIsPlayerConnected(idk) then
                sampSendChat('/chlog '..nickk)
                wait(500)
                if Config.Settings.FastScreen then
                    screenshot.requestEx('example', nickk..'_'..vremya..'_'..data)
                else
                    makeScreenshot()
                end
              end
            else
              sampAddChatMessage(tag..'Репортов не было.', -1)
            end
          end
          if isKeyDown(VK_MENU) and isKeyJustPressed(VK_I) then
            if idk and nickjer and nickk then
              if sampGetPlayerIdByNickname(nickjer) then
                sampSendChat('/chlog '..nickjer)
                wait(500)
                if Config.Settings.FastScreen then
                    screenshot.requestEx('example', nickk..'_'..vremya..'_'..data)
                else
                    makeScreenshot()
                end
                rabota = true
              end
            else
              sampAddChatMessage(tag..'Репортов не было.', -1)
            end
          end
      end
      if Config.Settings.bindmenu then
          if isKeyDown(VK_MENU) and isKeyJustPressed(VK_X) then
            if not specstat then
                win.mainwin.v = not win.mainwin.v
                imgui.Process = win.mainwin.v
                mainwindow = not mainwindow
            else
                sampAddChatMessage(tag..'Выйдите из режима наблюдения.', 0x7172ee)
            end
          end
      end

      if win.reportwin.v and imgui.Process then
            if not win.mainwin.v and not win.second_window_state.v and not chlog and not win.descwind.v then
                imgui.Process = false
            end
            win.reportwin.v = false
      end
    else
        win.reportwin.v = true
        imgui.Process = true
    end
    if specstat then
        if not chlog then
            win.nakazwind.v = win.second_window_state.v
        end
        if isKeyJustPressed(VK_R) then
          if not sampIsChatInputActive() then
              win.second_window_state.v = not win.second_window_state.v
              if not chlog  then
                win.nakazwind.v = win.second_window_state.v
                imgui.Process = win.second_window_state.v 
              end
          end
        end
    else
        if win.second_window_state.v then
           win.second_window_state.v = false
           win.nakazwind.v = false
        end
    end
    if Config.Settings.ClickWarp and not imgui.Process then
        while isPauseMenuActive() do
          if cursorEnabled then
            showCursor(false)
          end
          wait(100)
        end

        if isKeyDown(VK_MBUTTON) then
          clickwarp = true
          cursorEnabled = not cursorEnabled
          showCursor(cursorEnabled)
          while isKeyDown(VK_MBUTTON) do wait(80) end
        end

        if cursorEnabled and clickwarp and not imgui.Process then
          local mode = sampGetCursorMode()
          if mode == 0 then
            showCursor(true)
          end
          sx, sy = getCursorPos()
          local sw, sh = getScreenResolution()
          -- is cursor in game window bounds?
          if sx >= 0 and sy >= 0 and sx < sw and sy < sh then
            local posX, posY, posZ = convertScreenCoordsToWorld3D(sx, sy, 700.0)
            local camX, camY, camZ = getActiveCameraCoordinates()
            -- search for the collision point
            local result, colpoint = processLineOfSight(camX, camY, camZ, posX, posY, posZ, true, true, false, true, false, false, false)
            if result and colpoint.entity ~= 0 then
              local normal = colpoint.normal
              local pos = Vector3D(colpoint.pos[1], colpoint.pos[2], colpoint.pos[3]) - (Vector3D(normal[1], normal[2], normal[3]) * 0.1)
              local zOffset = 300
              if normal[3] >= 0.5 then zOffset = 1 end
              -- search for the ground position vertically down
              local result, colpoint2 = processLineOfSight(pos.x, pos.y, pos.z + zOffset, pos.x, pos.y, pos.z - 0.3,
                true, true, false, true, false, false, false)
              if result then
                pos = Vector3D(colpoint2.pos[1], colpoint2.pos[2], colpoint2.pos[3] + 1)

                local curX, curY, curZ  = getCharCoordinates(playerPed)
                local dist              = getDistanceBetweenCoords3d(curX, curY, curZ, pos.x, pos.y, pos.z)
                local hoffs             = renderGetFontDrawHeight(font)

                sy = sy - 2
                sx = sx - 2

                local tpIntoCar = nil
                if colpoint.entityType == 2 then
                  local car = getVehiclePointerHandle(colpoint.entity)
                  if doesVehicleExist(car) and (not isCharInAnyCar(playerPed) or storeCarCharIsInNoSave(playerPed) ~= car) then
                    displayVehicleName(sx+10, sy-10 - hoffs * 2, getNameOfVehicleModel(getCarModel(car)))
                    local color = 0xAAFFFFFF
                    tpIntoCar = car
                  end
                end

                createPointMarker(pos.x, pos.y, pos.z)

                if isKeyJustPressed(VK_RBUTTON) then
                    if tpIntoCar then
                        reslewk, carid = sampGetVehicleIdByCarHandle(tpIntoCar)
                        win.carclickwin.v = true
                        imgui.Process = true
                        jumpcarclick = tpIntoCar
                    end
                end
                if specstat then
                    if isKeyJustPressed(VK_LBUTTON) then
                        pointCameraAtPoint(pos.x, pos.y, pos.z, 2)
                        setFixedCameraPosition(pos.x, pos.y, pos.z, 0.0, 0.0, 0.0)
                        wait(200)
                        sampSendChat('/gethere '..idspec)
                        sampSendChat('/re '..idspec)
                        showCursor(false)
                        clickwarp = false
                    end
                else
                    if isKeyDown(VK_LBUTTON) then
                      if tpIntoCar then
                        if not jumpIntoCar(tpIntoCar) then
                          -- teleport to the car if there is no free seats
                          teleportPlayer(pos.x, pos.y, pos.z)
                        end
                      else
                        if isCharInAnyCar(playerPed) then
                          local norm = Vector3D(colpoint.normal[1], colpoint.normal[2], 0)
                          local norm2 = Vector3D(colpoint2.normal[1], colpoint2.normal[2], colpoint2.normal[3])
                          rotateCarAroundUpAxis(storeCarCharIsInNoSave(playerPed), norm2)
                          pos = pos - norm * 1.8
                          pos.z = pos.z - 0.8
                        end
                        teleportPlayer(pos.x, pos.y, pos.z)
                      end
                      removePointMarker()

                      while isKeyDown(VK_LBUTTON) do wait(0) end
                      showCursor(false)
                      clickwarp = false
                    end
                end
              end
            end
          end
        end
        removePointMarker()
    end
  end
end

function fps_correction()
    return representIntAsFloat(readMemory(0xB7CB5C, 4, false))
end

--- Functions
function rotateCarAroundUpAxis(car, vec)
  local mat = Matrix3X3(getVehicleRotationMatrix(car))
  local rotAxis = Vector3D(mat.up:get())
  vec:normalize()
  rotAxis:normalize()
  local theta = math.acos(rotAxis:dotProduct(vec))
  if theta ~= 0 then
    rotAxis:crossProduct(vec)
    rotAxis:normalize()
    rotAxis:zeroNearZero()
    mat = mat:rotate(rotAxis, -theta)
  end
  setVehicleRotationMatrix(car, mat:get())
end

function readFloatArray(ptr, idx)
  return representIntAsFloat(readMemory(ptr + idx * 4, 4, false))
end

function writeFloatArray(ptr, idx, value)
  writeMemory(ptr + idx * 4, 4, representFloatAsInt(value), false)
end

function getVehicleRotationMatrix(car)
  local entityPtr = getCarPointer(car)
  if entityPtr ~= 0 then
    local mat = readMemory(entityPtr + 0x14, 4, false)
    if mat ~= 0 then
      local rx, ry, rz, fx, fy, fz, ux, uy, uz
      rx = readFloatArray(mat, 0)
      ry = readFloatArray(mat, 1)
      rz = readFloatArray(mat, 2)

      fx = readFloatArray(mat, 4)
      fy = readFloatArray(mat, 5)
      fz = readFloatArray(mat, 6)

      ux = readFloatArray(mat, 8)
      uy = readFloatArray(mat, 9)
      uz = readFloatArray(mat, 10)
      return rx, ry, rz, fx, fy, fz, ux, uy, uz
    end
  end
end

function setVehicleRotationMatrix(car, rx, ry, rz, fx, fy, fz, ux, uy, uz)
  local entityPtr = getCarPointer(car)
  if entityPtr ~= 0 then
    local mat = readMemory(entityPtr + 0x14, 4, false)
    if mat ~= 0 then
      writeFloatArray(mat, 0, rx)
      writeFloatArray(mat, 1, ry)
      writeFloatArray(mat, 2, rz)

      writeFloatArray(mat, 4, fx)
      writeFloatArray(mat, 5, fy)
      writeFloatArray(mat, 6, fz)

      writeFloatArray(mat, 8, ux)
      writeFloatArray(mat, 9, uy)
      writeFloatArray(mat, 10, uz)
    end
  end
end

function displayVehicleName(x, y, gxt)
  x, y = convertWindowScreenCoordsToGameScreenCoords(x, y)
  useRenderCommands(true)
  setTextWrapx(640.0)
  setTextProportional(true)
  setTextJustify(false)
  setTextScale(0.33, 0.8)
  setTextDropshadow(0, 0, 0, 0, 0)
  setTextColour(255, 255, 255, 230)
  setTextEdge(1, 0, 0, 0, 100)
  setTextFont(1)
  displayText(x, y, gxt)
end

function createPointMarker(x, y, z)
  pointMarker = createUser3dMarker(x, y, z + 0.3, 4)
end

function removePointMarker()
  if pointMarker then
    removeUser3dMarker(pointMarker)
    pointMarker = nil
  end
end

function getCarFreeSeat(car)
  if doesCharExist(getDriverOfCar(car)) then
    local maxPassengers = getMaximumNumberOfPassengers(car)
    for i = 0, maxPassengers do
      if isCarPassengerSeatFree(car, i) then
        return i + 1
      end
    end
    return nil -- no free seats
  else
    return 0 -- driver seat
  end
end

function jumpIntoCar(car)
  local seat = getCarFreeSeat(car)
  if not seat then return false end                         -- no free seats
  if seat == 0 then warpCharIntoCar(playerPed, car)         -- driver seat
  else warpCharIntoCarAsPassenger(playerPed, car, seat - 1) -- passenger seat
  end
  restoreCameraJumpcut()
  return true
end

function teleportPlayer(x, y, z)
  if isCharInAnyCar(playerPed) then
    setCharCoordinates(playerPed, x, y, z)
  end
  setCharCoordinatesDontResetAnim(playerPed, x, y, z)
end

function setCharCoordinatesDontResetAnim(char, x, y, z)
  if doesCharExist(char) then
    local ptr = getCharPointer(char)
    setEntityCoordinates(ptr, x, y, z)
  end
end

function setEntityCoordinates(entityPtr, x, y, z)
  if entityPtr ~= 0 then
    local matrixPtr = readMemory(entityPtr + 0x14, 4, false)
    if matrixPtr ~= 0 then
      local posPtr = matrixPtr + 0x30
      writeMemory(posPtr + 0, 4, representFloatAsInt(x), false) -- X
      writeMemory(posPtr + 4, 4, representFloatAsInt(y), false) -- Y
      writeMemory(posPtr + 8, 4, representFloatAsInt(z), false) -- Z
    end
  end
end

function showCursor(toggle)
  if toggle then
    sampSetCursorMode(CMODE_LOCKCAM)
  else
    sampToggleCursor(false)
  end
  cursorEnabled = toggle
end

function airb()
    sh = {}
    while air do wait(0)
        local _, id = sampGetPlayerIdByCharHandle(playerPed) 
        local fX, fY, fZ = getActiveCameraCoordinates()
        local zX, zY, zZ = getActiveCameraPointAt()
        local heading = getHeadingFromVector2d(zX - fX, zY - fY)
        if isCharInAnyCar(PLAYER_PED) then
            car = getCarCharIsUsing(playerPed)
            setCarHeading(car, heading)
            setCarProofs(car, true, true, true, true, true) 
            local _, id = sampGetVehicleIdByCarHandle(car)
            if getDriverOfCar(getCarCharIsUsing(PLAYER_PED)) == -1 then
                pcall(sampForcePassengerSyncSeatId, sh[1], sh[2])
                pcall(sampForceUnoccupiedSyncSeatId, sh[1], sh[2])
            else
                pcall(sampForceVehicleSync, sh[1])
            end
        elseif not isCharInAnyCar(PLAYER_PED) then 
            setCharHeading(PLAYER_PED, heading)
            setCharProofs(PLAYER_PED, true, true, true, true, true)
            pcall(sampForceOnfootSync)
        end
        setCharCoordinates(PLAYER_PED, airBrkCoords[1], airBrkCoords[2], airBrkCoords[3] - 0.79)
        if not sampIsChatInputActive() and not sampIsDialogActive() then 
            if airc1 then
               airc2, airc22, airc222 = getCharCoordinates(PLAYER_PED)
               if airc1 == airc2 and airc11 == airc22 and airc111 == airc222 then
                  speed = 0
               end
            end
            if isKeyDown(VK_SPACE) then
                speed = speed+Config.Settings.Airspeedped/100
                airBrkCoords[3] = airBrkCoords[3] + speed / 2.0
            elseif isKeyDown(VK_LSHIFT) and airBrkCoords[3] > -95.0 then 
                speed = speed+Config.Settings.Airspeedped/100
                airBrkCoords[3] = airBrkCoords[3] - speed / 2.0
            end
            if isKeyDown(VK_W) then
                speed = speed+Config.Settings.Airspeedped/100
                airBrkCoords[1] = airBrkCoords[1] + speed * math.sin(-math.rad(heading))
                airBrkCoords[2] = airBrkCoords[2] + speed * math.cos(-math.rad(heading))
            elseif isKeyDown(VK_S) then 
                speed = speed+Config.Settings.Airspeedped/100
                airBrkCoords[1] = airBrkCoords[1] - speed * math.sin(-math.rad(heading))
                airBrkCoords[2] = airBrkCoords[2] - speed * math.cos(-math.rad(heading))
            end
            if isKeyDown(VK_A) then 
                speed = speed+Config.Settings.Airspeedped/100
                airBrkCoords[1] = airBrkCoords[1] - speed * math.sin(-math.rad(heading - 90))
                airBrkCoords[2] = airBrkCoords[2] - speed * math.cos(-math.rad(heading - 90))
            elseif isKeyDown(VK_D) then
                speed = speed+Config.Settings.Airspeedped/100
                airBrkCoords[1] = airBrkCoords[1] + speed * math.sin(-math.rad(heading - 90))
                airBrkCoords[2] = airBrkCoords[2] + speed * math.cos(-math.rad(heading - 90))
            end
            airc1, airc11, airc111 = getCharCoordinates(PLAYER_PED)
        end
    end
end

function getNearCharToCenter(radius)
    local arr = {}
    local sx, sy = getScreenResolution()
    for _, player in ipairs(getAllChars()) do
        if select(1, sampGetPlayerIdByCharHandle(player)) and isCharOnScreen(player) and player ~= playerPed then
            local plX, plY, plZ = getCharCoordinates(player)
            local cX, cY = convert3DCoordsToScreen(plX, plY, plZ)
            local distBetween2d = getDistanceBetweenCoords2d(sx / 2, sy / 2, cX, cY)
            if distBetween2d <= tonumber(radius and radius or sx) then
                table.insert(arr, {distBetween2d, player})
            end
        end
    end
    if #arr > 0 then
        table.sort(arr, function(a, b) return (a[1] < b[1]) end)
        return arr[1][2]
    end
    return nil
end

function getNearCarToCenter(radius)
    local arr = {}
    local sx, sy = getScreenResolution()
    for _, car in ipairs(getAllVehicles()) do
        if isCarOnScreen(car) and getDriverOfCar(car) ~= playerPed then
            local carX, carY, carZ = getCarCoordinates(car)
            local cX, cY = convert3DCoordsToScreen(carX, carY, carZ)
            local distBetween2d = getDistanceBetweenCoords2d(sx / 2, sy / 2, cX, cY)
            if distBetween2d <= tonumber(radius and radius or sx) then
                table.insert(arr, {distBetween2d, car})
            end
        end
    end
    if #arr > 0 then
        table.sort(arr, function(a, b) return (a[1] < b[1]) end)
        return arr[1][2]
    end
    return nil
end


function getBodyPartCoordinates(id, handle)
  local pedptr = getCharPointer(handle)
  local vec = ffi.new("float[3]")
  getBonePosition(ffi.cast("void*", pedptr), vec, id, true)
  return vec[0], vec[1], vec[2]
end

function join_argb(a, r, g, b)
  local argb = b  -- b
  argb = bit.bor(argb, bit.lshift(g, 8))  -- g
  argb = bit.bor(argb, bit.lshift(r, 16)) -- r
  argb = bit.bor(argb, bit.lshift(a, 24)) -- a
  return argb
end

function explode_argb(argb)
  local a = bit.band(bit.rshift(argb, 24), 0xFF)
  local r = bit.band(bit.rshift(argb, 16), 0xFF)
  local g = bit.band(bit.rshift(argb, 8), 0xFF)
  local b = bit.band(argb, 0xFF)
  return a, r, g, b
end


sampRegisterChatCommand('mycord', function()
    if checkpoint then
        removeBlip(checkpoint)
    end
    MYX, MYY, MYZ = getCharCoordinates(playerPed)
    sampAddChatMessage(MYX..' '..MYY..' '..MYZ, -1)
    checkpoint = addBlipForCoord(MYX, MYY, MYZ)
end)
sampRegisterChatCommand('cord', function(arg)
    if checkpoint then
        removeBlip(checkpoint)
    end
    local par = sampGetCharHandleBySampPlayerId(arg)
    MYX, MYY, MYZ = getCharCoordinates(par)
    sampAddChatMessage(MYX..' '..MYY..' '..MYZ, -1)
    checkpoint = addBlipForCoord(MYX, MYY, MYZ)
end)
sampRegisterChatCommand('mycord1', function()
    removeBlip(checkpoint)
end)

sampRegisterChatCommand('amodel', function(arg)
    arg1, arg2 = arg:match('(.+) (.+)')
    local MYX, MYY, MYZ = getCharCoordinates(playerPed)
    if arg1 == '1' then
        setCharCoordinates(PLAYER_PED, 1113.6, 1333.7, 10.8) 
    elseif arg1 == '2' then
        setCharCoordinates(PLAYER_PED, 1115.8, 1321.8, 10.8) 
    elseif arg1 == '3' then 
        setCharCoordinates(PLAYER_PED, 1114.5, 1311.6, 10.8) 
    elseif arg1 == '4' then
        setCharCoordinates(PLAYER_PED, 1114.5, 1311.6, 10.8) 
    elseif arg1 == '5' then
        setCharCoordinates(PLAYER_PED, 1114.2, 1296.8, 10.8) 
    elseif arg1 == '6' then
        setCharCoordinates(PLAYER_PED, 1113.0, 1282.1, 10.8) 
    elseif arg1 == '7' then
        setCharCoordinates(PLAYER_PED, 1111.1, 1267.1, 10.8)
    end
    lua_thread.create(function()          
        wait(1000)
        sampSendChat('/model '..arg2)
        wait(2000)
        sampSendChat('/ic')
        wait(1000)
        setCharCoordinates(PLAYER_PED, MYX, MYY, MYZ)
    end)
end)

function rainbow(speed, alpha, offset) -- by rraggerr
    local clock = os.clock() + offset
    local r = math.floor(math.sin(clock * speed) * 127 + 128)
    local g = math.floor(math.sin(clock * speed + 2) * 127 + 128)
    local b = math.floor(math.sin(clock * speed + 4) * 127 + 128)
    return r,g,b,alpha
end

function rainbow_line(distance, size) -- by Fomikus
    local op = imgui.GetCursorPos()
    local p = imgui.GetCursorScreenPos()
    for i = 0, distance do
    r, g, b, a = rainbow(1, 255, i / -50)
    imgui.GetWindowDrawList():AddRectFilled(imgui.ImVec2(p.x + i, p.y), imgui.ImVec2(p.x + i + 1, p.y + size), join_argb(a, r, g, b))
    end
    imgui.SetCursorPos(imgui.ImVec2(op.x, op.y + size + imgui.GetStyle().ItemSpacing.y))
end

function static_rainbow_line(distance, size) -- by Fomikus
    local op = imgui.GetCursorPos()
    local p = imgui.GetCursorScreenPos()
    for i = 0, distance do
    r, g, b, a = rainbow_v2(1, 255, i / -50)
    imgui.GetWindowDrawList():AddRectFilled(imgui.ImVec2(p.x + i, p.y), imgui.ImVec2(p.x + i + 1, p.y + size), join_argb(a, r, g, b))
    end
    imgui.SetCursorPos(imgui.ImVec2(op.x, op.y + size + imgui.GetStyle().ItemSpacing.y))
end

function rainbow_v2(speed, alpha, offset) -- by rraggerr
    local r = math.floor(math.sin(offset * speed) * 127 + 128)
    local g = math.floor(math.sin(offset * speed + 2) * 127 + 128)
    local b = math.floor(math.sin(offset * speed + 4) * 127 + 128)
    return r,g,b,alpha
end

function imgui.TextColoredRGB(text)
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4

    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end

    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImColor(r, g, b, a):GetVec4()
    end

    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else imgui.Text(u8(w)) end
        end
    end

    render_text(text)
end

function themes1(idthem)
    -- dark v0.1
 
    imgui.SwitchContext()
    style = imgui.GetStyle()
    colors = style.Colors
    clr = imgui.Col
    ImVec4 = imgui.ImVec4
    ImVec2 = imgui.ImVec2

    style.WindowRounding = 6.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 4.0
    style.ItemSpacing = imgui.ImVec2(10.0, 10.0)
    style.ItemInnerSpacing = ImVec2(8, 6)
    style.IndentSpacing = 25.0
    style.ScrollbarSize = 13.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0
    if idthem == 1 then
colors[clr.Button] = ImVec4(0.18, 0.00, 0.34, 1.00);  -- Пурпурный цвет кнопок
colors[clr.ButtonHovered] = ImVec4(0.25, 0.00, 0.50, 1.00);  -- Ярче пурпурный для наведения
colors[clr.ButtonActive] = colors[clr.ButtonHovered];  -- Активная кнопка
colors[clr.CheckMark] = ImVec4(0.50, 0.00, 0.80, 1.00);  -- Галочки с пурпурным оттенком, выделяющимся на фоне
colors[clr.HeaderHovered] = colors[clr.ButtonHovered];  -- Наведение на заголовок
colors[clr.HeaderActive] = colors[clr.ButtonActive];  -- Активный заголовок
colors[clr.Header] = colors[clr.Button];  -- Заголовок
colors[clr.Text] = ImVec4(0.90, 0.90, 0.90, 1.00);  -- Светлый текст для контраста
colors[clr.TextDisabled] = ImVec4(0.50, 0.50, 0.50, 1.00);  -- Тусклый текст
colors[clr.TextSelectedBg] = ImVec4(0.30, 0.00, 0.20, 1.00);  -- Тёмный фон для выделенного текста
colors[clr.TitleBgActive] = ImVec4(0.00, 0.00, 0.00, 0.96);  -- Чёрный фон для активных окон
colors[clr.TitleBg] = colors[clr.TitleBgActive];  -- То же для неактивных
colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.51);  -- Чёрный с прозрачностью для свернутых окон
colors[clr.MenuBarBg] = ImVec4(0.10, 0.00, 0.20, 1.00);  -- Пурпурный фон для меню
colors[clr.WindowBg] = colors[clr.TitleBgActive];  -- Окно на чёрном фоне
colors[clr.ChildWindowBg] = ImVec4(0.00, 0.00, 0.00, 0.00);  -- Прозрачный фон для дочерних окон
colors[clr.PopupBg] = ImVec4(0.00, 0.00, 0.00, 1.00);  -- Чёрный фон для всплывающих окон
colors[clr.Border] = ImVec4(0.60, 0.00, 0.60, 0.50);  -- Пурпурные границы
colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00);  -- Отсутствие тени для границ
colors[clr.Separator] = colors[clr.Border];  -- Тот же цвет для разделителей
colors[clr.SeparatorHovered] = colors[clr.Border];
colors[clr.SeparatorActive] = colors[clr.Border];
colors[clr.SliderGrab] = ImVec4(0.60, 0.00, 0.60, 1.00);  -- Пурпурный для ползунков
colors[clr.SliderGrabActive] = ImVec4(0.75, 0.00, 0.75, 1.00);  -- Ярче пурпурный для активных ползунков
colors[clr.ScrollbarBg] = ImVec4(0.02, 0.02, 0.02, 0.39);  -- Тёмный фон для полос прокрутки
colors[clr.ScrollbarGrab] = colors[clr.Button];  -- Кнопка полосы прокрутки
colors[clr.ScrollbarGrabHovered] = colors[clr.ButtonHovered];  -- Наведение на кнопку полосы прокрутки
colors[clr.ScrollbarGrabActive] = colors[clr.ButtonActive];  -- Активная кнопка полосы прокрутки
colors[clr.FrameBg] = colors[clr.Button];  -- Цвет фона для фреймов
colors[clr.FrameBgHovered] = colors[clr.ButtonHovered];  -- Наведение на фрейм
colors[clr.FrameBgActive] = colors[clr.ButtonActive];  -- Активный фрейм
colors[clr.ComboBg] = ImVec4(0.35, 0.00, 0.45, 1.00);  -- Пурпурный фон для комбобоксов
colors[clr.ResizeGrip] = colors[clr.Button];  -- Цвет захвата для ресайза
colors[clr.ResizeGripHovered] = colors[clr.ButtonActive];  -- Наведение на захват ресайза
colors[clr.ResizeGripActive] = colors[clr.ButtonActive];  -- Активный захват ресайза
colors[clr.CloseButton] = ImVec4(0.50, 0.00, 0.50, 0.16);  -- Пурпурная кнопка закрытия
colors[clr.CloseButtonHovered] = ImVec4(0.75, 0.00, 0.75, 1.00);  -- Ярче для наведения
colors[clr.CloseButtonActive] = colors[clr.CloseButtonHovered];  -- Активная кнопка закрытия
colors[clr.PlotLines] = ImVec4(0.70, 0.00, 0.70, 1.00);  -- Пурпурные линии графиков
colors[clr.PlotLinesHovered] = ImVec4(1.00, 0.35, 0.50, 1.00);  -- Яркие линии для наведения
colors[clr.PlotHistogram] = ImVec4(0.90, 0.50, 0.90, 1.00);  -- Пурпурные гистограммы
colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 1.00, 1.00);  -- Ярче для наведения
colors[clr.ModalWindowDarkening] = ImVec4(0.20, 0.00, 0.20, 0.73);  -- Пурпурная тень для модальных окон
elseif idthem == 2 then
        colors[clr.Button] = ImVec4(0.07, 0.07, 0.07, 1.00)
        colors[clr.ButtonHovered] = ImVec4(0.11, 0.11, 0.11, 1.00)
        colors[clr.ButtonActive] = colors[clr.ButtonHovered]

        
        colors[clr.CheckMark] = ImVec4(0.50, 0.10, 0.00, 1.00)
    
        colors[clr.HeaderHovered] = colors[clr.ButtonHovered]
        colors[clr.HeaderActive] = colors[clr.ButtonActive]
        colors[clr.Header] = colors[clr.Button] 
    
       
        colors[clr.Text] = ImVec4(0.80, 0.80, 0.80, 1.00)
        colors[clr.TextDisabled] = ImVec4(0.40, 0.40, 0.40, 1.00)
        colors[clr.TextSelectedBg] = ImVec4(0.20, 0.07, 0.00, 1.00)
    
      
        colors[clr.TitleBgActive] = ImVec4(0.00, 0.00, 0.00, 0.96) 
        colors[clr.TitleBg] = colors[clr.TitleBgActive]
        colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.51)
    
     
        colors[clr.MenuBarBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
    
     
        colors[clr.WindowBg] = colors[clr.TitleBgActive]
        colors[clr.ChildWindowBg] = ImVec4(0.00, 0.00, 0.00, 0.00)
        colors[clr.PopupBg] = ImVec4(0.00, 0.00, 0.00, 1.00)
    
    

        colors[clr.Border] = ImVec4(0.43, 0.43, 0.50, 0.50)
        colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
    
    
        colors[clr.Separator] = colors[clr.Border]
        colors[clr.SeparatorHovered] = colors[clr.Border]
        colors[clr.SeparatorActive] = colors[clr.Border]


    

        colors[clr.SliderGrab] = ImVec4(0.28, 0.56, 1.00, 1.00)
        colors[clr.SliderGrabActive] = ImVec4(0.37, 0.61, 1.00, 1.00)

    

        colors[clr.ScrollbarBg] = ImVec4(0.02, 0.02, 0.02, 0.39)
        colors[clr.ScrollbarGrab] = colors[clr.Button]
        colors[clr.ScrollbarGrabHovered] = colors[clr.ButtonHovered]
        colors[clr.ScrollbarGrabActive] = colors[clr.ButtonActive]

        colors[clr.FrameBg] = colors[clr.Button]
        colors[clr.FrameBgHovered] = colors[clr.ButtonHovered]
        colors[clr.FrameBgActive] = colors[clr.ButtonActive]

        colors[clr.ComboBg] = ImVec4(0.35, 0.35, 0.35, 1.00)

    

        colors[clr.ResizeGrip] = colors[clr.Button]
        colors[clr.ResizeGripHovered] = colors[clr.ButtonActive]
        colors[clr.ResizeGripActive] = colors[clr.ButtonActive]

        colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
        colors[clr.CloseButtonHovered] = imgui.ImVec4(0.50, 0.25, 0.00, 1.00)
        colors[clr.CloseButtonActive] = colors[clr.CloseButtonHovered]

        colors[clr.PlotLines] = ImVec4(0.61, 0.61, 0.61, 1.00)
        colors[clr.PlotLinesHovered] = ImVec4(1.00, 0.43, 0.35, 1.00)

        colors[clr.PlotHistogram] = ImVec4(0.90, 0.70, 0.00, 1.00)
        colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)

    

        colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)

   elseif idthem == 3 then
    colors[clr.Text]                   = ImVec4(0.95, 0.96, 0.98, 1.00);
    colors[clr.TextDisabled]           = ImVec4(0.29, 0.29, 0.29, 1.00);
    colors[clr.WindowBg]               = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.ChildWindowBg]          = ImVec4(0.00, 0.00, 0.00, 0.00);
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94);
    colors[clr.Border]                 = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.BorderShadow]           = ImVec4(1.00, 1.00, 1.00, 0.10);
    colors[clr.FrameBg]                = ImVec4(0.22, 0.22, 0.22, 1.00);
    colors[clr.FrameBgHovered]         = ImVec4(0.18, 0.18, 0.18, 1.00);
    colors[clr.FrameBgActive]          = ImVec4(0.09, 0.12, 0.14, 1.00);
    colors[clr.TitleBg]                = ImVec4(0.14, 0.14, 0.14, 0.81);
    colors[clr.TitleBgActive]          = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51);
    colors[clr.MenuBarBg]              = ImVec4(0.20, 0.20, 0.20, 1.00);
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.39);
    colors[clr.ScrollbarGrab]          = ImVec4(0.36, 0.36, 0.36, 1.00);
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.18, 0.22, 0.25, 1.00);
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.ComboBg]                = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.CheckMark]              = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.SliderGrab]             = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.SliderGrabActive]       = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.Button]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.ButtonHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.ButtonActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.Header]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.HeaderHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.HeaderActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.ResizeGrip]             = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.ResizeGripHovered]      = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.ResizeGripActive]       = ImVec4(1.00, 0.19, 0.19, 1.00);
    colors[clr.CloseButton]            = ImVec4(0.40, 0.39, 0.38, 0.16);
    colors[clr.CloseButtonHovered]     = ImVec4(0.40, 0.39, 0.38, 0.39);
    colors[clr.CloseButtonActive]      = ImVec4(0.40, 0.39, 0.38, 1.00);
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00);
    colors[clr.PlotHistogram]          = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.18, 0.18, 1.00);
    colors[clr.TextSelectedBg]         = ImVec4(1.00, 0.32, 0.32, 1.00);
    colors[clr.ModalWindowDarkening]   = ImVec4(0.26, 0.26, 0.26, 0.60);
   elseif idthem == 4 then
    colors[clr.FrameBg]                = ImVec4(0.46, 0.11, 0.29, 1.00)
    colors[clr.FrameBgHovered]         = ImVec4(0.69, 0.16, 0.43, 1.00)
    colors[clr.FrameBgActive]          = ImVec4(0.58, 0.10, 0.35, 1.00)
    colors[clr.TitleBg]                = ImVec4(0.00, 0.00, 0.00, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.61, 0.16, 0.39, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.CheckMark]              = ImVec4(0.94, 0.30, 0.63, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.85, 0.11, 0.49, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.89, 0.24, 0.58, 1.00)
    colors[clr.Button]                 = ImVec4(0.46, 0.11, 0.29, 1.00)
    colors[clr.ButtonHovered]          = ImVec4(0.69, 0.17, 0.43, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.59, 0.10, 0.35, 1.00)
    colors[clr.Header]                 = ImVec4(0.46, 0.11, 0.29, 1.00)
    colors[clr.HeaderHovered]          = ImVec4(0.69, 0.16, 0.43, 1.00)
    colors[clr.HeaderActive]           = ImVec4(0.58, 0.10, 0.35, 1.00)
    colors[clr.Separator]              = ImVec4(0.69, 0.16, 0.43, 1.00)
    colors[clr.SeparatorHovered]       = ImVec4(0.58, 0.10, 0.35, 1.00)
    colors[clr.SeparatorActive]        = ImVec4(0.58, 0.10, 0.35, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.46, 0.11, 0.29, 0.70)
    colors[clr.ResizeGripHovered]      = ImVec4(0.69, 0.16, 0.43, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.70, 0.13, 0.42, 1.00)
    colors[clr.TextSelectedBg]         = ImVec4(1.00, 0.78, 0.90, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.60, 0.19, 0.40, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.Border]                 = ImVec4(0.49, 0.14, 0.31, 1.00)
    colors[clr.BorderShadow]           = ImVec4(0.49, 0.14, 0.31, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.15, 0.15, 0.15, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
   elseif idthem == 5 then
    colors[clr.Text]                 = ImVec4(0.86, 0.93, 0.89, 0.78)
            colors[clr.TextDisabled]         = ImVec4(0.36, 0.42, 0.47, 1.00)
            colors[clr.WindowBg]             = ImVec4(0.11, 0.15, 0.17, 1.00)
            colors[clr.ChildWindowBg]        = ImVec4(0.00, 0.00, 0.00, 0.00)
            colors[clr.PopupBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)
            colors[clr.Border]               = ImVec4(0.43, 0.43, 0.50, 0.50)
            colors[clr.BorderShadow]         = ImVec4(0.00, 0.00, 0.00, 0.00)
            colors[clr.FrameBg]              = ImVec4(0.20, 0.25, 0.29, 1.00)
            colors[clr.FrameBgHovered]       = ImVec4(0.19, 0.12, 0.28, 1.00)
            colors[clr.FrameBgActive]        = ImVec4(0.09, 0.12, 0.14, 1.00)
            colors[clr.TitleBg]              = ImVec4(0.04, 0.04, 0.04, 1.00)
            colors[clr.TitleBgActive]        = ImVec4(0.41, 0.19, 0.63, 1.00)
            colors[clr.TitleBgCollapsed]     = ImVec4(0.00, 0.00, 0.00, 0.51)
            colors[clr.MenuBarBg]            = ImVec4(0.15, 0.18, 0.22, 1.00)
            colors[clr.ScrollbarBg]          = ImVec4(0.02, 0.02, 0.02, 0.39)
            colors[clr.ScrollbarGrab]        = ImVec4(0.20, 0.25, 0.29, 1.00)
            colors[clr.ScrollbarGrabHovered] = ImVec4(0.18, 0.22, 0.25, 1.00)
            colors[clr.ScrollbarGrabActive]  = ImVec4(0.20, 0.09, 0.31, 1.00)
            colors[clr.ComboBg]              = ImVec4(0.20, 0.25, 0.29, 1.00)
            colors[clr.CheckMark]            = ImVec4(0.59, 0.28, 1.00, 1.00)
            colors[clr.SliderGrab]           = ImVec4(0.41, 0.19, 0.63, 1.00)
            colors[clr.SliderGrabActive]     = ImVec4(0.41, 0.19, 0.63, 1.00)
            colors[clr.Button]               = ImVec4(0.41, 0.19, 0.63, 0.44)
            colors[clr.ButtonHovered]        = ImVec4(0.41, 0.19, 0.63, 0.86)
            colors[clr.ButtonActive]         = ImVec4(0.64, 0.33, 0.94, 1.00)
            colors[clr.Header]               = ImVec4(0.20, 0.25, 0.29, 0.55)
            colors[clr.HeaderHovered]        = ImVec4(0.51, 0.26, 0.98, 0.80)
            colors[clr.HeaderActive]         = ImVec4(0.53, 0.26, 0.98, 1.00)
            colors[clr.Separator]            = ImVec4(0.50, 0.50, 0.50, 1.00)
            colors[clr.SeparatorHovered]     = ImVec4(0.60, 0.60, 0.70, 1.00)
            colors[clr.SeparatorActive]      = ImVec4(0.70, 0.70, 0.90, 1.00)
            colors[clr.ResizeGrip]           = ImVec4(0.59, 0.26, 0.98, 0.25)
            colors[clr.ResizeGripHovered]    = ImVec4(0.61, 0.26, 0.98, 0.67)
            colors[clr.ResizeGripActive]     = ImVec4(0.06, 0.05, 0.07, 1.00)
            colors[clr.CloseButton]          = ImVec4(0.40, 0.39, 0.38, 0.16)
            colors[clr.CloseButtonHovered]   = ImVec4(0.40, 0.39, 0.38, 0.39)
            colors[clr.CloseButtonActive]    = ImVec4(0.40, 0.39, 0.38, 1.00)
            colors[clr.PlotLines]            = ImVec4(0.61, 0.61, 0.61, 1.00)
            colors[clr.PlotLinesHovered]     = ImVec4(1.00, 0.43, 0.35, 1.00)
            colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)
            colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
            colors[clr.TextSelectedBg]       = ImVec4(0.25, 1.00, 0.00, 0.43)
            colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
    elseif idthem == 6 then
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.28, 0.30, 0.35, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.16, 0.18, 0.22, 1.00)
    colors[clr.ChildWindowBg]          = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.05, 0.05, 0.10, 0.90)
    colors[clr.Border]                 = ImVec4(0.19, 0.22, 0.26, 1.00)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg]                = ImVec4(0.19, 0.22, 0.26, 1.00)
    colors[clr.FrameBgHovered]         = ImVec4(0.22, 0.25, 0.30, 1.00)
    colors[clr.FrameBgActive]          = ImVec4(0.22, 0.25, 0.29, 1.00)
    colors[clr.TitleBg]                = ImVec4(0.19, 0.22, 0.26, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.19, 0.22, 0.26, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.19, 0.22, 0.26, 0.59)
    colors[clr.MenuBarBg]              = ImVec4(0.19, 0.22, 0.26, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.20, 0.25, 0.30, 0.60)
    colors[clr.ScrollbarGrab]          = ImVec4(0.41, 0.55, 0.78, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.49, 0.63, 0.86, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.49, 0.63, 0.86, 1.00)
    colors[clr.ComboBg]                = ImVec4(0.20, 0.20, 0.20, 0.99)
    colors[clr.CheckMark]              = ImVec4(0.90, 0.90, 0.90, 0.50)
    colors[clr.SliderGrab]             = ImVec4(1.00, 1.00, 1.00, 0.30)
    colors[clr.SliderGrabActive]       = ImVec4(0.80, 0.50, 0.50, 1.00)
    colors[clr.Button]                 = ImVec4(0.41, 0.55, 0.78, 1.00)
    colors[clr.ButtonHovered]          = ImVec4(0.49, 0.62, 0.85, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.49, 0.62, 0.85, 1.00)
    colors[clr.Header]                 = ImVec4(0.19, 0.22, 0.26, 1.00)
    colors[clr.HeaderHovered]          = ImVec4(0.22, 0.24, 0.28, 1.00)
    colors[clr.HeaderActive]           = ImVec4(0.22, 0.24, 0.28, 1.00)
    colors[clr.Separator]              = ImVec4(0.41, 0.55, 0.78, 1.00)
    colors[clr.SeparatorHovered]       = ImVec4(0.41, 0.55, 0.78, 1.00)
    colors[clr.SeparatorActive]        = ImVec4(0.41, 0.55, 0.78, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.41, 0.55, 0.78, 1.00)
    colors[clr.ResizeGripHovered]      = ImVec4(0.49, 0.61, 0.83, 1.00)
    colors[clr.ResizeGripActive]       = ImVec4(0.49, 0.62, 0.83, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.55, 0.78, 1.00)
    colors[clr.CloseButtonHovered]     = ImVec4(0.50, 0.63, 0.84, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.41, 0.55, 0.78, 1.00)
    colors[clr.PlotLines]              = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.TextSelectedBg]         = ImVec4(0.41, 0.55, 0.78, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.16, 0.18, 0.22, 0.76)
    end
end

sampRegisterChatCommand('j0', function(arg) 
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/jail ' .. arg .. ' 0 ')
    end
end)

sampRegisterChatCommand('j1', function(arg) 
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/jail ' .. arg .. ' 1 ')
    end
end)

sampRegisterChatCommand('j2', function(arg) 
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/jail ' .. arg .. ' 2 ')
    end
end)

sampRegisterChatCommand('j3', function(arg) 
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/jail ' .. arg .. ' 3 ')
    end
end)

sampRegisterChatCommand('j4', function(arg) 
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/jail ' .. arg .. ' 4 ')
    end
end)

sampRegisterChatCommand('j5', function(arg) 
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/jail ' .. arg .. ' 5 ')
    end
end)

sampRegisterChatCommand('j6', function(arg) 
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/jail ' .. arg .. ' 6 ')
    end
end)

sampRegisterChatCommand('j7', function(arg) 
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/jail ' .. arg .. ' 7 ')
    end
end)

sampRegisterChatCommand('j8', function(arg) 
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/jail ' .. arg .. ' 8 ')
    end
end)

sampRegisterChatCommand('j9', function(arg) 
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/jail ' .. arg .. ' 9 ')
    end
end)

sampRegisterChatCommand('j10', function(arg) 
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/jail ' .. arg .. ' 10 ')
    end
end)

sampRegisterChatCommand('avia', function(arg) 
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/jail ' .. arg .. ' 11 ')
    end
end)

sampRegisterChatCommand('j12', function(arg) 
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/jail ' .. arg .. ' 12 ')
    end
end)

sampRegisterChatCommand('j13', function(arg) 
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/jail ' .. arg .. ' 13 ')
    end
end)

sampRegisterChatCommand('j14', function(arg) 
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/jail ' .. arg .. ' 14 ')
    end
end)

sampRegisterChatCommand('j15', function(arg) 
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/jail ' .. arg .. ' 15 ')
    end
end)

sampRegisterChatCommand('j16', function(arg) 
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/jail ' .. arg .. ' 16 ')
    end
end)

sampRegisterChatCommand('j17', function(arg) 
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/jail ' .. arg .. ' 17 ')
    end
end)

sampRegisterChatCommand('adm', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' r osk adm')
    end
end)

sampRegisterChatCommand('rod', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' r osk rod')
    end
end)

sampRegisterChatCommand('serv', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' r osk project')
    end
end)

sampRegisterChatCommand('psj', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' hr psj')
    end
end)

sampRegisterChatCommand('rcdm', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' r коллективный дм')
    end
end)

sampRegisterChatCommand('hrcdm', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' hr коллективный дм')
    end
end)

sampRegisterChatCommand('rcfg', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' r коллективный фг')
    end
end)

sampRegisterChatCommand('hrcfg', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' hr коллективный фг')
    end
end)

sampRegisterChatCommand('rdm', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' r dm')
    end
end)

sampRegisterChatCommand('hrdm', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' hr dm')
    end
end)

sampRegisterChatCommand('vadm', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/warn ' .. arg .. ' Выдача себя за админа')
    end
end)

sampRegisterChatCommand('fg', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' r fg')
    end
end)

sampRegisterChatCommand('add', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' hr ad')
    end
end)

sampRegisterChatCommand('cdm', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' r Открытое заявление о намереньи дмить')
    end
end)

sampRegisterChatCommand('nrpcop', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/rpw ' .. arg .. ' 0')
    end
end)

sampRegisterChatCommand('nrpefir', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/rpw ' .. arg .. ' 3')
    end
end)

sampRegisterChatCommand('dmrpw', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/rpw ' .. arg .. ' 2')
    end
end)

sampRegisterChatCommand('virti', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' hr Продажа игровой валюты')
    end
end)

sampRegisterChatCommand('nrpad', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/warn ' .. arg .. ' nrpad')
    end
end)

sampRegisterChatCommand('cheat', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/warn ' .. arg .. ' Читы(признание)')
    end
end)

sampRegisterChatCommand('sh', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' c sh')
    end
end)

sampRegisterChatCommand('gm', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' c gm')
    end
end)

sampRegisterChatCommand('air', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' c air')
    end
end)

sampRegisterChatCommand('fly', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' c fly')
    end
end)

sampRegisterChatCommand('tp', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' c tp')
    end
end)

sampRegisterChatCommand('surf', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' c surf')
    end
end)

sampRegisterChatCommand('rvanka', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/aban ' .. arg .. ' hc rvanka')
    end
end)

sampRegisterChatCommand('carshot', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' hc carshot')
    end
end)

sampRegisterChatCommand('carheal', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' c carheal')
    end
end)

sampRegisterChatCommand('jumpcar', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' c jumpcar')
    end
end)

sampRegisterChatCommand('gs', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' c gamespeed')
    end
end)

sampRegisterChatCommand('collision', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' c collision')
    end
end)

sampRegisterChatCommand('antifall', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' c antifall')
    end
end)

sampRegisterChatCommand('flipcar', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' c flipcar')
    end
end)

sampRegisterChatCommand('brakedance', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' c brakedance')
    end
end)

sampRegisterChatCommand('aim', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ban ' .. arg .. ' hc aim (shotinfo)')
    end
end)

sampRegisterChatCommand('aimsmug', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/aban ' .. arg .. ' hc aim/spread (shotinfo) // smug')
    end
end)

sampRegisterChatCommand('aimconv', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/aban ' .. arg .. ' hc aim/spread (shotinfo) // convoy')
    end
end)

sampRegisterChatCommand('aimkb', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/aban ' .. arg .. ' hc aim/spread (shotinfo) // КБ')
    end
end)

sampRegisterChatCommand('sbivsmug', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/warn ' .. arg .. ' sbiv // smug')
    end
end)

sampRegisterChatCommand('sbivconv', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/warn ' .. arg .. ' sbiv // convoy')
    end
end)

sampRegisterChatCommand('sbivkb', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/warn ' .. arg .. ' sbiv // КБ')
    end
end)

sampRegisterChatCommand('dbsmug', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/warn ' .. arg .. ' db // smug')
    end
end)

sampRegisterChatCommand('dbconv', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/warn ' .. arg .. ' db // convoy')
    end
end)

sampRegisterChatCommand('dbkb', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/warn ' .. arg .. ' db // КБ')
    end
end)

sampRegisterChatCommand('afksmug', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/warn ' .. arg .. ' AFK от смерти // smug')
    end
end)

sampRegisterChatCommand('afkconv', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/warn ' .. arg .. ' AFK от смерти // convoy')
    end
end)

sampRegisterChatCommand('afkkb', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/warn ' .. arg .. ' AFK от смерти // КБ')
    end
end)

sampRegisterChatCommand('offsmug', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/warn ' .. arg .. ' OFF от смерти // smug')
    end
end)

sampRegisterChatCommand('offconv', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/warn ' .. arg .. ' OFF от смерти // convoy')
    end
end)

sampRegisterChatCommand('kofftop', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/kick ' .. arg .. ' offtop, next warn')
    end
end)

sampRegisterChatCommand('wofftop', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/warn ' .. arg .. ' offtop')
    end
end)

sampRegisterChatCommand('offkb', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/warn ' .. arg .. ' OFF от смерти // КБ')
    end
end)

sampRegisterChatCommand('predosk', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ames ' .. arg .. ' Прекращайте оскорблять игроков, при повторной жалобе на вас - получите мут.')
    end
end)

sampRegisterChatCommand('predmg', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ames ' .. arg .. ' Прекращайте МГшить, при повторной жалобе на вас - получите мут.')
    end
end)

sampRegisterChatCommand('predcaps', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ames ' .. arg .. ' Прекращайте КАПСить, при повторной жалобе на вас - получите мут.')
    end
end)

sampRegisterChatCommand('predoff', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ames ' .. arg .. ' Прекращайте оффтопить, дальше kick / warn.')
    end
end)

sampRegisterChatCommand('mm', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ames ' .. arg .. ' Мут.')
    end
end)

sampRegisterChatCommand('jj', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ames ' .. arg .. ' Джейл.')
    end
end)

sampRegisterChatCommand('bb', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ames ' .. arg .. ' Бан.')
    end
end)

sampRegisterChatCommand('ww', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ames ' .. arg .. ' Варн.')
    end
end)

sampRegisterChatCommand('kk', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ames ' .. arg .. ' Кик.')
    end
end)

sampRegisterChatCommand('pred', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ames ' .. arg .. ' Предупредил игрока, при повторном нарушении с его стороны - выдам наказание.')
    end
end)

sampRegisterChatCommand('nopred', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ames ' .. arg .. ' Не вижу нарушений от игрока.')
    end
end)

sampRegisterChatCommand('rules', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ames ' .. arg .. ' Нарушение правил в ваш адрес, не даёт вам права нарушать правила в ответ.')
        sampSendChat('/ames ' .. arg .. ' Если нарушаются правила по отношению к вам - пишите /report ID - нарушение.')
        sampSendChat('/ames ' .. arg .. ' В случае, если администрации нет на сервере, записывайте моменты с нарушениями и оставляйте жалобу на форуме.')
    end
end)

sampRegisterChatCommand('posk', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ames ' .. arg .. ' IC оскорбления наказываются только в случае злоупотреблений.')
        sampSendChat('/ames ' .. arg .. ' Разовые оскорбления наказываются только в OOC чатах.')
    end
end)

sampRegisterChatCommand('prod', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ames ' .. arg .. ' IC оскорбление родных наказываются от 3-х осков в течение 10 минут. ')
        sampSendChat('/ames ' .. arg .. ' При оскорблениях в сочетании с МГ, достаточно одного оска.')
    end
end)

sampRegisterChatCommand('gl', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/amesx ' .. arg .. ' Приятной игры :)')
    end
end)

sampRegisterChatCommand('spec', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ames ' .. arg .. ' Слежу.')
    end
end)

sampRegisterChatCommand('pmadm', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ames ' .. arg .. ' Пишите в /pm админу, который наказал вас.')
    end
end)

sampRegisterChatCommand('ask', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ames ' .. arg .. ' /ask для вопросов по игровому моду.')
    end
end)

sampRegisterChatCommand('nick', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ames ' .. arg .. ' Ожидайте смены без оффтопа в репорт.')
    end
end)

sampRegisterChatCommand('idn', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ames ' .. arg .. ' ID - нарушение.')
    end
end)

sampRegisterChatCommand('off', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ames ' .. arg .. ' Игрок offline.')
    end
end)

sampRegisterChatCommand('predsmug', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ames ' .. arg .. ' Покиньте зону груза!')
        sampSendChat('/amest ' .. arg .. ' Покиньте зону груза!')
    end
end)

sampRegisterChatCommand('predconv', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/ames ' .. arg .. ' Покиньте зону конвоя!')
        sampSendChat('/amest ' .. arg .. ' Покиньте зону конвоя!')
    end
end)

sampRegisterChatCommand('proverka', function(arg)
    if not arg or #arg == 0 then
        sampAddChatMessage(tag..'Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
    else
        sampSendChat('/pm ' .. arg .. ' АФК или выход из игры = BAN HR категории.')
        sampSendChat('/getheres ' .. arg .. ' ')
        sampSendChat('/pm ' .. arg .. ' У вас есть РОВНО 5 минут, чтобы написать мне свой Discord и добавить в друзья.')
        sampSendChat('/pm ' .. arg .. ' Если же вы ПРЕВЫШАЕТЕ АФК в 5 минут, ваш аккаунт БЛОКИРУЕТСЯ.')
        sampSendChat('/pm ' .. arg .. ' Если вы ПОКИНИТЕ ИГРУ в течение нашей проверки - ваш аккаунт БЛОКИРУЕТСЯ.')
    end
end)

if isKeyJustPressed(122) then
      sampSendChat('/reent ' .. ID)
    end
    if isKeyJustPressed(123) then
      sampSendChat('/relift ' .. ID)
    end

function makeScreenshot(disable) 
    if Config.Settings.AutoScreen then
        if disable then displayHud(false) sampSetChatDisplayMode(0) end
        require('memory').setuint8(sampGetBase() + 0x119CBC, 1)
        if disable then displayHud(true) sampSetChatDisplayMode(2) end
    end
end

function teleportToRoadNode(param)
    if not param or param:match("^%s*$") then
        sampAddChatMessage('{7172ee}[ROAD]{ffffff} Введите {7172ee}ID{FFFFFF} игрока для успешной активации этой команды.', 0x7172ee)
        return
    end

    local input = param:match("^(%S+)")
    input = input:lower():gsub("^%s*(.-)%s*$", "%1")

    if getActiveInterior() ~= 0 then
        sampAddChatMessage('{7172ee}[ROAD]{ffffff} Нельзя телепортироваться к дорожному узлу в интерьерах.', 0x7172ee)
        return
    end

    local targetId = tonumber(input)
    if not (targetId and sampIsPlayerConnected(targetId)) then
        for i = 0, 1000 do
            if sampIsPlayerConnected(i) then
                local nick = sampGetPlayerNickname(i):lower()
                if nick:find(input, 1, true) then
                    targetId = i
                    break
                end
            end
        end

        if not targetId then
            sampAddChatMessage('{7172ee}[ROAD]{ffffff} Игрок не найден.', 0x7172ee)
            return
        end
    end

    local ped = PLAYER_PED
    local cx, cy, cz = getCharCoordinates(ped)
    local nx, ny, nz = getClosestCarNode(cx, cy, cz)
    if not nx or not ny or not nz then
        sampAddChatMessage('{7172ee}[ROAD]{ffffff} Узел дороги не найден поблизости.', 0x7172ee)
        return
    end

    restoreCameraJumpcut()
    setCameraBehindPlayer()
    freezeX, freezeY, freezeZ = nx, ny, nz + 1.0
    setCharCoordinates(ped, freezeX, freezeY, freezeZ)
    freezeCharPosition(ped, true)

    pendingId = targetId
    gethereTime = getTickCount() + 100
    gethereScheduled = true

    freezeEnd = getTickCount() + 200
    freezeActive = true
end

function onScriptUpdate()
    if gethereScheduled and getTickCount() >= gethereTime then
        sampSendChat("/gethere " .. pendingId)
        gethereScheduled = false
    end

    if freezeActive then
        local ped = PLAYER_PED
        setCharCoordinates(ped, freezeX, freezeY, freezeZ)
        if getTickCount() >= freezeEnd then
            freezeCharPosition(ped, false)
            setCameraBehindPlayer()
            freezeActive = false
        end
    end
end

function q.onSendCommand(command)
  if command == '/reoff' then
    win.second_window_state.v = false
    imgui.Process = win.second_window_state.v
    specstat = false
    fractspec = false
    relvl = false
  end
  if command == '/uoff' then
    win.second_window_state.v = false
    imgui.Process = win.second_window_state.v
    specstat = false
    fractspec = false
    relvl = false
  end
end
local PlayersNickname = {}
function ShowMessage(text, title, style)
    ffi.cdef [[
        int MessageBoxA(
            void* hWnd,
            const char* lpText,
            const char* lpCaption,
            unsigned int uType
        );
    ]]
    local hwnd = ffi.cast('void*', readMemory(0x00C8CF88, 4, false))
    ffi.C.MessageBoxA(hwnd, text,  title, style and (style + 0x50000) or 0x50000)
end
function q.onServerMessage(color, text)
  if proslushka then
        if not text:find('%[Реклама') then
            sendTelegramNotification('[CHAT] '..text)
        end
  end
  if antiautorespch then
    if text:find('Транспортное средство отспавнено.') then return false end
  end
  
if text:find('%(%( PM от .+ %[ID (.+)%]') then
    idpm = text:match('%(%( PM от .+ %[ID (.+)%]')
end


  if Config.Settings.ROFF then
    if text:find('%[Реклама') then return false end
  end
  if fractspec then
      if text:find('Ник {.+}(.+) - (.+) {.+}Ранг {.+}(.+)') then
        arrs.idfractspec[#arrs.idfractspec+1] = text:match('Ник {.+}.+ - (.+) {.+}Ранг {.+}.+')
        if #arrs.idfractspec == 1 then
            specstat = true
            kodspec = 1
            idspec = arrs.idfractspec[1]
            sampSendChat('/re '..arrs.idfractspec[1])
        end
        return false
      end
      if text:find('На данный момент, члены данной фракции офлайн.') then
        fractspec = false
      end
  end
  if bno then
    if text:find('На сервере не найдено игроков по указанным вами параметрам.') then
        bno = false
        sampAddChatMessage(tag..'{ffffff}Игрок под {7172ee}ID '..bnid..' {ffffff}покинул сервер. Автоматический баннейм {7172ee}деактивирован. ', 0x7172ee)
    end
    if text:find('A: .+ отправил '..sampGetPlayerNickname(bnid)..' на смену никнейма с причиной: +.') then
        bno = false
    end
    if text:find('Вы не можете отправить на принудительную смену никнейма игрока, который не завершил регистрацию.') then
        return false
    end
  end
  if not activatesk then
    if text:find('Вы {FF8282}ВЫКЛЮЧИЛИ{ffffff} режим shotinfo.') then
        return false
    end
    if text:find('Вы {FF8282}ВЫКЛЮЧИЛИ{ffffff} режим keyinfo.') then activatesk = true return false end
    if text:find('Вы {33aa33}ВКЛЮЧИЛИ{ffffff} режим shotinfo.') then
        return false
    end
    if text:find('Вы {33aa33}ВКЛЮЧИЛИ{ffffff} режим keyinfo.') then
        return false
    end
  end
  if amess or check2.v then
    if string.find(text, "A:", 1, true) then return false end
    if string.find(text, "Жалоба от", 1, true) then return false end
    if string.find(text, "AM: ", 1, true) then return false end
    if string.find(text, "%[Новая", 1, true) then return false end
    if string.find(text, "AA: ", 1, true) then return false end
    if string.find(text, "RQ:", 1, true) then return false end
    if string.find(text, "А:", 1, true) then return false end
    if string.find(text, "AA:", 1, true) then return false end
    if string.find(text, "%[Зарег", 1, true) then return false end
    if string.find(text, "%[IP", 1, true) then return false end
    if string.find(text, "A offline:", 1, true) then return false end
  end

  if Config.Settings.offaames then
    if text:find('AA:') then return false end
  end
  if achat or check1.v then
    if string.find(text, "[A] ", 1, true) then return false end
  end

  if Config.Settings.ipfind then
      if text:find('%[ID.+%] %[IP:.+%]') then
        for i, val in pairs(Config.arr_ip) do
            if text:find(val) then
                text = '{FF0000}[WARNING] {7f7f7f}Подозрительная подсеть - '..text
                lkdfgj = true
            end
        end
        if not lkdfgj then
            return false
        else
            lkdfgj = false
        end
      end
  end

  if win.descwind.v then
    if text:find('Для этого персонажа не установлено описания.') or text:find('Указанный вами игрок является ботом.') or text:find('Указанный вами игрок не залогинен.') or text:find('На сервере не найдено игроков по указанным вами параметрам.') then 
        if nextd then
            lua_thread.create(function()
                wait(300)
            end)
            sampSendChat('/gd '..idd+1)
            idd = idd+1
            if idd > sampGetMaxPlayerId(false) then
                idd = 0
            end
        end
        if prewd then
            lua_thread.create(function()
                wait(300)
            end)
            sampSendChat('/gd '..idd-1)
            if idd < 0 then
                idd = sampGetMaxPlayerId(false)
            end
            idd = idd-1
        end
    end
  end
if Config.Settings.AutoReactvar then
  if text:find('A: На ЖД станцию в лесу прибыл поезд с грузом контрабанды.') then
    sampSendChat('/u traindriver_5')
  end
  if text:find('A: В аэропорт SF прибыла андромада с грузом контрабанды.') then
    sampSendChat('/u andromadapilot')
  end
  if text:find('A: Началась доставка военного конвоя в RC.') then
    sampSendChat('/uconv lv ')
  end
  if text:find('A: Началась доставка военного конвоя в AF.') then
    sampSendChat('/uconv sf ')
  end
  if text:find('A: Началась доставка военного конвоя в US.') then
    sampSendChat('/uconv ls ')
  end
end
if text:find('Слетевшие дома: #%d+') then
  houseNumbers = {} -- очистка старых данных

  for number in text:gmatch("#(%d+)") do
    table.insert(houseNumbers, number)
  end

  if #houseNumbers > 0 then
    if Config.Settings.AutoReactslet then
      lua_thread.create(function()
        wait(500)
        sampSendChat('/house ' .. houseNumbers[1])
      end)
    end

    sampAddChatMessage('{FF0000}[FLUSHINFO] {ffffff}Обнаружено слетевших домов: {7172ee}' .. table.concat(houseNumbers, ', ') .. '{ffffff}.', 0x7172ee)

    for i = 1, #houseNumbers - 1 do
      local command = '/slet' .. i
      sampAddChatMessage('{FF0000}[FLUSHINFO] {ffffff}Для телепорта к дому {7172ee}#' .. houseNumbers[i + 1] .. '{ffffff} используйте команду: {7172ee}' .. command, 0x7172ee)
    end

    return false
  end
end

-- /slet на первый дом
sampRegisterChatCommand('slet', function()
  if houseNumbers[1] then
    sampSendChat('/house ' .. houseNumbers[1])
  else
    sampAddChatMessage('{FF0000}[FLUSHINFO] {ffffff}Нет данных для телепорта.', 0x7172ee)
  end
end)

-- /slet1 на второй, /slet2 на третий и т.д.
for i = 2, 10 do
  sampRegisterChatCommand('slet' .. (i - 1), function()
    if houseNumbers[i] then
      sampSendChat('/house ' .. houseNumbers[i])
    else
      sampAddChatMessage('{FF0000}[FLUSHINFO] {ffffff}Нет дома {7172ee}#' .. i .. '{ffffff} для телепорта.', 0x7172ee)
    end
  end)
end

  if text:find('A: '..clientName..' был заморожен администратором .+') then
    sampSendChat('/unfr '..clientName)
  end
  if text:find('Event Admin .+ заморозил вас.') then
    sampSendChat('/unfr '..clientName)
  end
  if Config.Settings.OnlyRep then
    if text:find('А: От (.+) для (.+)') then 
        nickadm = text:match('А: От (.+) для (.+)')
        if nickadm ~= clientName then
            return false
        end
    end
  end

  if text:find('Trinity GTA: Пожалуйста, рассмотрите') then
    sampAddChatMessage('{FF0000}[NAMEPANEL] {ffffff}Рассмотрите заявки на смену:{7172ee} /np.', 0x7172ee)
    return false
  end
  if text:find('A: Груз сброшен') then
    sampAddChatMessage('{FF0000}[SMUG] {ffffff}Груз сброшен. Для слежки используйте команду:{7172ee} /usmug.', 0x7172ee)
    return false
  end
 
-- Зелёный цвет для "Проверил"
if text:find("%[Реклама") and text:find("Проверил") then
  text = text:gsub("{%x+}Проверил", "{74ff5c}Проверил")      -- если был цвет
  text = text:gsub("([^}])Проверил", "%1{74ff5c}Проверил")   -- если не было цвета
end

-- Красный цвет для "Исправил"
if text:find("%[Реклама") and text:find("Исправил") then
  text = text:gsub("{%x+}Исправил", "{ff5c5c}Исправил")      -- если был цвет
  text = text:gsub("([^}])Исправил", "%1{ff5c5c}Исправил")   -- если не было цвета
end

if text:find("%[Зарегистрирован аккаунт%] Ник:") then
  local nick, id, ip, place = text:match("%[Зарегистрирован аккаунт%] Ник: ([^ ]+) ID: (%d+) IP: ([^ ]+) %- (.+)")
  if nick and id and ip and place then
    text = "[NOVOREG]: " ..
           "{FF0000}Ник: {FAFAFA}" .. nick ..
           " {FF0000}ID: {FAFAFA}" .. id ..
           " {FF0000}IP: {FAFAFA}" .. ip ..
           " {FF0000}- {FAFAFA}" .. place
  end
end


  if text:find('A: На ЖД станцию в лесу прибыл поезд с грузом контрабанды.') then
    sampAddChatMessage('{FF0000}[КОНТРАБАНДА] {ffffff}Поезд с {7172ee}контрабандой{ffffff} прибыл. Для слежки используйте команду:{7172ee} /ukb.', 0x7172ee)
    return false
  end
  if text:find('A: В аэропорт SF прибыла андромада с грузом контрабанды.') then
    sampAddChatMessage('{FF0000}[КОНТРАБАНДА] {ffffff}Самолёт с {7172ee}контрабандой{ffffff} приземлился. Для слежки используйте команду:{7172ee} /ukb2.', 0x7172ee)
    return false
  end

  if text:find('A: Началась доставка военного конвоя в RC.') then
    sampAddChatMessage('{FF0000}[CONVOY] {ffffff}Начался конвой в {7172ee}RC{ffffff}. Для слежки используйте команду:{7172ee} /uconv lv.', 0x7172ee)
    return false
  end

  if text:find('A: Началась доставка военного конвоя в US.') then
    sampAddChatMessage('{FF0000}[CONVOY] {ffffff}Начался конвой в {7172ee}US{ffffff}. Для слежки используйте команду:{7172ee} /uconv ls.', 0x7172ee)
    return false
  end

  if text:find('A: Началась доставка военного конвоя в AF.') then
    sampAddChatMessage('{FF0000}[CONVOY] {ffffff}Начался конвой в {7172ee}AF{ffffff}. Для слежки используйте команду:{7172ee} /uconv sf.', 0x7172ee)
    return false
  end

  if rangg then
    if text:find('Указанный вами номер ранга выше максимально') then
        rang = rang-1
        sampSendChat('/fractrank '..rang)
    end
  end

  if grangg then
    if text:find('Указанный вами номер ранга выше максимально') then
        grang = grang-1
        sampSendChat('/famrank '..grang)
    end
  end


  if text:find ('Режим наблюдения за {ffffff}(.*){99ff77} ID {ffffff}(%d+){99ff77} выключен.') then
        win.second_window_state.v = false
        imgui.Process = win.second_window_state.v
        specstat = false
  end

  if nextspec then
    if text:find('Режим наблюдения') then
        nextspec = false
        nextspecl = false
        nextspecr = false
        return false
    end
    if text:find('Указанный вами игрок не заспавнен.') or text:find('Этот игрок находится в режиме наблюдения') then
       if nextspecr then
        lasti = lasti + 1
        if tonumber(lasti) == sampGetMaxPlayerId(false) then
                if not sampIsPlayerConnected(0) then
                    for i = lasti, sampGetMaxPlayerId(false) do 
                        if sampIsPlayerConnected(i) and i ~= idspec then
                            sampSendChat('/re '..i)
                            break
                        end
                    end
                else
                    sampSendChat('/re 0')
                    idspec = 0
                end 
        else 
            for i = lasti, sampGetMaxPlayerId(false) do 
                if sampIsPlayerConnected(i) and sampGetPlayerScore(i) > 0 and i ~= lasti then
                    sampSendChat('/re '..i)
                    break
                end
            end
        end
       end
       if nextspecl then
        lasti = lasti - 1
        if lasti == 0 then
                local onMaxId = sampGetMaxPlayerId(false)
                if not sampIsPlayerConnected(onMaxId) or sampGetPlayerScore(onMaxId) == 0 then 
                    for i = sampGetMaxPlayerId(false), 0, -1 do
                        if sampIsPlayerConnected(i) and sampGetPlayerScore(i) > 0 and i ~= lasti then
                            sampSendChat('/re '..i)
                            break
                        end
                    end
                else 
                    sampSendChat('/re '..sampGetMaxPlayerId(false))
                    idspec = sampGetMaxPlayerId(false)
                end
          else 
                for i = lasti, 0, -1 do
                    if sampIsPlayerConnected(i) and sampGetPlayerScore(i) ~= 0 and sampGetPlayerColor(i) ~= 16510045 and i ~= idspec then
                        sampSendChat('/re '..i)
                        lasti = i
                        break
                    end
                end
          end
       end
    end
  end
  if not Config.Settings.admplusfix then
      if text:find('Администратор %{fbec5d%}%d+%{ffffff%} уровня {abcdef}.+%{ffffff%} ID %{abcdef%}(%d+)') then
        local admlvl, admnick, admid, pripisk = text:match('Администратор %{fbec5d%}(%d+)%{ffffff%} уровня %{abcdef%}(.+)%{ffffff%} ID %{abcdef%}(%d+)')
        if tonumber(admlvl) == 1 then
            text = string.gsub(text, '%{ffffff%}', '%{FF8000%}')
            color = 0xFF800000
        elseif tonumber(admlvl) == 2 then 
            text = string.gsub(text, '%{ffffff%}', '%{FF0000%}')
            color = 0xFF000000
        elseif tonumber(admlvl) == 3 then
            text = string.gsub(text, '%{ffffff%}', '%{FF1493%}')
            color = 0xFF149300
        elseif tonumber(admlvl) == 4 then
            text = string.gsub(text, '%{ffffff%}', '%{00FFFF%}')
            color = 0x00FFFF00
        elseif tonumber(admlvl) == 5 then
            text = string.gsub(text, '%{ffffff%}', '%{FFFF00%}')
            color = 0xFFFF0000
        end
        text = string.gsub(text, '%{abcdef%}', '%{ffffff%}')
        text = string.gsub(text, '%{fbec5d%}', '%{ffffff%}') 
      end
  end
  if text:find('Вам ужасно хочется есть. Длительное голодание может привести к смерти.') then
    sampSendChat('/feedme')
  end
  if text:find('Игрок {ffffff}.+{99ff77} покинул сервер, режим наблюдения автоматически выключен.') then
    win.second_window_state.v = false
    imgui.Process = win.second_window_state.v
    specstat = false
  end

    if text:find('С возвращением, вы успешно вошли в свой аккаунт.') then
        if Config.Settings.AutoGodMod then 
            sampSendChat('/agm')
        end
        if Config.Settings.autoflush then
            sampSendChat('/flushinfo')
        end
        if Config.Settings.automegapun then
            sampSendChat('/megapunch')
        end
        if Config.Settings.myFs ~= 0 then
            sampSendChat('/myfs '..Config.Settings.myFs)
        end
        if Config.Settings.ShKey then
            sampSendChat('/keyinfo')
            sampSendChat('/shotinfo')
        end
    end
  if Config.Settings.SpawnOnAdmWorld and not Config.Spawn.Active then 
    if text:find('С возвращением, вы успешно вошли в свой аккаунт.') then
        lua_thread.create(function()
            autoaw = true
            wait(20000)
            autoaw = false
        end)
    end
  end

  if Config.Spawn.Active then
    if text:find('С возвращением, вы успешно вошли в свой аккаунт.') then
        sampSendChat('/gotols')
        lua_thread.create(function()
            autoas = true
            wait(20000)
            autoas = false
        end)
    end
    if autoas then
        if text:find('Вы не можете сейчас телепортироваться.') then
            lua_thread.create(function()
            wait(300)
            sampSendChat('/gotols')
            end)
            return false
        end
    end
  end
  if autoas then
    if text:find('Вы были телепортированы.') then
        autoas = false
        setCharCoordinates(PLAYER_PED, Config.Spawn.SX, Config.Spawn.SY, Config.Spawn.SZ)
        sampAddChatMessage(tag..'Спавн по asetspawn.', -1)
    end
  end

  if Config.Settings.AutoGhost then 
    if text:find('С возвращением, вы успешно вошли в свой аккаунт.') then
        sampSendChat('/ghost')
    end
  end

  if text:find('Указанный вами игрок уже отбывает наказание в админ тюрьме.') then 
    jailed = true
  end

  if text:find('W: .+ по заявлению .+ обвинен.+в: Оскорбление.') then
    nickwosk = text:match('W: (.+) %[.+%] по заявлению .+ обвинен.+в: Оскорбление.')
    sampAddChatMessage(tag..'{b54141}'..nickwosk..' {FFFFFF}возможно провокация ПО. Y - /chlog', -1)
    waittimew = times
    lua_thread.create(function()
        while true do
            wait(0)
            if isKeyJustPressed(VK_Y) then
                if nickwosk then
                    sampSendChat('/chlog '..nickwosk)
                end
            end
            if times == waittimew+5 then
                nickwosk = nil
            end
        end
    end)
  end
  if text:find('W: .+ по заявлению .+ обвинен.+в: Телефонное хулиганство.') then
    nickwosk = text:match('W: (.+) %[.+%] по заявлению .+ обвинен.+в: Телефонное хулиганство.')
    sampAddChatMessage(tag..'{b54141}'..nickwosk..' {FFFFFF}возможно провокация ПО. Y - /chlog', -1)
    waittimew = times
    lua_thread.create(function()
        while true do
            wait(0)
            if isKeyJustPressed(VK_Y) then
                if nickwosk then
                    sampSendChat('/chlog '..nickwosk)
                end
            end
            if times > waittimew+5 then
                nickwosk = nil
            end
        end
    end)
  end

  if text:find('W: (.+) %[ID (.+)%] по заявлению (.+) обвинен в: Умышленное убийство.') then
      qk, wk, ek = text:match('W: (.+) %[ID (.+)%] по заявлению (.+) обвинен в: Умышленное убийство.')
      if qk ~= bloknick then
          if Config.Settings.JailHelp then
            nickk = qk
            idk = wk
            nickj1 = ek
            nickjer = nickj1
            sampAddChatMessage(tag..'{b54141}'..nickk..' ID '..idk..'{FFFFFF} убил {808eff}'..nickj1..'{FFFFFF} ALT+Y/U/I, Y - jail.', -1)
            rabota = false
            autorcre = true
          end
      end
      if Config.Settings.antiw then
        return false
      end
  end
  if text:find('W: (.+) %[ID (.+)%] по заявлению (.+) обвинена в: Умышленное убийство.') then
      qk, wk, ek = text:match('W: (.+) %[ID (.+)%] по заявлению (.+) обвинена в: Умышленное убийство.')
      if qk ~= bloknick then
          if Config.Settings.JailHelp then
            nickk = qk
            idk = wk
            nickj1 = ek
            nickjer = nickj1
            sampAddChatMessage(tag..'{b54141}'..nickk..' ID '..idk..'{FFFFFF} убил {808eff}'..nickj1..'{FFFFFF} ALT+Y/U/I, Y - jail.', -1)
            rabota = false
            autorcre = true
          end
      end
      if Config.Settings.antiw then
        return false
      end
  end
  if text:find('W: (.+) %[ID (.+)%] по заявлению (.+) обвинен.+в: ') then
    if Config.Settings.antiw then
        return false
    end
  end
  if avinfon then
    if text:find('Поблизости нет транспортных средств.') then 
        return false
    end
    if text:find('Последний водитель: {.+}(.+).') then
        sampAddChatMessage(text, -1)
        nickaviaj = text:match('Последний водитель: %{.+%}(%S+).')
        avinfon = false
        aviajail = true
        if aviajail then
            lua_thread.create(function() 
                wait(5000)
                aviajail = false
            end)
        end
    end
  end

  if Config.Settings.Colors then
      if text:find("Жалоба от (.+)") then
        text = '{'..Config.Settings.RepColor..'}'..text
      end

      if text:find("(.): От (.+) для") then
        text = '{'..Config.Settings.RepColor..'}'..text
      end

      if text:find("%[A%] (.+)") then
        text = '{'..Config.Settings.ACHColor..'}'..text
      end
  end


  if Config.Settings.AntiA then
    if text:match('A:') then
        if not text:match(clientName) then
            return false
        end
    end
    if text:find('А:') then
        if not text:match(clientName) then
            return false
        end
    end
    if text:find('AM:') then
        if not text:match(clientName) then
            return false
        end
    end
  end

  if text:find("Жалоба от (.+) %[ID (%d+)%]: (.+)") then
    nickj2, idj2, report = text:match("Жалоба от (.+) %[ID (%d+)%]: (.+)")
    if Config.Settings.WhReport and not isGamePaused() then
        idds = sampCreate3dText('{fa3249}Репорт: '..report, -1, 0, 0, 0.4, 60, true, idj2, -1)
        deleteiddtext()
    end
    onepomet = true 
    if report:find('(%d+)') and nickj2 ~= nickj1 and onepomet then
        idwinrep = report:match('(%d+)')
        idj3 = idj2
        for i, val in pairs(chrep) do
            if report:find(val) and onepomet then
                idchrep = report:match('(%d+)')
                text = text..'{fa3249} CHL '..idchrep
                chrepstat = true
                onepomet = false
                lua_thread.create(function()
                    wait(5000)
                    chrepstat = false
                    idchrep = nil
                end)
            end
        end
        for i, val in pairs(lala) do
            if report:find(val) and onepomet then 
                dhnickj = nickj2
            end
        end
        for i, val in pairs(cheat) do
            if report:find(val) and onepomet then
                idspecrep = report:match('(%d+)')
                text = text..'{fa3249} SPEC '..idspecrep
                specrepstat = true
                onepomet = false
                lua_thread.create(function()
                    wait(5000)
                    specrepstat = false
                    idspecrep = nil
                end)
            end
        end
        for i, val in pairs(descc) do
            if report:find(val) and onepomet then
                iddescrep = report:match('(%d+)')
                text = text..'{fa3249} DESC '..iddescrep
                descrepstat = true
                onepomet = false
                lua_thread.create(function()
                    wait(5000)
                    descrepstat = false
                    iddescrep = nil
                end)
            end
        end
    elseif report:find('(%S+)_(%S+)') and onepomet then
        for i, val in pairs(chrep) do
            if report:find(val) and onepomet then
                local idchnick1, idchnick2 = report:match('(%S+)_(%S+)')
                idchnick = idchnick1..'_'..idchnick2
                if sampGetPlayerIdByNickname(idchnick) then
                    idchrep = sampGetPlayerIdByNickname(idchnick)
                    text = text..'{fa3249} CHL '..idchrep
                    chrepstat = true
                    onepomet = false
                    lua_thread.create(function()
                        wait(5000)
                        chrepstat = false
                        idchnick = nil
                    end)
                end
            end
        end
        for i, val in pairs(cheat) do
            if report:find(val) and onepomet then
                local idchnick1, idchnick2 = report:match('(%S+)_(%S+)')
                idspecnick = idchnick1..'_'..idchnick2
                if idspecnick ~= nickname then
                    if sampGetPlayerIdByNickname(idspecnick) then
                        idspecrep = sampGetPlayerIdByNickname(idspecnick)
                        text = text..'{fa3249} SPEC '..idspecrep
                        specrepstat = true
                        onepomet = false
                        lua_thread.create(function()
                            wait(5000)
                            specrepstat = false
                            idspecnick = nil
                        end)
                    end
                end
            end
        end
        for i, val in pairs(descc) do
            if report:find(val) and onepomet then
                local idchnick1, idchnick2 = report:match('(%S+)_(%S+)')
                descnickrep = idchnick1..'_'..idchnick2
                if sampGetPlayerIdByNickname(descnickrep) then
                    iddescrep = sampGetPlayerIdByNickname(descnickrep)
                    text = text..'{fa3249} DESC '..iddescrep
                    descrepstat = true
                    onepomet = false
                    lua_thread.create(function()
                        wait(5000)
                        descrepstat = false
                        descnickrep = nil
                    end)
                end
            end
        end
    else
        for i, val in pairs(aviats) do
            if report:find(val) then
                lua_thread.create(function()
                    aviagoto = true
                    avgotoid = idj2
                    wait(5000)
                    avgotoid = nil
                    aviagoto = false
                end)
                text = text..'{fa3249} GOTO '..avgotoid
            elseif Config.Settings.OnlyRep then
                return false
            end
        end
    end
    if nickj2 == nickj1 then
        if Config.Settings.JailHelp then
            text = text..'{fa3249} J '..idk..', репорт от жертвы.'
            reportotj = true
            idjer = idj2
            lua_thread.create(function()          
                wait(5000)
                reportotj = false
                nickj1 = nil
            end)

        end
    end
    if Config.Settings.ReportUved then
        --notf.addNotification(text, 6, 6)
        return false 
    end
  end
  if Config.Settings.idchat then
        getPlayersNickname() -- Подгружаем список игроков на сервере. Делается для снижения нагрузки, т.к. используется в одном цикле несколько раз.
        Enter = false -- Переменная ввода сообщения в чат.
        for i = 0, 999 do
            if sampIsPlayerConnected(i) and PlayersNickname[i] then
            if string.find(text, PlayersNickname[i]) and not string.find(text, PlayersNickname[i].."%[%d+%]") and not string.find(text, PlayersNickname[i].." %[ID %d+%]") then -- Если в чате есть имя игрока и оно уже не содержит ID.
                PlayerName = string.match(text, PlayersNickname[i])
                if PlayerName then
                PlayerID = sampGetPlayerIdByNickname(PlayerName)
                if PlayerID then
                    text = string.gsub(text, PlayerName, PlayerName.."["..PlayerID.."]")
                    Enter = true
                end
                end
            end
            end
        end
        if Enter then -- Если строка была измепена скриптом, то сообщение вводится им же.
            sampAddChatMessage(text, bit.rshift(color, 8))
            return false
        end
  end
  return {color, text}
end

function deleteiddtext()
    local deletedds = idds
    lua_thread.create(function()
        wait(15000)
        sampDestroy3dText(deletedds)
    end)
end

function dreport()
    for it, valt in pairs(ttt) do
        for iv, valv in pairs(vvv) do
            if iv == it then
               
            end 
        end
    end    
end

function sampGetPlayerIdByNickname(nick)
  nick = tostring(nick)
  local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
  if nick == sampGetPlayerNickname(myid) then return myid end
  for i = 0, 1003 do
    if sampIsPlayerConnected(i) and sampGetPlayerNickname(i) == nick then
      return i
    end
  end
end

function gotocmd(arg)
  sampSendChat('/goto ' .. arg)
  MYXg, MYYg, MYZg = getCharCoordinates(playerPed)
end

function getherecmd(arg)
  sampSendChat('/gethere ' .. arg)
  MYXg, MYYg, MYZg = getCharCoordinates(playerPed)
end

sampRegisterChatCommand('ad', function(id)
  if tonumber(id) then
    if sampIsPlayerConnected(id) then
      nickname = sampGetPlayerNickname(tonumber(id))
      idad = tonumber(id)
    end
  end
end)

sampRegisterChatCommand('dh', function()
      if nickname then
            sampSendChat('/dhist '..nickname)
            lua_thread.create(function()
            wait(500)
            if Config.Settings.FastScreen then
                screenshot.requestEx('example', '_'..vremya..'_'..data)
            else
                makeScreenshot()
            end
        end)
      end
  end)
  sampRegisterChatCommand('uu', function()
      if nickname then
          nicknamespec = nickname
          idspec = idad
          sampSendChat('/re '..idspec)
          specstat = true
      end
  end)
sampRegisterChatCommand('chl', function()
      if nickname then
          sampSendChat('/chlog '..nickname)
          lua_thread.create(function()
            wait(500)
            if Config.Settings.FastScreen then
                screenshot.requestEx('example', '_'..vremya..'_'..data)
            else
                makeScreenshot()
            end
        end)
      end
  end)

sampRegisterChatCommand('adj', function(idj1)
  if tonumber(idj1) then
    if sampIsPlayerConnected(idj1) then
      nicknamej1 = sampGetPlayerNickname(tonumber(idj1))
    else
      sampAddChatMessage(tag .. '?????? ?? ?????????? ?? ???????', -1)
    end
  else
    sampAddChatMessage(tag .. '??????? /adj [ID]', -1)
  end
end)


function imgui.DegradeButton(label, size)
    local duration = {
        1.0, -- ???????????? ????????? ????? hovered / idle
        0.3  -- ???????????? ???????? ????? ???????
    }

    local cols = {
        default = imgui.ImVec4(imgui.GetStyle().Colors[imgui.Col.Button]),
        hovered = imgui.ImVec4(imgui.GetStyle().Colors[imgui.Col.ButtonHovered]),
        active  = imgui.ImVec4(imgui.GetStyle().Colors[imgui.Col.ButtonActive])
    }

    if not FBUTPOOL then FBUTPOOL = {} end
    if not FBUTPOOL[label] then
        FBUTPOOL[label] = {
            color = cols.default,
            clicked = { nil, nil },
            hovered = {
                cur = false,
                old = false,
                clock = nil,
            }
        }
    end

    local degrade = function(before, after, start_time, duration)
        local result_vec4 = before
        local timer = os.clock() - start_time
        if timer >= 0.00 then
            local offs = {
                x = after.x - before.x,
                y = after.y - before.y,
                z = after.z - before.z,
                w = after.w - before.w
            }

            result_vec4.x = result_vec4.x + ( (offs.x / duration) * timer )
            result_vec4.y = result_vec4.y + ( (offs.y / duration) * timer )
            result_vec4.z = result_vec4.z + ( (offs.z / duration) * timer )
            result_vec4.w = result_vec4.w + ( (offs.w / duration) * timer )
        end
        return result_vec4
    end

    if FBUTPOOL[label]['clicked'][1] and FBUTPOOL[label]['clicked'][2] then
        if os.clock() - FBUTPOOL[label]['clicked'][1] <= duration[2] then
            FBUTPOOL[label]['color'] = degrade(
                FBUTPOOL[label]['color'],
                cols.active,
                FBUTPOOL[label]['clicked'][1],
                duration[2]
            )
            goto no_hovered
        end

        if os.clock() - FBUTPOOL[label]['clicked'][2] <= duration[2] then
            FBUTPOOL[label]['color'] = degrade(
                FBUTPOOL[label]['color'],
                FBUTPOOL[label]['hovered']['cur'] and cols.hovered or cols.default,
                FBUTPOOL[label]['clicked'][2],
                duration[2]
            )
            goto no_hovered
        end
    end

    if FBUTPOOL[label]['hovered']['clock'] ~= nil then
        if os.clock() - FBUTPOOL[label]['hovered']['clock'] <= duration[1] then
            FBUTPOOL[label]['color'] = degrade(
                FBUTPOOL[label]['color'],
                FBUTPOOL[label]['hovered']['cur'] and cols.hovered or cols.default,
                FBUTPOOL[label]['hovered']['clock'],
                duration[1]
            )
        else
            FBUTPOOL[label]['color'] = FBUTPOOL[label]['hovered']['cur'] and cols.hovered or cols.default
        end
    end

    ::no_hovered::

    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(FBUTPOOL[label]['color']))
    imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(FBUTPOOL[label]['color']))
    imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(FBUTPOOL[label]['color']))
    local result = imgui.Button(label, size or imgui.ImVec2(0, 0))
    imgui.PopStyleColor(3)

    if result then
        FBUTPOOL[label]['clicked'] = {
            os.clock(),
            os.clock() + duration[2]
        }
    end

    FBUTPOOL[label]['hovered']['cur'] = imgui.IsItemHovered()
    if FBUTPOOL[label]['hovered']['old'] ~= FBUTPOOL[label]['hovered']['cur'] then
        FBUTPOOL[label]['hovered']['old'] = FBUTPOOL[label]['hovered']['cur']
        FBUTPOOL[label]['hovered']['clock'] = os.clock()
    end

    return result
end

function imgui.Link(link, text)
    link = 'https://'..link
    if status_hovered then
        local p = imgui.GetCursorScreenPos()
        imgui.TextColored(imgui.ImVec4(0, 0.5, 1, 1), text)
        imgui.GetWindowDrawList():AddLine(imgui.ImVec2(p.x, p.y + imgui.CalcTextSize(text).y), imgui.ImVec2(p.x + imgui.CalcTextSize(text).x, p.y + imgui.CalcTextSize(text).y), imgui.GetColorU32(imgui.ImVec4(0, 0.5, 1, 1)))
    else
        imgui.TextColored(imgui.ImVec4(0, 0.3, 0.8, 1), text)
    end
    if imgui.IsItemClicked() then os.execute('explorer '..link)
    elseif imgui.IsItemHovered() then
        status_hovered = true else status_hovered = false
    end
end

function imgui.TextQuestion(label, description)
    imgui.TextDisabled(label)

    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
            imgui.PushTextWrapPos(600)
                imgui.TextUnformatted(description)
            imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end

function sampGetPlayerIdByNickname(nick)
  nick = tostring(nick)
  local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
  if nick == sampGetPlayerNickname(myid) then return myid end
  for i = 0, 1003 do
    if sampIsPlayerConnected(i) and sampGetPlayerNickname(i) == nick then
      return i
    end
  end
end

sampRegisterChatCommand('gd', function(iddesc)
      if tonumber(iddesc) then
        if sampIsPlayerConnected(iddesc) then
          nickd = sampGetPlayerNickname(tonumber(iddesc))
          idd = tonumber(iddesc)
          sampSendChat('/gd '..idd)
          tic = 0
          lastticgd = tic
        end
      end
end)

function imgui.OnDrawFrame()
  if win.mainwin.v then
     local sw, sh = getScreenResolution()
     imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
     imgui.SetNextWindowSize(imgui.ImVec2(800, 580), imgui.Cond.FirstUseEver)
     imgui.Begin(u8'Ahelp22', imgui.ImVec2(1, 1), imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
     imgui.Text(fa.ICON_HEART ..  u8 'ADMINTOOLS')
     imgui.SameLine() 
     imgui.Text(fa.ICON_CHECK_SQUARE ..  u8 ' Версия: 4.8')
     imgui.SameLine() 
     imgui.PushItemWidth(100)
     if imgui.Combo(u8'##them', themescombo, arrs.arr_themes, #arrs.arr_themes) then
        Config.Settings.Theme = themescombo.v+1
        themes1(themescombo.v+1)
        inicfg.save(Config, 'ahelp.ini')
     end
     imgui.SameLine(769)
     if imgui.Button(fa.ICON_TIMES .. '##closewin') then
        win.mainwin.v = not win.mainwin.v
        imgui.Process = win.mainwin.v
        mainwindow = not mainwindow
     end
     if imgui.DegradeButton(u8'Основное', imgui.ImVec2(85, 25)) then
        acn = 1
     end
     imgui.SameLine()
     if imgui.DegradeButton(u8'Персонаж', imgui.ImVec2(85, 25)) then
        acn = 7
     end
     imgui.SameLine()
     if imgui.DegradeButton(u8'Фракции', imgui.ImVec2(85, 25)) then 
        acn = 3
     end
     imgui.SameLine()
     if imgui.DegradeButton(u8'Крайм', imgui.ImVec2(85, 25)) then
        acn = 8
     end
     imgui.SameLine()
     if imgui.DegradeButton(u8'Читы', imgui.ImVec2(85, 25)) then 
        acn = 4
     end
     imgui.SameLine()
     if imgui.DegradeButton(u8'Телепорты', imgui.ImVec2(85, 25)) then
        acn = 5
     end
     imgui.SameLine()
     if imgui.DegradeButton(u8'Настройки', imgui.ImVec2(85, 25)) then
        acn = 6
     end
     imgui.SameLine()
     if imgui.DegradeButton(u8'Информация', imgui.ImVec2(117, 25)) then
        acn = 9
     end
     if acn == 1 then
         imgui.BeginChild('##1', imgui.ImVec2(385, 495), true)
             if imgui.Checkbox(u8'Отключить [A] чат', check1) then 
                Config.Settings.achatini = check1.v
                inicfg.save(Config, 'ahelp.ini')
             end
             if imgui.Checkbox(u8'Отключить все чаты', check2) then 
                Config.Settings.amessini = check2.v
                inicfg.save(Config, 'ahelp.ini')
             end
             imgui.SameLine()
             imgui.TextQuestion('( ? )', u8'Отключает все админские сообщения в чате.')
             if imgui.Checkbox(u8'Включить ID в KillList', idkl) then 
                Config.Settings.IdKillList = idkl.v
                inicfg.save(Config, 'ahelp.ini')
             end
             if imgui.Checkbox(u8'Отключить рекламу', inv) then 
               Config.Settings.ROFF = inv.v
               inicfg.save(Config, 'ahelp.ini')
             end
             if imgui.Checkbox(u8'Автоматическое /agm', agm) then 
                Config.Settings.AutoGodMod = agm.v
                inicfg.save(Config, 'ahelp.ini')
             end
             imgui.SameLine()
             imgui.TextQuestion('( ? )', u8'Автоматически прописывает /agm при входе на сервер.')
             if imgui.Checkbox(u8'Автоматическое /ghost', ghost) then 
                Config.Settings.AutoGhost = ghost.v
                inicfg.save(Config, 'ahelp.ini')
             end
             imgui.SameLine()
             imgui.TextQuestion('( ? )', u8'Автоматически прописывает /ghost при входе на сервер.')
             if imgui.Checkbox(u8'Автоматическое /rpc', cheal) then 
                Config.Settings.ServerCarHeal = cheal.v
                inicfg.save(Config, 'ahelp.ini')
             end
             imgui.SameLine()
             imgui.TextQuestion('( ? )', u8'При малом хп у авто прописывает /rpc.')
             if imgui.Checkbox(u8'Автоматическое /unstad', autou) then 
                Config.Settings.AutoUnd = autou.v
                inicfg.save(Config, 'ahelp.ini')
             end
             imgui.SameLine()
             imgui.TextQuestion('( ? )', u8'Если вы упали в стадию, автоматически поднимет с нее.')
             --if imgui.Checkbox(u8'Пометки в репорте', GMped) then 
                --Config.Settings.OnlyRep = GMped.v
                --inicfg.save(Config, 'ahelp.ini')
             --end
             if imgui.Checkbox(u8'Автоматическое реагирование на репорты', autoreac) then 
                Config.Settings.AutoReact = autoreac.v
                inicfg.save(Config, 'ahelp.ini')
             end
             imgui.SameLine()
             imgui.TextQuestion('( ? )', u8'Автоматическое реагирование на репорты с красными приписками.')
             if imgui.Checkbox(u8'Автоматическое реагирование на вары', autoreacvar) then 
                Config.Settings.AutoReactvar = autoreacvar.v
                inicfg.save(Config, 'ahelp.ini')
             end
             imgui.SameLine()
             imgui.TextQuestion('( ? )', u8'Автоматическое реагирование на слежку за варами.')
             if imgui.Checkbox(u8'Автоматическое реагирование на слёты', autoreacslet) then 
                Config.Settings.AutoReactslet = autoreacslet.v
                inicfg.save(Config, 'ahelp.ini')
             end
             imgui.SameLine()
             imgui.TextQuestion('( ? )', u8'Автоматическое реагирование на сообщения о слетевших домах.')
             if imgui.Checkbox(u8'Спавн в aworld', admwsp) then 
                Config.Settings.SpawnOnAdmWorld = admwsp.v
                inicfg.save(Config, 'ahelp.ini')
             end
         imgui.EndChild()
         imgui.SameLine()
         imgui.BeginChild('##11', imgui.ImVec2(388, 495), true)
         if imgui.Checkbox(u8'Изменение цветов чата', colorschb) then 
                Config.Settings.Colors = colorschb.v
                inicfg.save(Config, 'ahelp.ini')
         end
         imgui.SameLine()
         imgui.TextQuestion('( ? )', u8'/acolor задать цвет админ чата, /repcolor задать цвет репорта.')
         if imgui.Checkbox(u8'Отключить действия других админов', destadm) then 
                Config.Settings.AntiA = destadm.v
                inicfg.save(Config, 'ahelp.ini')
         end
         imgui.SameLine()
         imgui.TextQuestion('( ? )', u8'Отключает админские сообщения в чате связанные с другими админами.')
         if imgui.Checkbox(u8'Отключить AA:', offaa) then 
                Config.Settings.offaames = offaa.v
                inicfg.save(Config, 'ahelp.ini')
         end
         if imgui.Checkbox(u8'Автоматическое /flushinfo', checkboxes.auflush) then 
                Config.Settings.autoflush = checkboxes.auflush.v
                inicfg.save(Config, 'ahelp.ini')
         end
         imgui.SameLine()
         imgui.TextQuestion('( ? )', u8'Автоматически прописывает /flushinfo при входе на сервер.')
         if imgui.Checkbox(u8'Автоматическое /megapunch', checkboxes.aumegapun) then 
                Config.Settings.automegapun = checkboxes.aumegapun.v
                inicfg.save(Config, 'ahelp.ini')
         end
         imgui.SameLine()
         imgui.TextQuestion('( ? )', u8'Автоматически прописывает /megapunch при входе на сервер.')
         if imgui.Checkbox(u8'Отключить розыск в чате', checkboxes.antiwant) then 
                Config.Settings.antiw = checkboxes.antiwant.v
                inicfg.save(Config, 'ahelp.ini')
         end
         imgui.SameLine()
         imgui.TextQuestion('( ? )', u8'Визуально отключает розыски, но помощник по нрп киллам все так же работает.')
         if imgui.Checkbox(u8'Включить ID игроков в чате', checkboxes.idc) then 
                Config.Settings.idchat = checkboxes.idc.v
                inicfg.save(Config, 'ahelp.ini')
         end
         if imgui.Checkbox(u8'Подсети', checkboxes.ipf) then 
                Config.Settings.ipfind = checkboxes.ipf.v
                inicfg.save(Config, 'ahelp.ini')
         end
         imgui.SameLine()
         imgui.TextQuestion('( ? )', u8'Чекер подсетей.')
         if checkboxes.ipf.v then
            imgui.SameLine()
            if imgui.Button(u8'Добавить') then
                lua_thread.create(function()
                    win.mainwin.v = false
                    imgui.Process = false
                    sampShowDialog(6406, "Ввод подсети", "Введите подсеть в формате xxx.xxx\nДля удаления существующих напишите DELETE\nДля просмотра записанных подсетей напишите SHOW", "ОК", "Отмена", DIALOG_STYLE_INPUT)
                    while sampIsDialogActive(6406) do wait(100) end
                    local result, button, _, input = sampHasDialogRespond(6406)
                    if button ~= 0 then
                        if input == 'SHOW' then
                            sampAddChatMessage('{fffb00}Записанные подсети:')
                            for i, val in pairs(Config.arr_ip) do
                                sampAddChatMessage(val, -1)
                            end
                        elseif input == 'DELETE' then
                            Config.arr_ip = {}
                            sampAddChatMessage('Все подсети удалены.', -1)
                            inicfg.save(Config, 'ahelp.ini')
                        else
                            if input:find('%d+.%d+') then
                                Config.arr_ip[#Config.arr_ip+1] = input
                            else
                                sampAddChatMessage('Запишите подесть в формате xxx.xxx', -1)
                            end
                            inicfg.save(Config, 'ahelp.ini')
                        end
                    end
                    win.mainwin.v = true
                    imgui.Process = true
                end)
            end
            imgui.Text(u8'Включите входы и выходы игроков в /mm.')
         end
         if imgui.Checkbox(u8'Автоматическое /keyinfo & /shotinfo', checkboxes.sk) then 
                Config.Settings.ShKey = checkboxes.sk.v
                inicfg.save(Config, 'ahelp.ini')
         end
         imgui.SameLine()
         imgui.TextQuestion('( ? )', u8'Автоматически прописывает /shotinfo & /keyinfo при входе на сервер.')
         if imgui.Checkbox(u8'Fix adminplus', checkboxes.apf) then 
                Config.Settings.admplusfix = checkboxes.apf.v
                inicfg.save(Config, 'ahelp.ini')
         end
         imgui.SameLine()
         imgui.TextQuestion('( ? )', u8'Позволяет совмещать эти скрипты.')
         imgui.EndChild()
     elseif acn == 2 then
         imgui.BeginChild('##2', imgui.ImVec2(785, 495), true)
            kl = 0
            posvehx = 5
            posvehy = 95
            postextx = 10
            postexty = 95
            for i = 0, 311, 1 do
                imgui.SetCursorPos(imgui.ImVec2(posvehx, posvehy))
                imgui.BeginChild("##12dsgpokd" .. i, imgui.ImVec2(80, 95))
                imgui.EndChild()    

                if imgui.IsItemClicked() then
                    MODEL = i
                    sampSendChat('/giveskin '..MODEL)
                end

                imgui.SetCursorPos(imgui.ImVec2(posvehx, posvehy))
                imgui.Image(skinpng[i], imgui.ImVec2(80, 95))

                postextx = postextx + 100
                posvehx = posvehx + 100
                kl = kl + 1
                if kl > 6 then
                    kl = 0
                    posvehx = 5
                    postextx = 10
                    posvehy = posvehy + 120
                    postexty = posvehy + 90
                end
            end
         imgui.EndChild()
     elseif acn == 3 then
         imgui.BeginChild('##3', imgui.ImVec2(785, 495), true)

            imgui.Combo(u8'Фракции LS', fractlscombo, arrs.arr_fractls, #arrs.arr_fractls)
            if imgui.Button(u8'Вступить во фракцию##1') then 
                lsfract = arrs.arr_fractls[fractlscombo.v+1]
                sampSendChat('/fkick '..clientName)
                sampSendChat('/infract '..lsfract)
            end
            imgui.SameLine()
            if imgui.Button(u8'Следить за игроками фракции##1') then 
                lsfract = arrs.arr_fractls[fractlscombo.v+1]
                arrs.idfractspec = {}
                fractspec = true
                sampSendChat('/fract '..lsfract)
                win.mainwin.v = false
            end
            imgui.Combo(u8'Фракции SF', fractsfcombo, arrs.arr_fractsf, #arrs.arr_fractsf)
            if imgui.Button(u8'Вступить во фракцию##2') then 
                sffract = arrs.arr_fractsf[fractsfcombo.v+1]
                sampSendChat('/fkick '..clientName)
                sampSendChat('/infract '..sffract)
            end
            imgui.SameLine()
            if imgui.Button(u8'Следить за игроками фракции##2') then 
                sffract = arrs.arr_fractsf[fractsfcombo.v+1]
                arrs.idfractspec = {}
                fractspec = true
                sampSendChat('/fract '..sffract)
                win.mainwin.v = false
            end
            imgui.Combo(u8'Фракции LV', fractlvcombo, arrs.arr_fractlv, #arrs.arr_fractlv)
            if imgui.Button(u8'Вступить во фракцию##3') then 
                lvfract = arrs.arr_fractlv[fractlvcombo.v+1]
                sampSendChat('/fkick '..clientName)
                sampSendChat('/infract '..lvfract)
            end
            imgui.SameLine()
            if imgui.Button(u8'Следить за игроками фракции') then 
                lvfract = arrs.arr_fractlv[fractlvcombo.v+1]
                arrs.idfractspec = {}
                fractspec = true
                sampSendChat('/fract '..lvfract)
                win.mainwin.v = false
            end
            if imgui.Button(u8'Статистика фракций по наборам', imgui.ImVec2(570, 25)) then
                sampSendChat('/invstat')
                win.main2.v = false
                imgui.Process = false
                mainwindow = false
            end
            if imgui.Button(u8'Статистика фракций по онлайну', imgui.ImVec2(570, 25)) then
                sampSendChat('/fstat')
                win.main2.v = false
                imgui.Process = false
                mainwindow = false
            end
            if imgui.Button(u8'Выдать самый высокий ранг во фракции', imgui.ImVec2(570, 25)) then
                rang = 15
                rangg = true
                sampSendChat('/fractrank '..rang)
            end
            if imgui.Button(u8'Уволиться', imgui.ImVec2(570, 25)) then
                local result, my3id = sampGetPlayerIdByCharHandle(PLAYER_PED)
                sampSendChat('/fkick '..my3id)
            end
         imgui.EndChild()
     elseif acn == 8 then
         imgui.BeginChild('##8', imgui.ImVec2(785, 495), true)

            imgui.Combo(u8'Банды', famlscombo, arrs.arr_famls, #arrs.arr_famls)
            if imgui.Button(u8'Вступить в банду##4') then 
                lsfam = arrs.arr_famls[famlscombo.v+1]
                sampSendChat('/fkick '..clientName)
                sampSendChat('/infam '..lsfam)
            end
            imgui.Combo(u8'Мафии', famsfcombo, arrs.arr_famsf, #arrs.arr_famsf)
            if imgui.Button(u8'Вступить в мафию##5') then 
                sffam = arrs.arr_famsf[famsfcombo.v+1]
                sampSendChat('/fkick '..clientName)
                sampSendChat('/infam '..sffam)
            end
            imgui.Combo(u8'Клубы', famlvcombo, arrs.arr_famlv, #arrs.arr_famlv)
            if imgui.Button(u8'Вступить в клуб##6') then 
                lvfam = arrs.arr_famlv[famlvcombo.v+1]
                sampSendChat('/fkick '..clientName)
                sampSendChat('/infam '..lvfam)
            end
            if imgui.Button(u8'Статистика крайма по наборам', imgui.ImVec2(570, 25)) then
                sampSendChat('/invstat')
                win.main2.v = false
                imgui.Process = false
                mainwindow = false
            end
            if imgui.Button(u8'Статистика крайма по онлайну', imgui.ImVec2(570, 25)) then
                sampSendChat('/fstat')
                win.main2.v = false
                imgui.Process = false
                mainwindow = false
            end
            if imgui.Button(u8'Выдать самый высокий ранг в крайме', imgui.ImVec2(570, 25)) then
                grang = 10
                grangg = true
                sampSendChat('/famrank '..grang)
            end
            if imgui.Button(u8'Уволиться', imgui.ImVec2(570, 25)) then
                local result, my3id = sampGetPlayerIdByCharHandle(PLAYER_PED)
                sampSendChat('/fkick '..my3id)
            end
         imgui.EndChild()
     elseif acn == 4 then
        imgui.BeginChild('##4', imgui.ImVec2(785, 495), true)
            if imgui.Checkbox(u8'GM', pedgm) then 
                Config.Settings.PedGodMod = pedgm.v
                inicfg.save(Config, 'ahelp.ini')
            end
            if imgui.Checkbox(u8'GMcar', cargm) then 
                Config.Settings.CarGodMod = cargm.v
                inicfg.save(Config, 'ahelp.ini')
            end
            if imgui.Checkbox(u8'WH avia', aviawh) then 
                Config.Settings.WhAvia = aviawh.v
                inicfg.save(Config, 'ahelp.ini')
            end
            if imgui.Checkbox(u8'AirBrake', imair) then 
                Config.Settings.AirBrake = imair.v
                inicfg.save(Config, 'ahelp.ini')
            end
            if imair.v then
                if imgui.SliderFloat(u8"Ускорение аирбрейка", sliders.airpedslider, 1, 10) then
                    Config.Settings.Airspeedped = sliders.airpedslider.v
                    inicfg.save(Config, 'ahelp.ini')
                end
            end
            if imgui.Checkbox(u8'ClickWarp', imcw) then 
                Config.Settings.ClickWarp = imcw.v
                inicfg.save(Config, 'ahelp.ini')
            end
            if imgui.Checkbox(u8'SpeedHack', checkboxes.speedh) then 
                Config.Settings.SpeedHack = checkboxes.speedh.v
                inicfg.save(Config, 'ahelp.ini')
            end
            if imgui.Checkbox(u8'CamHack на G', checkboxes.cmh) then 
                Config.Settings.camhack = checkboxes.cmh.v
                inicfg.save(Config, 'ahelp.ini')
            end
        imgui.EndChild()
     elseif acn == 5 then
         imgui.BeginChild('##5', imgui.ImVec2(785, 495), true)
            imgui.Text('LOS-SANTOS:')
            if imgui.Button(u8'ГОРОД##1', imgui.ImVec2(80, 25)) then
                sampSendChat('/gotols')
            end
            imgui.SameLine()
            if imgui.Button(u8'МЕРИЯ##1', imgui.ImVec2(80, 25)) then
                lua_thread.create(function()
                    sampSendChat('/gotols')
                    wait(1000)
                    setCharCoordinates(PLAYER_PED, 1480, -1751, 15)
                end)
            end
            imgui.SameLine()
            if imgui.Button(u8'АВТОСАЛОН 1##1', imgui.ImVec2(80, 25)) then
                lua_thread.create(function()
                    sampSendChat('/gotols')
                    wait(1000)
                    sampSendChat('/gps 115')
                    wait(100)
                    sampSendChat('/togps')
                end)
            end
            imgui.SameLine()
            if imgui.Button(u8'АВТОСАЛОН 2##1', imgui.ImVec2(80, 25)) then
                lua_thread.create(function()
                    sampSendChat('/gotols')
                    wait(1000)
                    sampSendChat('/gps 116')
                    wait(100)
                    sampSendChat('/togps')
                end)
            end
            if imgui.Button(u8'PD 1##1', imgui.ImVec2(80, 25)) then
                sampSendChat('/lspd')
            end
            imgui.SameLine()
            if imgui.Button(u8'PD 2##1', imgui.ImVec2(80, 25)) then
                sampSendChat('/lspd2')
            end
            imgui.SameLine()
            if imgui.Button(u8'PD 3##1', imgui.ImVec2(80, 25)) then
                sampSendChat('/lspd3')
            end
            imgui.SameLine()
            if imgui.Button(u8'PD 4##1', imgui.ImVec2(80, 25)) then
                sampSendChat('/lspd4')
            end
            imgui.SameLine()
            if imgui.Button(u8'FBI##1', imgui.ImVec2(80, 25)) then
                sampSendChat('/lsfbi')
            end
            if imgui.Button(u8'EMS 1##1', imgui.ImVec2(80, 25)) then
                sampSendChat('/lsems')
            end
            imgui.SameLine()
            if imgui.Button(u8'EMS 2##1', imgui.ImVec2(80, 25)) then
                sampSendChat('/lsems2')
            end
            imgui.SameLine()
            if imgui.Button(u8'EMS 3##1', imgui.ImVec2(80, 25)) then
                sampSendChat('/lsems3')
            end
            imgui.SameLine()
            if imgui.Button(u8'NEWS 1##1', imgui.ImVec2(80, 25)) then
                sampSendChat('/lsnews')
            end
            imgui.SameLine()
            if imgui.Button(u8'NEWS 2##1', imgui.ImVec2(80, 25)) then
                sampSendChat('/lsnews2')
            end
            imgui.SameLine()
            if imgui.Button(u8'NEWS 3##1', imgui.ImVec2(80, 25)) then
                sampSendChat('/lsnews3')
            end
            if imgui.Button(u8'ARMY 1##1', imgui.ImVec2(80, 25)) then
                sampSendChat('/lsarmy')
            end
            imgui.SameLine()
            if imgui.Button(u8'ARMY 2##1', imgui.ImVec2(80, 25)) then
                sampSendChat('/lsarmy2')
            end
            imgui.SameLine()
            if imgui.Button(u8'TAXI 1##1', imgui.ImVec2(80, 25)) then
                sampSendChat('/lstaxi')
            end
            imgui.SameLine()
            if imgui.Button(u8'TAXI 2##1', imgui.ImVec2(80, 25)) then
                sampSendChat('/lstaxi2')
            end
            imgui.Text('SAN FIERRO:')
            if imgui.Button(u8'ГОРОД##2', imgui.ImVec2(80, 25)) then
                sampSendChat('/gotosf')
            end
            imgui.SameLine()
            if imgui.Button(u8'МЕРИЯ##2', imgui.ImVec2(80, 25)) then
               lua_thread.create(function()
                sampSendChat('/gotosf')
                wait(1000)
                setCharCoordinates(PLAYER_PED, -2755, 374, 4)
               end)
            end
            imgui.SameLine()
            if imgui.Button(u8'АВТОСАЛОН 1##2', imgui.ImVec2(80, 25)) then
                lua_thread.create(function()
                    sampSendChat('/gotosf')
                    wait(1000)
                    sampSendChat('/gps 115')
                    wait(100)
                    sampSendChat('/togps')
                end)
            end
            imgui.SameLine()
            if imgui.Button(u8'АВТОСАЛОН 2##2', imgui.ImVec2(80, 25)) then
                lua_thread.create(function()
                    sampSendChat('/gotosf')
                    wait(1000)
                    sampSendChat('/gps 116')
                    wait(100)
                    sampSendChat('/togps')
                end)
            end
            if imgui.Button(u8'PD 1##2', imgui.ImVec2(80, 25)) then
                sampSendChat('/sfpd')
            end
            imgui.SameLine()
            if imgui.Button(u8'PD 2##2', imgui.ImVec2(80, 25)) then
                sampSendChat('/sfpd2')
            end
            imgui.SameLine()
            if imgui.Button(u8'PD 3##2', imgui.ImVec2(80, 25)) then
                sampSendChat('/sfpd3')
            end
            imgui.SameLine()
            if imgui.Button(u8'PD 4##2', imgui.ImVec2(80, 25)) then
                sampSendChat('/sfpd4')
            end
            imgui.SameLine()
            if imgui.Button(u8'FBI##2', imgui.ImVec2(80, 25)) then
                sampSendChat('/sffbi')
            end
            if imgui.Button(u8'EMS 1##2', imgui.ImVec2(80, 25)) then
                sampSendChat('/sfems')
            end
            imgui.SameLine()
            if imgui.Button(u8'EMS 2##2', imgui.ImVec2(80, 25)) then
                sampSendChat('/sfems2')
            end
            imgui.SameLine()
            if imgui.Button(u8'EMS 3##2', imgui.ImVec2(80, 25)) then
                sampSendChat('/sfems3')
            end
            imgui.SameLine()
            if imgui.Button(u8'NEWS 1##2', imgui.ImVec2(80, 25)) then
                sampSendChat('/sfnews')
            end
            imgui.SameLine()
            if imgui.Button(u8'NEWS 2##2', imgui.ImVec2(80, 25)) then
                sampSendChat('/sfnews2')
            end
            imgui.SameLine()
            if imgui.Button(u8'NEWS 3##2', imgui.ImVec2(80, 25)) then
                sampSendChat('/sfnews3')
            end
            if imgui.Button(u8'ARMY 1##2', imgui.ImVec2(80, 25)) then
                sampSendChat('/sfarmy')
            end
            imgui.SameLine()
            if imgui.Button(u8'ARMY 2##2', imgui.ImVec2(80, 25)) then
                sampSendChat('/sfarmy2')
            end
            imgui.SameLine()
            if imgui.Button(u8'TAXI 1##2', imgui.ImVec2(80, 25)) then
                sampSendChat('/sftaxi')
            end
            imgui.SameLine()
            if imgui.Button(u8'TAXI 2##2', imgui.ImVec2(80, 25)) then
                sampSendChat('/sftaxi2')
            end
            imgui.Text('LAS VENTURAS:')
            if imgui.Button(u8'ГОРОД##3', imgui.ImVec2(80, 25)) then
                sampSendChat('/gotolv')
            end
            imgui.SameLine()
            if imgui.Button(u8'МЕРИЯ##3', imgui.ImVec2(80, 25)) then
                lua_thread.create(function()
                    sampSendChat('/gotolv')
                    wait(1000)
                    setCharCoordinates(PLAYER_PED, 1044, 1012, 11)
                end)
            end
            imgui.SameLine()
            if imgui.Button(u8'АВТОСАЛОН 1##3', imgui.ImVec2(80, 25)) then
                lua_thread.create(function()
                    sampSendChat('/gotolv')
                    wait(1000)
                    sampSendChat('/gps 115')
                    wait(100)
                    sampSendChat('/togps')
                end)
            end
            imgui.SameLine()
            if imgui.Button(u8'АВТОСАЛОН 2##3', imgui.ImVec2(80, 25)) then
                lua_thread.create(function()
                    sampSendChat('/gotolv')
                    wait(1000)
                    sampSendChat('/gps 116')
                    wait(100)
                    sampSendChat('/togps')
                end)
            end
            if imgui.Button(u8'PD 1##3', imgui.ImVec2(80, 25)) then
                sampSendChat('/lvpd')
            end
            imgui.SameLine()
            if imgui.Button(u8'PD 2##3', imgui.ImVec2(80, 25)) then
                sampSendChat('/lvpd2')
            end
            imgui.SameLine()
            if imgui.Button(u8'PD 3##3', imgui.ImVec2(80, 25)) then
                sampSendChat('/lvpd3')
            end
            imgui.SameLine()
            if imgui.Button(u8'PD 4##3', imgui.ImVec2(80, 25)) then
                sampSendChat('/lvpd4')
            end
            imgui.SameLine()
            if imgui.Button(u8'FBI##3', imgui.ImVec2(80, 25)) then
                sampSendChat('/lvfbi')
            end
            if imgui.Button(u8'EMS 1##3', imgui.ImVec2(80, 25)) then
                sampSendChat('/lvems')
            end
            imgui.SameLine()
            if imgui.Button(u8'EMS 2##3', imgui.ImVec2(80, 25)) then
                sampSendChat('/lvems2')
            end
            imgui.SameLine()
            if imgui.Button(u8'EMS 3##3', imgui.ImVec2(80, 25)) then
                sampSendChat('/lvems3')
            end
            imgui.SameLine()
            if imgui.Button(u8'NEWS 1##3', imgui.ImVec2(80, 25)) then
                sampSendChat('/lvnews')
            end
            imgui.SameLine()
            if imgui.Button(u8'NEWS 2##3', imgui.ImVec2(80, 25)) then
                sampSendChat('/lvnews2')
            end
            imgui.SameLine()
            if imgui.Button(u8'NEWS 3##3', imgui.ImVec2(80, 25)) then
                sampSendChat('/lvnews3')
            end
            if imgui.Button(u8'ARMY 1##3', imgui.ImVec2(80, 25)) then
                sampSendChat('/lvarmy')
            end
            imgui.SameLine()
            if imgui.Button(u8'ARMY 2##3', imgui.ImVec2(80, 25)) then
                sampSendChat('/lvarmy2')
            end
            imgui.SameLine()
            if imgui.Button(u8'TAXI 1##3', imgui.ImVec2(80, 25)) then
                sampSendChat('/lvtaxi')
            end
            imgui.SameLine()
            if imgui.Button(u8'TAXI 2##3', imgui.ImVec2(80, 25)) then
                sampSendChat('/lvtaxi2')
            end
            imgui.Text(u8'АЛЬКАТРАС:')
            if imgui.Button(u8'ТЮРЬМА##1', imgui.ImVec2(80, 25)) then
                sampSendChat('/prison')
            end
            imgui.SameLine()
            if imgui.Button(u8'ОСТРОВ##3', imgui.ImVec2(80, 25)) then
                sampSendChat('/island')
            end
         imgui.EndChild()
     elseif acn == 6 then
         imgui.BeginChild('##6', imgui.ImVec2(785, 495), true)
            if imgui.Checkbox(u8'CHATLOG помощник', chlogh) then 
                Config.Settings.ChlogHelp = chlogh.v
                inicfg.save(Config, 'ahelp.ini')
            end
            if imgui.Checkbox(u8'DESC помощник', desch) then 
                Config.Settings.DescHelp = desch.v
                inicfg.save(Config, 'ahelp.ini')
            end
            if imgui.Checkbox(u8'JAIL помощник', jailh) then
                Config.Settings.JailHelp = jailh.v 
                inicfg.save(Config, 'ahelp.ini')
            end
            --if imgui.Checkbox(u8'Автоматический rcrime', autorc) then
               -- Config.Settings.autorcrime = autorc.v 
               -- inicfg.save(Config, 'ahelp.ini')
           -- end
            if imgui.Checkbox(u8'Репорт над головой', whrep) then
                Config.Settings.WhReport = whrep.v 
                inicfg.save(Config, 'ahelp.ini')
            end
            if imgui.Checkbox(u8'Интеграция с Screenshot.asi', screenint) then
                Config.Settings.FastScreen = screenint.v 
                inicfg.save(Config, 'ahelp.ini')
            end
            if imgui.Checkbox(u8'Автоматический скрин', proscrin) then
                Config.Settings.AutoScreen = proscrin.v 
                inicfg.save(Config, 'ahelp.ini')
            end
            if imgui.Checkbox(u8'ПКМ помощник', navigac) then
                Config.Settings.RenderNavigac = navigac.v 
                inicfg.save(Config, 'ahelp.ini')
            end
            if imgui.Checkbox(u8'Помощник под чатом', chhelp) then
                Config.Settings.chathelp = chhelp.v 
                inicfg.save(Config, 'ahelp.ini')
            end
            if imgui.Checkbox(u8'Слежка за варнингом на I (корректируется)', checkboxes.isp) then
                Config.Settings.ispec = checkboxes.isp.v 
                inicfg.save(Config, 'ahelp.ini')
            end
            if imgui.SliderFloat(u8"Настройка /banname", sliders.bnspeedslider, 0, 50) then
                    Config.Settings.BnSpeed = sliders.bnspeedslider.v
                    inicfg.save(Config, 'ahelp.ini')
            end
         imgui.EndChild()
     elseif acn == 9 then
         imgui.BeginChild('##9', imgui.ImVec2(785, 495), true)
            if imgui.CollapsingHeader(u8'Для личного использования') then
            imgui.Separator()
                imgui.Text(u8'/g — сокращение на /goto, /gh — сокращение на /gethere.\n/acolor — изменение цвета админского чата.\n/repcolor — изменение цвета репорта.\n/asetspawn — добавить точку спавна, /asetspawnoff — выключить.\n/rpm — ответ на последнее сообщение игрока в PM.\n/sk — активация и деактивация /keyinfo & /shotinfo\n/togps — ставит метку и телепортирует автоматически по ней.\n/agun — выдать себе оружие.')
            end
            imgui.Separator()
            if imgui.CollapsingHeader(u8'Помощники') then
            imgui.Separator()
                imgui.Text(u8'/avinfo — помощник по нонРП авиатранспорту. Клавиша Y выдать наказание.\n/alab — помощник по нонРП лейблам. Команда /jaillab или клавиша Y выдаёт наказание.\n/aob — помощник по нонРП объектам. Команда /jailaob или клавиша Y выдаёт наказание.')
                imgui.Text(u8'/adosk — добавить оскорбление (ГЛАВНОЕ НЕ ДОБАВЛЯЙТЕ ЗНАКИ И ПРОБЕЛ)\n/oskfind — включить поиск осков в чатлоге.')
                imgui.Text(u8'/adnick — добавить никнейм (ГЛАВНОЕ НЕ ДОБАВЛЯЙТЕ ЗНАКИ И ПРОБЕЛ)\n/nicks — включить поиск ников на сервере.')
                imgui.Text(u8'/proverka — помощник для вызова игроков на проверку.')
                imgui.Text(u8'/slet — телепорт на первый слетевший дом, /slet1, /slet2 и так далее — телепорт на последующие слетевшие дома.')
            end
            imgui.Separator()
            if imgui.CollapsingHeader(u8'Наказания') then
            imgui.Separator()
                imgui.Text(u8'С /j0 по /j17 — выдать джейл по коду, который указан цифрой(/j11 отсутствует).\n/avia — выдать джейл за нонРП авиатранспорт.')
                imgui.Text(u8'/nrpad — выдать варн за нонРП объявление.\n/kofftop и /wofftop - кикнуть/заварнить за оффтоп.\n/vadm — выдать варн за выдачу себя за админа.\n/cheat — выдать варн за признание в читах.')
                imgui.Text(u8'/adm — выдать бан за оск админа.\n/rod — выдать бан за оск родных.\n/serv — выдать бан за оск сервера.')
                imgui.Text(u8'/cdm — бан за дм как цель игры.\n/virti — бан за продажу вирт.\n/add — бан за рекламу.\n/psj — бан за псж.')
                imgui.Text(u8'/nrpcop — рпв за нонРП сотрудника ПО.\n/nrpefir — рпв за нонРП радиоэфир.\n/dmrpw — рпв за дм во фракции или семье.')
                imgui.Text(u8'/rdm — бан R за дм.\n/hrdm — бан HR за дм.\n/fg — бан за фангейм.')
                imgui.Text(u8'/rcdm — бан R за коллективный дм.\n/hrcdm — бан HR за коллективный дм.\n/rcfg — бан R за коллективный фг.\n/hrcfg — бан HR за коллективный фг.')
                imgui.Text(u8'/sh — бан за SpeedHack.\n/air — бан за AirBrake.\n/fly — бан за Fly.\n/gm — бан за GM.\n/tp — бан за Teleport.\n/gs — бан за GameSpeed.\n/surf — бан за Surf.\n/carheal — бан за CarHeal.\n/jumpcar — бан за JumpCar.\n/flipcar — бан за FlipCar.\n/antifall — бан за AntiFall.\n/carshot — бан за CarShot.\n/collision — бан за Collision.\n/brakedance — бан за BrakeDance.\n/aim — бан за AIM.')
            end
            imgui.Separator()
            if imgui.CollapsingHeader(u8'Наказания (WARS)') then
            imgui.Separator()
                imgui.Text(u8'/aimsmug — бан за аим на грузе.\n/aimconv — бан за аим на конвое.\n/aimkb — бан за аим на кб.')
                imgui.Text(u8'/dbsmug — варн за дб на грузе.\n/dbconv — варн за дб на конвое.\n/dbkb — варн за дб на кб.')
                imgui.Text(u8'/sbivsmug — варн за сбив на грузе.\n/sbivconv — варн за сбив на конвое.\n/sbivkb — варн за сбив на кб.')
                imgui.Text(u8'/afksmug — варн за афк на грузе.\n/afkconv — варн за афк на конвое.\n/afkkb — варн за афк на кб.')
                imgui.Text(u8'/offsmug — варн за офф на грузе.\n/offconv — варн за офф на конвое.\n/offkb — варн за офф на кб.')
            end
            imgui.Separator()
            if imgui.CollapsingHeader(u8'В режиме наблюдения') then
            imgui.Separator()
                imgui.Text(u8'R клавиша — помощник по наказаниям и прочим задачам.')
                imgui.Text(u8'/rr ID — телепортировать игрока на дорогу, что в реконе, что вне рекона.\n/ur — телепорт игрока на дорогу.\nКлавиша NUMPAD3 — выполняет тоже что и /ur.')
                imgui.Text(u8'/ukb — зайти в рекон за поездом контрабанды.\n/ukb2 — зайти в рекон за самолётом контрабанды.\n/rew [ДОРАБАТЫВАЕТСЯ] — зайти в рекон за игроком, на которого пришёл варнинг.\n/relvl [уровень] — заходит в рекон за игроком с указаным вами уровнем.\nПосле чего нажимаете клавишу R, на экране появятся стрелочки для перемещения между игроками с этим уровнем.')
                imgui.Text(u8'/hrnick — выдаёт блокировку HR по нику игроку, за которым вы наблюдаете\n/ufg - выдаёт бан за фангейм.\n/uams — даёт ответ игроку, за которым следите.\n/ugl — "Приятной игры" игроку, за которым следите.\n/ucheck — посмотреть статистику игрока, за которым следите.\n/uchlog — посмотреть чатлог игрока, за которым следите.\n/ubanlog — посмотреть банлист игрока, за которым следите.\n/uiseek — посмотреть iseek игрока, за которым следите.\n/uaseek — посмотреть aseek игрока, за которым следите.\n/ukick [причина] — выдаёт кик игроку, за которым следите.\n/uwarn [причина] — выдаёт варн игроку, за которым следите.\n/ujail [код] — выдаёт джейл игроку, за которым следите.\n/uban [категория] [причина] — выдаёт бан игроку, за которым следите.')
                imgui.Text(u8'/ush — выдаёт блокировку C категории за SpeedHack игроку, за которым вы наблюдаете.\n/uair — выдаёт блокировку C категории за AirBrake игроку, за которым вы наблюдаете.\n/ufly — выдаёт блокировку C категории за Fly игроку, за которым вы наблюдаете.\n/ugm — выдаёт блокировку C категории за GM игроку, за которым вы наблюдаете.\n/ugs — выдаёт блокировку C категории за GameSpeed игроку, за которым вы наблюдаете.\n/utp — выдаёт блокировку C категории за Teleport игроку, за которым вы наблюдаете.\n/uantifall — выдаёт блокировку C категории за AntiFall игроку, за которым вы наблюдаете.\n/ujumpcar — выдаёт блокировку C категории за JumpCar игроку, за которым вы наблюдаете.\n/uflipcar — выдаёт блокировку C категории за FlipCar игроку, за которым вы наблюдаете.\n/usurf — выдаёт блокировку C категории за Surf игроку, за которым вы наблюдаете.\n/ucarshot — выдаёт блокировку C категории за CarShot игроку, за которым вы наблюдаете.')
                imgui.Text(u8'/uaim — выдаёт блокировку HC категории за AIM игроку, за которым вы наблюдаете.\n/uclicker — выдаёт блокировку HC категории за AutoClicker игроку, за которым вы наблюдаете.\n/urvanka — выдаёт блокировку HC категории за Rvanka игроку, за которым вы наблюдаете.')
            end
            imgui.Separator()
            if imgui.CollapsingHeader(u8'В режиме наблюдения (OFFLINE)') then
            imgui.Separator()
                imgui.Text(u8'/livban [категория] [причина]. Банит в оффлайне того, за кем следили перед его выходом.\n/livwarn [причина]. Варнит в оффлайне того, за кем следили перед его выходом.\n/livnick — выдаёт блокировку HR по нику игроку, за которым вы следили в момент его выхода.\n/livabanc — оставляет анонимный комментарий игроку, который вышел из игры в момент вашей слежки за ним.')
                imgui.Text(u8'/livcheck — открывает статистику игрока, за которым вы следили в момент его выхода.\n/livbanlog — открывает банлог игрока, за которым вы следили в момент его выхода.\n/liviseek — открывает ipseek игрока, за которым вы следили в момент его выхода.\n/livaseek — открывает aseek игрока, за которым вы следили в момент его выхода.')
            end
            imgui.Separator()
            if imgui.CollapsingHeader(u8'Ответы (макросы)') then
            imgui.Separator()
                imgui.Text(u8'/jj — ответить игроку "Джейл".\n/bb — ответить игроку "Бан".\n/mm — ответить игроку "Мут".\n/ww — ответить игроку "Варн".\n/kk — ответить игроку "Кик".')
                imgui.Text(u8'/rules — ответить игроку, что нарушение правил в его адрес, не даёт ему права нарушать в ответ.\n/pred — ответить игроку, что обидчик предупреждён и будет наказан при повторном нарушении.\n/nopred — ответить, что нет нарушений от игрока.\n/predosk — предупреждение за оскорбления.\n/predmg — предупреждение за MG.\n/predcaps — предупреждение за CAPS.\n/predoff — предупреждение за offtop.\n/predsmug — предупреждение о помехе на грузе.\n/predconv — предупреждение о помехе на конвое')
                imgui.Text(u8'/prod — ответить игроку за "IC оск род".\n/posk — ответить игроку за "IC оски".\n/idn — ответить "ID - нарушение".\n/off — ответить "Игрок offline".\n/spec — ответить "Слежу".\n/gl — ответить "Приятной игры".\n/pmadm — ответить "Пишите в /pm".\n/ask — ответить "Пишите в /ask".\n/nick — ответить "Ожидайте смены".')
            end
            imgui.Separator()
            if imgui.CollapsingHeader(u8'Быстрое реагирование на репорты') then
            imgui.Separator()
                imgui.Text(u8'Клавиша F11 — прописывает /reent на последний репорт.\nКлавиша F12 — прописывает /relift на последний репорт.')
                imgui.Text(u8'/lams — дать анонимный ответ на последний репорт.\n/lamsx — дать ответ на последний репорт с вашим ником.')
                imgui.Text(u8'/lpsj — бан псж.\n/lrod — бан за оск род.\n/ladm — бан за оск адм.')
                imgui.Text(u8'/lu, /lre & /ltv — зайти в рекон.\n/ldhist — посмотреть дхист.\n/lchlog — посмотреть чатлог.')
                imgui.Text(u8'/lspec — ответить игроку "Слежу".\n/lj — ответить игроку "Джейл".\n/lb — ответить игроку "Бан".\n/lm — ответить игроку "Мут".\n/lw — ответить игроку "Варн".\n/lk — ответить игроку "Кик".')
                imgui.Text(u8'/lrules — ответить игроку, что нарушение правил в его адрес, не даёт ему права нарушать в ответ.\n/lpred — ответить игроку, что обидчик предупреждён и будет наказан при повторном нарушении.\n/lnopred — ответить, что нет нарушений от игрока.')
                imgui.Text(u8'/lprod — ответить игроку за "IC оск род".\n/lposk — ответить игроку за "IC оски".\n/lidn — ответить "ID - нарушение".\n/loff — ответить "Игрок offline".\n/lspec — ответить "Слежу".\n/lgl — ответить "Приятной игры".\n/lpmadm — ответить "Пишите в /pm".\n/lask — ответить "Пишите в /ask".\n/lnick — ответить "Ожидайте смены".')
            end
            imgui.Separator()
            if imgui.CollapsingHeader(u8'FAQ jail за нонРП убийство') then
            imgui.Separator()
                imgui.Text(u8'В чат приходит оповещение о умышленном убийстве:\nНажимаете ALT + Y — открывается dhist\nНажимаете ALT + U — открывается chlog убийцы\nНажимаете ALT + I — открывается chlog жертвы\nПосле репорта нажимаете — Y')
            end
            imgui.Separator()
            imgui.Text(u8'Автор   — ')
            imgui.SameLine()
            imgui.Link('vk.com/usenkomax', u8'Maxim Usenko')
            imgui.SameLine()
            imgui.TextQuestion('?', u8' Не пиши — убьёт! ')
            imgui.Text(u8'Попросить обновление   — ')
            imgui.SameLine()
            imgui.Link('vk.com/usenkomax', u8'ТУТ')
            imgui.Text(u8'По поводу багов   — ')
            imgui.SameLine()
            imgui.Link('vk.com/usenkomax', u8'СЮДА')
            imgui.Text(u8'Версия 4.8. Последнее обновление 27.06.25')
            imgui.SameLine()
            imgui.TextQuestion('!', u8'Актуальная версия.')
            imgui.Separator()
            if imgui.CollapsingHeader(u8'Обновление') then
                imgui.Text(u8'x version 4.5 \n— Полностью исправлена и доработана автоматическая слежка за варами.\nТеперь работает только в случае, когда включена соответствующая настройка.\n— Убрал из автоматического режима слежку за смугом, т.к. в большинстве случаев оно кидает просто за левым игроком.\n— Была ошибка с /urvanka, функция не срабатывала.\nОшибку исправил, сейчас все работает.\n— Полностью удалена система RegColor вместе с командой /regcolor.\n— Добавлена новая система новорегов, которая более корректно работает.\n— Добавлены метки в объявлениях "Проверено" и "Исправлено", теперь они будут отображаться красным и зелеными цветами.\n— Исправил большую часть критических ошибок, которые иногда могли ломать скрипт и ложить его.\n— Добавлена тестовая функция с автоматическим телепортом на слетевший дом, но пока она недоступна вам.\nПотестирую, потом выкачу её вам, если она всё-таки нужна будет.')
                imgui.Text(u8'x version 4.6 \n— Добавлена система "Автоматическое реагирование на слёты".\n— Теперь при включённой функции вас будет телепортировать на первый слетевший дом.\n— Командами /slet1, /slet2, /slet3 и так далее, вы сможете телепортироваться на последующие дома.\n— В случае, если функция не была включена и вы хотите телепортироваться на первый слетевший дом, используйте /slet.')  
                imgui.Text(u8'x version 4.7 \n— Добавлена система "[ROAD] — Телепорт на дорогу.\n— Команда /rr ID — телепортирует игрока на дорогу, что в реконе, что вне рекона.\n— Команда /ur — телепортирует игрока в реконе.\n— В меню рекона добавлена клавиша "ROAD", которая выполняет функцию команды /ur.\n— Добавил бинд на /ur на клавишу NUMPAD3, кому будет мешать - отпишите, оффну у вас его.')                  
                imgui.Text(u8'x version 4.8 \n— Переезд на новые хостинги, исправление некоторых ошибок.')                  
            end
            imgui.Separator()
         imgui.EndChild()
     elseif acn == 7 then
        imgui.BeginChild('##7', imgui.ImVec2(785, 495), true)
        imgui.Image(skinpng[myskin], imgui.ImVec2(120, 135))
        imgui.SameLine()
        imgui.TextColoredRGB(clientName..' ['..sampGetPlayerIdByNickname(clientName)..']')
        if imgui.Button(u8'Изменить скин', imgui.ImVec2(200, 20)) then
            acn = 2
        end
        if imgui.Button(u8'/feedme', imgui.ImVec2(200, 20)) then
            sampSendChat('/feedme')
        end
        if imgui.Combo(u8'Стиль боя', combos.fscombo, arrs.arr_fs, #arrs.arr_fs) then
            Config.Settings.myFs = combos.fscombo.v
            inicfg.save(Config, 'ahelp.ini')
            sampSendChat('/myfs '..combos.fscombo.v)
        end
        imgui.SameLine()
        if imgui.Button(u8'Обновить##1') then
            sampSendChat('/myfs '..combos.fscombo.v)
        end
        if imgui.Combo(u8'Город проживания', combos.stcombo, arrs.arr_st, #arrs.arr_st) then
            Config.Settings.mySt = combos.stcombo.v
            inicfg.save(Config, 'ahelp.ini')
            sampSendChat('/myst '..combos.stcombo.v)
        end
        imgui.EndChild()
     end
     imgui.End()
  end
  
  if win.rlogwin.v then
    local sw, sh = getScreenResolution()
    imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(575, 460), imgui.Cond.FirstUseEver)
    imgui.Begin(u8'Лог репортов')
    imgui.End()
  end

  if win.reportwin.v and Config.Settings.chathelp then
    local sw, sh = getScreenResolution()
    imgui.SetNextWindowPos(imgui.ImVec2(Config.Window.RepX, Config.Window.RepY), imgui.Cond.FirstUseEver)
    imgui.SetNextWindowSize(imgui.ImVec2(600, 60), imgui.Cond.FirstUseEver)
    imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.48, 0.48, 0.48, 0))
    imgui.Begin('ded inside228', imgui.ImVec2(1, 1), imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
    if check2.v then
        imgui.Text(u8'Репорты отключены.')
    else
        if nickj2 and idj2 and report then
            imgui.Text(idj2..':')
            imgui.SameLine()
            if imgui.Button(u8'REENT') then
                    sampSendChat('/reent '..idj2)
            end
            imgui.SameLine()
            if imgui.Button(u8'SPEC') then
                sampSendChat('/re '..idj2)
                specstat = true
                idspec = idj2
                nicknamespec = sampGetPlayerNickname(idspec)
            end
            imgui.SameLine()
            if imgui.Button(u8'DHIST') then
                sampSendChat('/dhist '..idj2)
                specstat = true
                idspec = idj2
                nicknamespec = sampGetPlayerNickname(idspec)
            end
        else
            imgui.TextColored(imgui.ImVec4(72, 130, 40, 1), u8'Репортов не было.')
            imgui.SameLine()
            imgui.TextColored(imgui.ImVec4(72, 130, 40, 1), u8'Нажмите на кнопку чтобы сохранить позицию окна.')
            local size = imgui.ImVec2(400, 60)
        end
    end
    imgui.SameLine()
    if idwinrep then
        imgui.Text(idwinrep..':')
        imgui.SameLine()
        if imgui.Button(u8'SPEC##2') then
            sampSendChat('/re '..idwinrep)
            specstat = true
            idspec = idwinrep
            nicknamespec = sampGetPlayerNickname(idspec)
        end
        imgui.SameLine()
        if imgui.Button('CHLOG') then
                sampSendChat('/chlog '..idwinrep)
        end
        imgui.SameLine()
        if imgui.Button('GD') then
            sampSendChat('/gd '..idwinrep)
            idd = idwinrep
        end
        imgui.SameLine()
        if imgui.Button('DHIST##2') then
            sampSendChat('/dhist '..idwinrep)
        end
        imgui.SameLine()
        if imgui.Button('AD') then
          if tonumber(idwinrep) then
            if sampIsPlayerConnected(idwinrep) then
              nickname = sampGetPlayerNickname(tonumber(idwinrep))
              idad = tonumber(idwinrep)
              sampAddChatMessage(tag..'ID {e08989}'..idwinrep..'{ffffff} добавлен в AD.')
            end
          end   
        end
    end
    imgui.SameLine()
    if imgui.Button(fa.ICON_ARROWS .. '##228 ') then
        local pos = imgui.GetWindowPos()
        Config.Window.RepX = pos.x
        Config.Window.RepY = pos.y
        inicfg.save(Config, 'ahelp.ini')
    end
    imgui.End()
    imgui.PopStyleColor(1)
  else
    themes1(Config.Settings.Theme) 
  end

  if win.carclickwin.v then
     local sw, sh = getScreenResolution()
     imgui.SetNextWindowPos(imgui.ImVec2(sx+20, sy), imgui.ImVec2(0.5, 0.5))
     imgui.SetNextWindowSize(imgui.ImVec2(200, 200), imgui.Cond.FirstUseEver)
     imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.48, 0.48, 0.48, 0))
     imgui.Begin('##carclickwin', imgui.ImVec2(1, 1), imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
     if imgui.Button(u8'respawncar') then
        sampSendChat('/respawnid '..carid)
        win.carclickwin.v = false
        imgui.Process = false
     end
     if imgui.Button(u8'teleports') then
        local mycx, mycz, mycy = getCharCoordinates(playerPed)
        jumpIntoCar(jumpcarclick)
        teleportPlayer(mycx, mycz, mycy)
        win.carclickwin.v = false
        imgui.Process = false
     end
     if imgui.Button(u8'closed') then
        win.carclickwin.v = false
        imgui.Process = false
     end
     imgui.End()
     imgui.PopStyleColor(1)
  end

  if win.deadwind.v then
        local sw, sh = getScreenResolution()
        imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 1.7), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(300, 50), imgui.Cond.FirstUseEver)
        imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.48, 0.48, 0.48, 0))
        imgui.Begin('ded inside', imgui.ImVec2(1, 1), imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
        if imgui.Button(u8'Поднятие со стадии', imgui.ImVec2(270, 35)) then 
           local result, my2id = sampGetPlayerIdByCharHandle(PLAYER_PED)
           sampSendChat('/und '..my2id)
           win.deadwind.v = false
           imgui.Process = false
        end
        imgui.End()
        imgui.PopStyleColor(1)
  end
  if desc and not specstat and not win.main2.v then
    if win.descwind.v then
        local sw, sh = getScreenResolution()
        imgui.SetNextWindowPos(imgui.ImVec2(Config.Window.GdX, Config.Window.GdY), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowSize(imgui.ImVec2(280, 210), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Desc ID - '..idd, imgui.ImVec2(1, 1), imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
        imgui.Text(u8'Desc ID - '..idd)
        imgui.SameLine(200)
        if imgui.Button(u8'Закрепить') then
            local pos = imgui.GetWindowPos()
            Config.Window.GdX = pos.x
            Config.Window.GdY = pos.y
            inicfg.save(Config, 'ahelp.ini')
            sampAddChatMessage(tag..'Положение окна сохранено.',-1)
        end
        if imgui.Button(u8'Очистить описание', imgui.ImVec2(260, 25)) then
            sampSendChat('/cdesc '..idd)
            if Config.Settings.FastScreen then
                    screenshot.requestEx('example', sampGetPlayerNickname(idd)..'_'..vremya..'_'..data)
            else
                    makeScreenshot()
            end
        end
        if imgui.Button(u8'Очистить подробное описание', imgui.ImVec2(260, 25)) then
            sampSendChat('/clearextradesc '..idd)
            if Config.Settings.FastScreen then
                    screenshot.requestEx('example', sampGetPlayerNickname(idd)..'_'..vremya..'_'..data)
            else
                    makeScreenshot()
            end
        end
        if imgui.Button(u8'Посадить за нрп описание', imgui.ImVec2(260, 25)) then 
            sampSendChat('/jail '..idd..' 2')
            if Config.Settings.FastScreen then
                    screenshot.requestEx('example', sampGetPlayerNickname(idd)..'_'..vremya..'_'..data)
            else
                    makeScreenshot()
            end
        end
        if imgui.Button(u8'Напоминание в ames', imgui.ImVec2(260, 25)) then 
            sampSendChat('/ames '..idd..' В /mm 3 > описание - пишется только описание внешности персонажа.')
        end
        if imgui.Button(u8'<', imgui.ImVec2(125, 25)) then 
            sampSendChat('/gd '..idd-1)
            idd = idd-1
            prewd = true
            nextd = false
        end
        imgui.SameLine()
        if imgui.Button(u8'>', imgui.ImVec2(125, 25)) then 
            sampSendChat('/gd '..idd+1)
            idd = idd+1
            nextd = true
            prewd = false
        end
        imgui.End()
    end
  end
  if fractspec then
    if win.fractspecwin and win.second_window_state.v then
        local sw, sh = getScreenResolution()
        imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 1.25), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(300, 75), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Слежка за фракцией')
        if imgui.Button('<', imgui.ImVec2(125, 30)) then
            if kodspec ~= 1 then
                kodspec = kodspec-1
                idspec = arrs.idfractspec[kodspec]
            else
                kodspec = #arrs.idfractspec
                idspec = arrs.idfractspec[kodspec]
            end
            specstat = true
            sampSendChat('/re '..idspec)
        end
        imgui.SameLine()
        if imgui.Button('>', imgui.ImVec2(125, 30)) then
            if kodspec ~= #arrs.idfractspec then
                kodspec = kodspec+1
                idspec = arrs.idfractspec[kodspec]
            else
                kodspec = 1
                idspec = arrs.idfractspec[kodspec]
            end
            specstat = true
            sampSendChat('/re '..idspec)
        end
        imgui.End()
    end
  end
  if relvl then
    if win.second_window_state.v then
        local sw, sh = getScreenResolution()
        imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 1.25), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(300, 75), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Слежка за LVL - '..lvlre)
        if imgui.Button('<', imgui.ImVec2(130, 30)) then
          if idspec == 0 then
                local onMaxId = sampGetMaxPlayerId(false)
                if not sampIsPlayerConnected(onMaxId) or sampGetPlayerScore(onMaxId) == 0 then 
                    for i = sampGetMaxPlayerId(false), 0, -1 do
                        if sampIsPlayerConnected(i) and sampGetPlayerScore(i) == tonumber(lvlre) and i ~= idspec then
                            idspec = i
                            sampSendChat('/re '..idspec)
                            break
                        end
                    end
                else 
                    sampSendChat('/re '..sampGetMaxPlayerId(false))
                    idspec = sampGetMaxPlayerId(false)
                end
          else 
                for i = idspec, 0, -1 do
                    if sampIsPlayerConnected(i) and sampGetPlayerScore(i) == tonumber(lvlre) and sampGetPlayerColor(i) ~= 16510045 and i ~= idspec then
                        sampSendChat('/re '..i)
                        idspec = i
                        break
                    end
                end
          end
        end
        imgui.SameLine()
        if imgui.Button('>', imgui.ImVec2(130, 30)) then
           if idspec == sampGetMaxPlayerId(false) then
                local maxid = sampGetMaxPlayerId(false)
                if not sampIsPlayerConnected(0) then
                    for i = idspec, sampGetMaxPlayerId(false) do 
                        
                        if sampIsPlayerConnected(i) and i ~= idspec and sampGetPlayerScore(i) == tonumber(lvlre) then
                            idspec = i
                            sampSendChat('/re '..i)
                            break
                        else
                            if i == maxid then
                                i = 0
                            end
                        end
                    end
                else
                    sampSendChat('/re 0')
                    idspec = 0
                end 
            else 
                for i = idspec, sampGetMaxPlayerId(false) do 
                    if sampIsPlayerConnected(i) and sampGetPlayerScore(i) == tonumber(lvlre) and i ~= idspec then
                        idspec = i
                        sampSendChat('/re '..i)
                        break
                    end
                    if i == maxid then
                        idspec = i
                    end
                end
            end
        end
        imgui.End()
    end
  end
  if chlog and not desc and Config.Settings.ChlogHelp then
      if win.mutetime.v then
        local sw, sh = getScreenResolution()
        imgui.SetNextWindowPos(imgui.ImVec2(Config.Window.ChlX, Config.Window.ChlY), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowSize(imgui.ImVec2(300, 120), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Время мута')
         if imgui.Button(u8'Вернуться', imgui.ImVec2(270, 25)) then
              win.mutetime.v = false
              win.chlogwind.v = true
         end
        if sampIsPlayerConnected(idch) then
            if imgui.Button(u8'5 мин') then
                sampSendChat('/mute '..idch..' 5 '..prich)
                if Config.Settings.FastScreen then
                        screenshot.requestEx('example', sampGetPlayerNickname(idch)..'_'..vremya..'_'..data)
                else
                        makeScreenshot()
                end
            end
            imgui.SameLine()
            if imgui.Button(u8'10 мин') then
                sampSendChat('/mute '..idch..' 10 '..prich)
                if Config.Settings.FastScreen then
                        screenshot.requestEx('example', sampGetPlayerNickname(idch)..'_'..vremya..'_'..data)
                else
                        makeScreenshot()
                end
            end
            imgui.SameLine()
            if imgui.Button(u8'15 мин') then
                sampSendChat('/mute '..idch..' 15 '..prich)
                if Config.Settings.FastScreen then
                        screenshot.requestEx('example', sampGetPlayerNickname(idch)..'_'..vremya..'_'..data)
                else
                        makeScreenshot()
                end
            end
        else
            imgui.Text('Player offline')
        end
        imgui.End()
      end
      

      if win.chlogwind.v and Config.Settings.ChlogHelp then
            local sw, sh = getScreenResolution()
            imgui.SetNextWindowPos(imgui.ImVec2(Config.Window.ChlX, Config.Window.ChlY), imgui.Cond.FirstUseEver)
            imgui.SetNextWindowSize(imgui.ImVec2(290, 310), imgui.Cond.FirstUseEver)
            imgui.Begin(u8'Наказания чата ID - ', imgui.ImVec2(1, 1), imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
            if sampIsPlayerConnected(idch) then
                imgui.Text(u8'Наказания чата ID - '..idch)
                imgui.SameLine()
                if imgui.Button(u8'Закрепить') then
                    local pos = imgui.GetWindowPos()
                    Config.Window.ChlX = pos.x
                    Config.Window.ChlY = pos.y
                    inicfg.save(Config, 'ahelp.ini')
                    sampAddChatMessage(tag..'Положение окна сохранено.',-1)
                end
                if imgui.Button(u8'OSK', imgui.ImVec2(60, 20)) then
                  win.mutetime.v = true
                  win.chlogwind.v = false
                  prich = 'ooc osk'
                end
                imgui.SameLine()
                if imgui.Button(u8'MG', imgui.ImVec2(60, 20)) then
                  win.mutetime.v = true
                  win.chlogwind.v = false
                  prich = 'MG'
                end
                imgui.SameLine()
                if imgui.Button(u8'CAPS', imgui.ImVec2(60, 20)) then
                  win.mutetime.v = true
                  win.chlogwind.v = false
                  prich = 'caps'
                end
                imgui.SameLine()
                if imgui.Button(u8'FLOOD', imgui.ImVec2(60, 20)) then
                  win.mutetime.v = true
                  win.chlogwind.v = false
                  prich = 'flood'
                end
                if imgui.Button(u8'OSK ADM', imgui.ImVec2(60, 20)) then
                  sampSendChat('/ban '..idch..' R osk adm')
                  if Config.Settings.FastScreen then
                        screenshot.requestEx('example', sampGetPlayerNickname(idch)..'_'..vremya..'_'..data)
                  else
                        makeScreenshot()
                  end
                end
                imgui.SameLine()
                if imgui.Button(u8'OSK ROD', imgui.ImVec2(60, 20)) then
                  sampSendChat('/ban '..idch..' R osk rod')
                  if Config.Settings.FastScreen then
                        screenshot.requestEx('example', sampGetPlayerNickname(idch)..'_'..vremya..'_'..data)
                  else
                        makeScreenshot()
                  end
                end
                imgui.SameLine()
                if imgui.Button(u8'OSK SERV', imgui.ImVec2(60, 20)) then
                  sampSendChat('/ban '..idch..' R osk project')
                  if Config.Settings.FastScreen then
                        screenshot.requestEx('example', sampGetPlayerNickname(idch)..'_'..vremya..'_'..data)
                  else
                        makeScreenshot()
                  end
                end
                imgui.SameLine()
                if imgui.Button(u8'МЕЖНАЦ', imgui.ImVec2(60, 20)) then
                  sampSendChat('/ban '..idch..' R Межнациональная рознь')
                  if Config.Settings.FastScreen then
                        screenshot.requestEx('example', sampGetPlayerNickname(idch)..'_'..vremya..'_'..data)
                  else
                        makeScreenshot()
                  end
                end
                if imgui.Button(u8'Злоуп. чатами', imgui.ImVec2(130, 20)) then
                  sampSendChat('/jail '..idch..' 3')
                  if Config.Settings.FastScreen then
                        screenshot.requestEx('example', sampGetPlayerNickname(idch)..'_'..vremya..'_'..data)
                  else
                        makeScreenshot()
                  end
                end
                imgui.SameLine()
                if imgui.Button(u8'Церковь/Библиотека', imgui.ImVec2(130, 20)) then
                  sampSendChat('/jail '..idch..' 6')
                  if Config.Settings.FastScreen then
                        screenshot.requestEx('example', sampGetPlayerNickname(idch)..'_'..vremya..'_'..data)
                  else
                        makeScreenshot()
                  end
                end
                if imgui.Button(u8'НРП вызов скорой', imgui.ImVec2(130, 20)) then
                  sampSendChat('/jail '..idch..' 15')
                  if Config.Settings.FastScreen then
                        screenshot.requestEx('example', sampGetPlayerNickname(idch)..'_'..vremya..'_'..data)
                  else
                        makeScreenshot()
                  end
                end
                imgui.SameLine()
                if imgui.Button(u8'Провокация ПО', imgui.ImVec2(130, 20)) then
                  sampSendChat('/jail '..idch..' 8')
                  if Config.Settings.FastScreen then
                        screenshot.requestEx('example', sampGetPlayerNickname(idch)..'_'..vremya..'_'..data)
                  else
                        makeScreenshot()
                  end
                end
                if imgui.Button(u8'WARN Многоч. оски', imgui.ImVec2(130, 20)) then
                  sampSendChat('/warn '..idch..' Многоч. оски')
                  if Config.Settings.FastScreen then
                        screenshot.requestEx('example', sampGetPlayerNickname(idch)..'_'..vremya..'_'..data)
                  else
                        makeScreenshot()
                  end
                end
                imgui.SameLine()
                if imgui.Button(u8'RBAN Многоч. оски', imgui.ImVec2(130, 20)) then
                  sampSendChat('/ban '..idch..' R Многоч. оски')
                  if Config.Settings.FastScreen then
                        screenshot.requestEx('example', sampGetPlayerNickname(idch)..'_'..vremya..'_'..data)
                  else
                        makeScreenshot()
                  end
                end
                if imgui.Button(u8'WARN Обман', imgui.ImVec2(84, 20)) then
                  sampSendChat('/warn '..idch..' обман')
                  if Config.Settings.FastScreen then
                        screenshot.requestEx('example', sampGetPlayerNickname(idch)..'_'..vremya..'_'..data)
                  else
                        makeScreenshot()
                  end
                end
                imgui.SameLine()
                if imgui.Button(u8'R Обман', imgui.ImVec2(83, 20)) then
                  sampSendChat('/ban '..idch..' r мошенничество')
                  if Config.Settings.FastScreen then
                        screenshot.requestEx('example', sampGetPlayerNickname(idch)..'_'..vremya..'_'..data)
                  else
                        makeScreenshot()
                  end
                end
                imgui.SameLine()
                if imgui.Button(u8'HR Обман', imgui.ImVec2(83, 20)) then
                  sampSendChat('/ban '..idch..' hr мошенничество')
                  if Config.Settings.FastScreen then
                        screenshot.requestEx('example', sampGetPlayerNickname(idch)..'_'..vremya..'_'..data)
                  else
                        makeScreenshot()
                  end
                end
                if imgui.Button(u8'FG', imgui.ImVec2(30, 20)) then
                  sampSendChat('/ban '..idch..' r fg')
                  if Config.Settings.FastScreen then
                        screenshot.requestEx('example', sampGetPlayerNickname(idch)..'_'..vremya..'_'..data)
                  else
                        makeScreenshot()
                  end
                end
                imgui.SameLine()
                if imgui.Button(u8'/SU', imgui.ImVec2(30, 20)) then
                  sampSendChat('/ban '..idch..' hr Злоупотребление /su')
                  if Config.Settings.FastScreen then
                        screenshot.requestEx('example', sampGetPlayerNickname(idch)..'_'..vremya..'_'..data)
                  else
                        makeScreenshot()
                  end
                end
                imgui.SameLine()
                if imgui.Button(u8'AD', imgui.ImVec2(30, 20)) then
                  sampSendChat('/ban '..idch..' hr ad')
                  if Config.Settings.FastScreen then
                        screenshot.requestEx('example', sampGetPlayerNickname(idch)..'_'..vremya..'_'..data)
                  else
                        makeScreenshot()
                  end
                end
                imgui.SameLine()
                if imgui.Button(u8'RCRIME', imgui.ImVec2(50, 20)) then
                  sampSendChat('/ban '..idch..' r репорт после просьбы убить')
                  if Config.Settings.FastScreen then
                        screenshot.requestEx('example', sampGetPlayerNickname(idch)..'_'..vremya..'_'..data)
                  else
                        makeScreenshot()
                  end
                end
                imgui.SameLine()
                if imgui.Button(u8'ДМ цель игры', imgui.ImVec2(90, 20)) then
                  sampSendChat('/ban '..idch..' r дм как цель игры')
                  if Config.Settings.FastScreen then
                        screenshot.requestEx('example', sampGetPlayerNickname(idch)..'_'..vremya..'_'..data)
                  else
                        makeScreenshot()
                  end
                end
                if imgui.Button(u8'Выдача за админа', imgui.ImVec2(130, 20)) then
                  sampSendChat('/warn '..idch..' Выдача себя за администратора')
                  if Config.Settings.FastScreen then
                        screenshot.requestEx('example', sampGetPlayerNickname(idch)..'_'..vremya..'_'..data)
                  else
                        makeScreenshot()
                  end
                end
                imgui.SameLine()
                if imgui.Button(u8'Признание в читах', imgui.ImVec2(130, 20)) then
                  sampSendChat('/warn '..idch..' Признание в использовании читов')
                  if Config.Settings.FastScreen then
                        screenshot.requestEx('example', sampGetPlayerNickname(idch)..'_'..vremya..'_'..data)
                  else
                        makeScreenshot()
                  end
                end
                if imgui.Button(u8'SPEC', imgui.ImVec2(60, 20)) then
                  spec(idch)
                end
                imgui.SameLine()
                if imgui.Button(u8'DHIST', imgui.ImVec2(60, 20)) then
                  sampSendChat('/dhist '..idch)
                end 
                imgui.SameLine()
                if imgui.Button(u8'UPDATE CHATLOG', imgui.ImVec2(130, 20)) then
                  sampSendChat('/chlog '..idch)
                end 
            else
                imgui.Text('PLAYER OFFLINE')
            end
            imgui.End()
      end
  end
  if specstat then
      if win.nakazwind.v then 
        local sw, sh = getScreenResolution()
        imgui.SetNextWindowPos(imgui.ImVec2(sw / 22, sh / 1.70), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetWindowSize(imgui.ImVec2(298, 140))
        imgui.Begin('1', imgui.ImVec2(1, 1), imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
        imgui.Text(fa.ICON_EYE .. u8' Наказания для - '..nicknamespec..' ['..idspec..']')
        imgui.SameLine()
        if imgui.Button(u8'<>') then
          acnn = 0
          imgui.SetWindowSize(imgui.ImVec2(298, 140))
        end
        if imgui.Button(u8'JAIL', imgui.ImVec2(135, 20)) then
          acnn = 1
          imgui.SetWindowSize(imgui.ImVec2(298, 325))
        end
        imgui.SameLine()
        if imgui.Button(u8'BAN', imgui.ImVec2(135, 20)) then
            acnn = 2
            imgui.SetWindowSize(imgui.ImVec2(298, 325))
            acnbans = 1
        end
        if imgui.Button(u8'KICK', imgui.ImVec2(135, 20)) then
            acnn = 3
            imgui.SetWindowSize(imgui.ImVec2(298, 325))
        end
        imgui.SameLine()
        if imgui.Button(u8'WARN', imgui.ImVec2(135, 20)) then
            acnn = 4
            imgui.SetWindowSize(imgui.ImVec2(298, 325))
        end
        if imgui.Button(u8'WARS', imgui.ImVec2(135, 20)) then
            acnn = 5
            acnnn = 0
            imgui.SetWindowSize(imgui.ImVec2(298, 325))
        end
        imgui.SameLine()
        if imgui.Button(u8'EVENTS', imgui.ImVec2(135, 20)) then
            acnn = 6
            acnnn = 0
            imgui.SetWindowSize(imgui.ImVec2(298, 325))
        end
        if imgui.Button(u8'', imgui.ImVec2(278, 3)) then
           acnn = 0
           imgui.SetWindowSize(imgui.ImVec2(298, 140))
        end
        if acnn == 1 then
        imgui.BeginChild('##jails', imgui.ImVec2(300, 180), false)
            if imgui.Button(u8'НРП нападение', imgui.ImVec2(135, 20)) then
              sampSendChat('/jail '..idspec..' 0')
            end
            imgui.SameLine()
            if imgui.Button(u8'НРП описание', imgui.ImVec2(135, 20)) then
              sampSendChat('/jail '..idspec..' 2')
            end
            if imgui.Button(u8'Злоуп. чатами', imgui.ImVec2(135, 20)) then
              sampSendChat('/jail '..idspec..' 3')
            end
            imgui.SameLine()
            if imgui.Button(u8'Помеха smugs', imgui.ImVec2(135, 20)) then
              sampSendChat('/jail '..idspec..' 4')
            end
            if imgui.Button(u8'Помеха РП', imgui.ImVec2(135, 20)) then
              sampSendChat('/jail '..idspec..' 9')
            end
            imgui.SameLine()
            if imgui.Button(u8'Помеха работе', imgui.ImVec2(135, 20)) then
              sampSendChat('/jail '..idspec..' 10')
            end
            if imgui.Button(u8'ДБ', imgui.ImVec2(135, 20)) then
              sampSendChat('/jail '..idspec..' 12')
            end
            imgui.SameLine()
            if imgui.Button(u8'НРП конвой', imgui.ImVec2(135, 20)) then
              sampSendChat('/jail '..idspec..' 14')
            end
            if imgui.Button(u8'НРП вождение', imgui.ImVec2(135, 20)) then
              sampSendChat('/jail '..idspec..' 7')
            end
            imgui.SameLine()
            if imgui.Button(u8'Функции ПО', imgui.ImVec2(135, 20)) then
              sampSendChat('/jail '..idspec..' 17')
            end
        imgui.EndChild()
        elseif acnn == 2 then
          imgui.BeginChild('##bans', imgui.ImVec2(300, 180), false)
              if acnbans == 1 then
                  if imgui.Button(u8'Баны категории HC', imgui.ImVec2(280, 20)) then
                    acnbans = 2
                  end
                  if imgui.Button(u8'C - SH', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' C sh')
                  end
                    imgui.SameLine()
                  if imgui.Button(u8'C - AIR', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' C air')
                  end
                  if imgui.Button(u8'C - GM', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' C gm')
                  end
                    imgui.SameLine()
                  if imgui.Button(u8'C - FLY', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' C fly')
                  end
                  if imgui.Button(u8'C - ANTIFALL', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' c antifall')
                  end
                  imgui.SameLine()
                  if imgui.Button(u8'C - TP', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' C tp')
                  end
                  if imgui.Button(u8'C - COLLISION', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' c collision')
                  end
                  imgui.SameLine()
                  if imgui.Button(u8'R - FG', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' r fg')
                  end
                  if imgui.Button(u8'HC - RVANKA', imgui.ImVec2(135, 20)) then
                    sampSendChat('/aban '..idspec..' hc rvanka')
                  end
                  imgui.SameLine()
                  if imgui.Button(u8'ЧС - NICK', imgui.ImVec2(135, 20)) then
                    sampSendChat('/aban '..idspec..' HR '..nicknamespec..'')
                  end
              elseif acnbans == 2 then
                if imgui.Button(u8'<< ОБРАТНО <<', imgui.ImVec2(280, 20)) then
                    acnbans = 1
                end
                if imgui.Button(u8'оператор', imgui.ImVec2(135, 20)) then
                    hcreason = ' // оператор'
                    acnbans = 3
                end
                imgui.SameLine()
                if imgui.Button(u8'подрывник', imgui.ImVec2(135, 20)) then
                    hcreason = ' // подрывник'
                    acnbans = 3
                end
                if imgui.Button(u8'фермер', imgui.ImVec2(135, 20)) then
                    hcreason = ' // фермер'
                    acnbans = 3
                end
                imgui.SameLine()
                if imgui.Button(u8'альпинист', imgui.ImVec2(135, 20)) then
                    hcreason = ' // альпинист'
                    acnbans = 3
                end
                if imgui.Button(u8'рыболов', imgui.ImVec2(135, 20)) then
                    hcreason = ' // рыболов'
                    acnbans = 3
                end
                imgui.SameLine()
                if imgui.Button(u8'грабитель', imgui.ImVec2(135, 20)) then
                    hcreason = ' // грабитель'
                    acnbans = 3
                end
                if imgui.Button(u8'лесоруб', imgui.ImVec2(135, 20)) then
                    hcreason = ' // лесоруб'
                    acnbans = 3
                end
                imgui.SameLine()
                if imgui.Button(u8'дальнобойщик', imgui.ImVec2(135, 20)) then
                    hcreason = ' // дальнобойщик'
                    acnbans = 3
                end
                if imgui.Button(u8'работа новичков', imgui.ImVec2(135, 20)) then
                    hcreason = ' // работа новичков'
                    acnbans = 3
                end
                imgui.SameLine()
                if imgui.Button(u8'самогонщик', imgui.ImVec2(135, 20)) then
                    hcreason = ' // самогон'
                    acnbans = 3
                end
              elseif acnbans == 3 then
                if imgui.Button(u8'<< Обратно <<', imgui.ImVec2(280, 20)) then
                    acnbans = 1
                end
                if imgui.Button(u8'SPEEDHACK', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' HC sh'..hcreason)
                end
                imgui.SameLine()
                if imgui.Button(u8'AIRBRAKE', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' HC air'..hcreason)
                end
                if imgui.Button(u8'GM', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' HC gm'..hcreason)
                end
                imgui.SameLine()
                if imgui.Button(u8'FLY', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' HC fly'..hcreason)
                end
                if imgui.Button(u8'TELEPORT', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' HC tp'..hcreason)
                end
                imgui.SameLine()
                if imgui.Button(u8'AUTOCLICKER', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' HC autoclicker'..hcreason)
                end
              end
          imgui.EndChild()
        elseif acnn == 6 then
          imgui.BeginChild('##events', imgui.ImVec2(300, 180), false)
                  if imgui.Button(u8'SPEEDHACK', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' hc sh // event')
                  end
                    imgui.SameLine()
                  if imgui.Button(u8'AIRBRAKE', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' hc air // event')
                  end
                  if imgui.Button(u8'GM', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' hc gm // event')
                  end
                    imgui.SameLine()
                  if imgui.Button(u8'FLY', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' hc fly // event')
                  end
                  if imgui.Button(u8'ANTIFALL', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' hc antifall // event')
                  end
                  imgui.SameLine()
                  if imgui.Button(u8'TELEPORT', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' hc tp // event')
                  end
                  if imgui.Button(u8'COLLISION', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' hc collision // event')
                  end
                  imgui.SameLine()
                  if imgui.Button(u8'GAMESPEED', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' hc gamespeed // event')
                  end
                  if imgui.Button(u8'UNFREEZE', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' hc unfreeze // event')
                  end
                  imgui.SameLine()
                  if imgui.Button(u8'AIM', imgui.ImVec2(135, 20)) then
                    sampSendChat('/ban '..idspec..' hc aim (shotinfo) // event')
                  end
          imgui.EndChild()
        elseif acnn == 3 then
          imgui.BeginChild('##kick', imgui.ImVec2(300, 180), false)
              if imgui.Button(u8'AFK помеха', imgui.ImVec2(135, 20)) then
                sampSendChat('/kick '..idspec..' AFK помеха')
              end
                imgui.SameLine()
              if imgui.Button(u8'AFK на дороге', imgui.ImVec2(135, 20)) then
                sampSendChat('/kick '..idspec..' AFK на дороге')
              end
          imgui.EndChild()
        elseif acnn == 4 then
          imgui.BeginChild('##warn', imgui.ImVec2(300, 180), false)
              if imgui.Button(u8'Сбив анимации', imgui.ImVec2(135, 20)) then
                sampSendChat('/warn '..idspec..' сбив анимации')
              end
              imgui.SameLine()
              if imgui.Button(u8'Велобагоюз', imgui.ImVec2(135, 20)) then
                sampSendChat('/warn '..idspec..' велобагоюз')
              end
              if imgui.Button(u8'AFK от ареста', imgui.ImVec2(135, 20)) then
                sampSendChat('/warn '..idspec..' AFK от ареста')
              end
              imgui.SameLine()
              if imgui.Button(u8'OFF от ареста', imgui.ImVec2(135, 20)) then
                sampSendChat('/warn '..idspec..' OFF от ареста')
              end
              if imgui.Button(u8'AFK от смерти', imgui.ImVec2(135, 20)) then
                sampSendChat('/warn '..idspec..' AFK от ареста')
              end
              imgui.SameLine()
              if imgui.Button(u8'OFF от смерти', imgui.ImVec2(135, 20)) then
                sampSendChat('/warn '..idspec..' OFF от ареста')
              end
          imgui.EndChild()
        elseif acnn == 5 then
            imgui.BeginChild('##warn', imgui.ImVec2(300, 180), false)
            if acnnn == 0 then
                if imgui.Button(u8'CONVOY', imgui.ImVec2(87, 20)) then
                    warreason = 'convoy'
                    acnnn = 1
                end
                imgui.SameLine()
                if imgui.Button(u8'SMUG', imgui.ImVec2(87, 20)) then
                    warreason = 'smug'
                    acnnn = 1
                end
                imgui.SameLine()
                if imgui.Button(u8'KB', imgui.ImVec2(85, 20)) then
                    warreason = 'kb'
                    acnnn = 1
                end
            elseif acnnn == 1 then
                if imgui.Button(u8'<< ОБРАТНО <<', imgui.ImVec2(280, 20)) then
                    acnnn = 0
                end
                if imgui.Button(u8'AIM', imgui.ImVec2(135, 20)) then
                    sampSendChat('/aban '..idspec..' hc aim (shotinfo) // '..warreason)
                end
                imgui.SameLine()
                if imgui.Button(u8'UNFREEZE', imgui.ImVec2(135, 20)) then
                    sampSendChat('/aban '..idspec..' hc unfreeze // '..warreason)
                end
                if imgui.Button(u8'DB', imgui.ImVec2(30, 20)) then
                    sampSendChat('/warn '..idspec..' DB // '..warreason)
                end
                imgui.SameLine()
                if imgui.Button(u8'AFK', imgui.ImVec2(50, 20)) then
                    sampSendChat('/warn '..idspec..' AFK от смерти // '..warreason)
                end
                imgui.SameLine()
                if imgui.Button(u8'OFF', imgui.ImVec2(50, 20)) then
                    sampSendChat('/warn '..idspec..' OFF от смерти // '..warreason)
                end
                imgui.SameLine()
                if imgui.Button(u8'СБИВ', imgui.ImVec2(50, 20)) then
                    sampSendChat('/warn '..idspec..' сбив // '..warreason)
                end
                imgui.SameLine()
                if imgui.Button(u8'БАГОЮЗ', imgui.ImVec2(60, 20)) then
                    sampSendChat('/warn '..idspec..' багоюз // '..warreason)
                end
                if imgui.Button(u8'SPEEDHACK', imgui.ImVec2(135, 20)) then
                    sampSendChat('/aban '..idspec..' speedhack // '..warreason)
                end
                imgui.SameLine()
                if imgui.Button(u8'AIRBRAKE', imgui.ImVec2(135, 20)) then
                    sampSendChat('/aban '..idspec..' airbrake // '..warreason)
                end
                if imgui.Button(u8'FLY', imgui.ImVec2(135, 20)) then
                    sampSendChat('/aban '..idspec..' fly // '..warreason)
                end
                imgui.SameLine()
                if imgui.Button(u8'GM', imgui.ImVec2(135, 20)) then
                    sampSendChat('/aban '..idspec..' gm // '..warreason)
                end
                if imgui.Button(u8'ANTIFALL', imgui.ImVec2(135, 20)) then
                    sampSendChat('/aban '..idspec..' antifall // '..warreason)
                end
                imgui.SameLine()
                if imgui.Button(u8'TELEPORT', imgui.ImVec2(135, 20)) then
                    sampSendChat('/aban '..idspec..' teleport // '..warreason)
                end
                if imgui.Button(u8'COLLISION', imgui.ImVec2(135, 20)) then
                    sampSendChat('/aban '..idspec..' collisionb // '..warreason)
                end
                imgui.SameLine()
                if imgui.Button(u8'GAMESPEED', imgui.ImVec2(135, 20)) then
                    sampSendChat('/aban '..idspec..' gamespeed // '..warreason)
                end
            end
            imgui.EndChild()
        end

        imgui.End()
      end
  end
  
      if win.information.v then
        local sw, sh = getScreenResolution()
        imgui.SetNextWindowPos(imgui.ImVec2(sw / 1.14, sh / 2.8), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(300, 150), imgui.Cond.FirstUseEver)
        imgui.Begin('1232323', imgui.ImVec2(1, 1), imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
        if imgui.Button(u8'BANLOG', imgui.ImVec2(285, 25)) then
            sampSendChat('/banlog '..idspec)
        end
        if imgui.Button(u8'NAMELOG', imgui.ImVec2(285, 25)) then
            sampSendChat('/namelog '..idspec)
        end
        if imgui.Button(u8'ASEEK', imgui.ImVec2(285, 25)) then
            sampSendChat('/aseek '..idspec)
        end
        if imgui.Button(u8'ISEEK', imgui.ImVec2(285, 25)) then
            sampSendChat('/iseek '..idspec)
        end
        imgui.End()
      end

      if win.second_window_state.v then
        local sw, sh = getScreenResolution()
        imgui.SetNextWindowPos(imgui.ImVec2(sw / 1.16, sh / 1.36), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(380, 420), imgui.Cond.FirstUseEver)
        imgui.Begin(fa.ICON_EYE .. u8' '..nicknamespec..'['..idspec..'] PING '..sampGetPlayerPing(idspec)..' LVL '..sampGetPlayerScore(idspec), second_window_state, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
        if imgui.Button(fa.ICON_ADDRESS_CARD .. u8' STATS', imgui.ImVec2(175, 30)) then
          sampSendChat('/check '..idspec)
        end
        imgui.SameLine()
        if imgui.Button(fa.ICON_CHEVRON_UP .. u8' SLAP', imgui.ImVec2(175, 30)) then
          sampSendChat('/slap '..idspec)
        end
        if imgui.Button(fa.ICON_CHECK_SQUARE .. u8' Приятной игры <3', imgui.ImVec2(175, 30)) then
          sampSendChat('/amsx '..idspec..' Приятной игры <3')
        end
        imgui.SameLine()
        if imgui.Button(fa.ICON_PAUSE .. u8' FREEZE', imgui.ImVec2(95, 30)) then
          sampSendChat('/freeze '..idspec)
        end
        imgui.SameLine()
        if imgui.Button(u8' ALL', imgui.ImVec2(70, 30)) then 
            frall = not frall
            if frall then
                sampSendChat('/frall 20')
            else
                sampSendChat('/unfrall 30')
            end
        end
        if imgui.Button(fa.ICON_USERS .. u8' Information', imgui.ImVec2(175, 30)) then
           lua_thread.create(function()
              if not win.information.v then
                win.information.v = not win.information.v 
              else
                win.information.v = not win.information.v 
              end
           end)
        end
        imgui.SameLine()
        if imgui.Button(fa.ICON_FIRE .. u8' UNSTAD', imgui.ImVec2(175, 30)) then
          sampSendChat('/und '..idspec)
        end
        if imgui.Button(fa.ICON_COMMENTS .. u8' CHATLOG', imgui.ImVec2(175, 31)) then
          sampSendChat('/chlog '..idspec)
        end
        imgui.SameLine()
        if imgui.Button(fa.ICON_BOMB .. u8' DHIST', imgui.ImVec2(175, 31)) then
          sampSendChat('/dhist '..idspec)
        end
        if imgui.Button(fa.ICON_CHEVRON_RIGHT .. u8' GOTO', imgui.ImVec2(175, 30)) then
          lua_thread.create(function()
                    MYXw, MYYw, MYZw = getCharCoordinates(playerPed)
                    sampSendChat("/reoff")
                    wait(1000)
                    setCharCoordinates(PLAYER_PED, MYXw, MYYw, MYZw)
                    sampSendChat("/goto "..idspec)
                end)
        end
        imgui.SameLine()
        if imgui.Button(fa.ICON_CHEVRON_LEFT .. u8' GETHERES', imgui.ImVec2(175, 30)) then
          lua_thread.create(function()
                    sampSendChat("/reoff")
                    wait(1000)
                    sampSendChat("/getheres "..idspec)
                end)
        end
        if imgui.Button(fa.ICON_USER_TIMES .. u8' KILL', imgui.ImVec2(95, 30)) then
          sampSendChat('/kill '..idspec)
        end
        imgui.SameLine()
        if imgui.Button(u8' HP', imgui.ImVec2(70, 30)) then
          sampSendChat('/sethp '..idspec..' 100')
        end
        imgui.SameLine()
        if imgui.Button(fa.ICON_COG .. u8' POPT', imgui.ImVec2(175, 30)) then
          sampSendChat('/popt '..idspec)
        end
        if imgui.Button(fa.ICON_SIGN_OUT .. u8' REENT', imgui.ImVec2(95, 30)) then
          sampSendChat('/reent '..idspec)
        end
        imgui.SameLine()
        if imgui.Button(u8' REVIVE', imgui.ImVec2(70, 30)) then
          sampSendChat('/revive '..idspec)
        end
        imgui.SameLine()
        if imgui.Button(fa.ICON_STREET_VIEW .. u8' SPAWN', imgui.ImVec2(175, 30)) then
          sampSendChat('/spawn '..idspec)
        end
        if imgui.Button(fa.ICON_CAR .. u8' RESPAWNCAR', imgui.ImVec2(110, 30)) then
          local result1, spech = sampGetCharHandleBySampPlayerId(idspec)
          local car, huita = storeClosestEntities(spech)
          local result, idcar = sampGetVehicleIdByCarHandle(car)
          sampSendChat('/respawnid '..idcar)
        end
        imgui.SameLine()
        if imgui.Button(u8' ROAD', imgui.ImVec2(55, 30)) then
           if idspec then
              teleportToRoadNode(tostring(idspec))
          end
        end
        imgui.SameLine()
        if imgui.Button(fa.ICON_HEART .. u8' FLIP', imgui.ImVec2(95, 30)) then
          sampSendChat('/flip '..idspec)
        end
        imgui.SameLine()
        if imgui.Button(u8' RCAR', imgui.ImVec2(70, 30)) then
          sampSendChat('/rcar '..idspec)
        end
        if imgui.Button(fa.ICON_BICYCLE .. u8' ROLL', imgui.ImVec2(175, 30)) then
          sampSendChat('/roll '..idspec)
        end
        imgui.SameLine()
        if imgui.Button(fa.ICON_TELEVISION .. u8' BOT', imgui.ImVec2(175, 30)) then
          sampSendChat('/ams '..idspec..' Сколько будет 33 + 19 x 2 ? Ответ в /b чат. ')
        end
        imgui.SameLine()
        if imgui.Button(fa.ICON_CARET_SQUARE_O_RIGHT .. u8'', imgui.ImVec2(175, 30)) then
           if tonumber(idspec) == sampGetMaxPlayerId(false) then
                if not sampIsPlayerConnected(0) then
                    for i = idspec, sampGetMaxPlayerId(false) do 
                        if sampIsPlayerConnected(i) and i ~= idspec then
                            sampSendChat('/re '..i)
                            break
                        end
                    end
                else
                    sampSendChat('/re 0')
                    idspec = 0
                end 
            else 
                for i = idspec, sampGetMaxPlayerId(false) do 
                    if sampIsPlayerConnected(i) and sampGetPlayerScore(i) > 0 and i ~= idspec then
                        sampSendChat('/re '..i)
                        lasti = i
                        break
                    end
                end
            end
            nextspec = true
            nextspecr = true
        end
        if imgui.Button(u8'DM') then
            sampSendChat('/amestxt '..idspec..' DM off')
        end
        imgui.SameLine()
        if imgui.Button(u8'DM(tvs)') then
            sampSendChat('/tvs DM off')
        end
        imgui.SameLine()
        if imgui.Button(u8'DB') then
            sampSendChat('/amestxt '..idspec..' DB off')
        end
        imgui.SameLine()
        if imgui.Button(u8'ПRP') then
            sampSendChat('/amestxt '..idspec..' Покиньте РП ситуацию, мешаете вы!')
        end
        imgui.SameLine()
        if imgui.Button(u8'ВЫ ТУТ?') then
            sampSendChat('/amestxt '..idspec..' Вы тут? + в /b чат')
        end
        imgui.SameLine()
        if imgui.Button(u8'SMUGs') then
            sampSendChat('/amestxt '..idspec..' Покиньте зону вара! Не мешайте!')
        end
        imgui.SameLine()
        if imgui.Button(u8'ВОЖДЕНИЕ') then
            sampSendChat('/amestxt '..idspec..' Адекватнее водите!')
        end
        imgui.End()
      end
   
end


sampRegisterChatCommand('myco', function()
    sampAddChatMessage(MYX..' '..MYY..' '..MYZ, -1)
end)

function chlogcheck(arg)
   win.chlogwind.v = not win.chlogwind.v
   imgui.Process = win.chlogwind.v
   chlog = true
end

function q.onPlayerDeathNotification(killerId, killedId, reason)
    if Config.Settings.IdKillList then
        local kill = ffi.cast('struct stKillInfo*', sampGetKillInfoPtr())
        local _, myid = sampGetPlayerIdByCharHandle(playerPed)

        local n_killer = ( sampIsPlayerConnected(killerId) or killerId == myid ) and sampGetPlayerNickname(killerId) or nil
        local n_killed = ( sampIsPlayerConnected(killedId) or killedId == myid ) and sampGetPlayerNickname(killedId) or nil
        lua_thread.create(function()
            wait(0)
            if n_killer then kill.killEntry[4].szKiller = ffi.new('char[25]', ( n_killer .. '[' .. killerId .. ']' ):sub(1, 24) ) end
            if n_killed then kill.killEntry[4].szVictim = ffi.new('char[25]', ( n_killed .. '[' .. killedId .. ']' ):sub(1, 24) ) end
        end)
    end
end

function q.onShowDialog(dialogId, style, title, button1, button2, text)
    tt = title
    if nicklastrepdm then
        if title:find('{ffffff}deathhistory игрока {abcdef}'..nicklastrepdm) then
            if text:find('%d+:%d+:%d+%s+(%S+) ID (%d+) 	 '..nicklastrepdm..' ID .+') then
                nickname, idad = text:match('%d+:%d+:%d+%s+(%S+) ID (%d+) 	 '..nicklastrepdm..' ID .+')
                sampAddChatMessage(tag..''..nickname..' добавлен в AD', -1)
                idj4 = sampGetPlayerIdByNickname(nicklastrepdm)
            end
        end
    end
    if title:find('{34C924}Лог репортов и ответов на них') then
        lua_thread.create(function()
            while true do
                wait(1000)
                if sampIsDialogActive() and not sampIsChatInputActive() then
                    sampSendChat('/rlog')
                end
                break
            end
        end)
    end
    if title:match("{34C924}Последние 30 сессий аккаунта .+") then
		local acs_tb_tmp = {}
        offas = false
		for strkick in string.gmatch(text, "[^\n]+") do
			if strkick ~= "{ffffff}" and strkick:find("(%S+)    (.+)    .+    .+    .+    (.+)") and not strkick:find('nl_left') then
				if strkick:match("%S+    .+    .+    .+    .+    (%d+):(%d+) (.+)  (%d+):(%d+) (.+)") then
					ipase, afk, Hour1, Min1, date1, Hour2, Min2, date2 = strkick:match("%S+    (.+)    .+    .+    AFK (%d+).+    (%d+):(%d+) (.+)    (%d+):(%d+) (.+)")
                    podset1, podset2  = ipase:match('(%d+).(%d+)..+')
                    podset = podset1..'.'..podset2
                    if lastpodset and not offas then
                        if lastpodset ~= podset then
                            title = title..' {FF0000}ВОЗМОЖНО ВЗЛОМ, ЕСТЬ РАЗЛИЧИЕ В ПОДСЕТИ!'
                            offas = true 
                        end
                    end
                    lastpodset = podset
					llastHour2 = Hour2
					llastMin2 = Min2
					if date1 ~= date2 then
						Hour2 = 24
						Min2 = 0
					end
					if not razn then
						Min1 = tonumber(Hour1) * 60 + tonumber(Min1) 
						Min2 = tonumber(Hour2) * 60 + tonumber(Min2)
						raznica = tonumber(Min2) - tonumber(Min1)
					else
						Min1 = tonumber(Hour1) * 60 + tonumber(Min1) 
						Min2 = tonumber(Hour2) * 60 + tonumber(Min2) + tonumber(lastHour2) * 60 + tonumber(lastMin2)
						raznica = tonumber(Min2) - tonumber(Min1)
						razn = false
					end
					if tonumber(afk) ~= 0 then
						bezafkr = tonumber(raznica) - tonumber(raznica) / 100 * tonumber(afk)
					else
						bezafkr = raznica
					end
					if lastdate then
						if lastdate == date1 then
							if lasraznica then
								dateraznica = tonumber(dateraznica) + tonumber(raznica)
								bdateraznica = tonumber(bdateraznica) + tonumber(bezafkr) 
							end
						else
							hourraznica = tonumber(dateraznica) / 60
							hourraznica = tonumber(hourraznica) - tonumber(hourraznica) % 1
							minraznica = tonumber(dateraznica) % 60
							bhourraznica = tonumber(bdateraznica) / 60
							bhourraznica = tonumber(bhourraznica) - tonumber(bhourraznica) % 1
							bminraznica = tonumber(bdateraznica) % 60
							bminraznica = tonumber(bminraznica) - tonumber(bminraznica) % 1
							sampAddChatMessage('{eaff05}'..lastdate..'{ffffff} - Время с афк: {ff9b29}'..hourraznica..'{ffffff} ч. {ff9b29}'..minraznica..'{ffffff} мин. Без афк: {24ff2b}'..bhourraznica..'{ffffff} ч. {24ff2b}'..bminraznica..'{ffffff} мин.', -1)
							dateraznica = tonumber(raznica)
							bdateraznica = bezafkr
						end
					else
						dateraznica = tonumber(raznica)
						bdateraznica = bezafkr
					end
					lasraznica = tonumber(raznica)
					lastdate = date1
					if date1 ~= date2 then
						razn = true
					end
					lastHour2 = llastHour2
					lastMin2 = llastMin2
				end
			end
		end
        if dateraznica then
		    hourraznica = tonumber(dateraznica) / 60
		    hourraznica = tonumber(hourraznica) - tonumber(hourraznica) % 1
		    minraznica = tonumber(dateraznica) % 60
		    bhourraznica = tonumber(bdateraznica) / 60
		    bhourraznica = tonumber(bhourraznica) - tonumber(bhourraznica) % 1
		    bminraznica = tonumber(bdateraznica) % 60
		    bminraznica = tonumber(bminraznica) - tonumber(bminraznica) % 1
		    sampAddChatMessage('{eaff05}'..lastdate..'{ffffff} - Время с афк: {ff9b29}'..hourraznica..'{ffffff} ч. {ff9b29}'..minraznica..'{ffffff} мин. Без афк: {24ff2b}'..bhourraznica..'{ffffff} ч. {24ff2b}'..bminraznica..'{ffffff} мин.', -1)
		    lastdate = false
            lastpodset = nil
        end
	end
    if title:find('Лог репортов и ответов на них') then
        for strkick in string.gmatch(text, "[^\n]+") do
            if strkick:find('%[REPORT%]') then
                time1, reportnick1, report1 = strkick:match('%[(.+)%] %[REPORT%] (.+): (.+)')
            end
        end
    end
    if title:find('{34C924}Управление предметом') then
        if text then
            if text:find('Установлен игроком: {D8A903}(.+)\nВ') then
                nickaob = text:match('Установлен игроком: {D8A903}(.+)\nВ')
                title = '{34C924}Управление предметом.{b54141} /reaob - SPEC | /jailaob / Y - JAIL'
                lua_thread.create(function()
                    nickaobact = true
                    wait(5000)
                    nickaobact = false
                end)
            end
        end
    end
    if title:find('{34C924}Управление лейблом') then
        if text then
            if text:find('Автор: {abcdef}(.+)\nВ') then
                nicklab = text:match('Автор: {abcdef}(.+)\nВ')
                title = '{34C924}Управление лейблом{b54141} /jaillab / Y - JAIL'
                lua_thread.create(function()
                    nickaoblab = true
                    wait(5000)
                    nickaoblab = false
                end)
            end
        end
    end
    if title:find('deathhistory') then
        if dhnickj then
            if text:find(dhnickj) then
                text = text:gsub(dhnickj, '{14e609}[Ж]{ffffff} '..dhnickj) 
            end
        end
    end
    if title:find('chatlog (.+) ID {(.+)}(%d+)') then
        kick = {}
        textt = ''
        str = strkick
            lastersec = ''
            lastermes = ''
            lastermin = ''
            lastsec = ''
            lastmes = ''
            lastmin = ''
        for strkick in string.gmatch(text, "[^\n]+") do
            str = strkick
            if strkick ~= "{ffffff}" and strkick:find("%[(.+):(.+):(.+)%](.+)") then
                kick['TmpHour'], kick['TmpMinute'], kick['TmpSec'], kick['TmpChat'], kick['TmpMes'] = strkick:match("%[(%d+):(%d+):(%d+)%] %[(.+)%] (.+)")
                if lastmes and lastsec and lastmin then
                    if kick['TmpMes'] == lastmes and kick['TmpSec'] - lastsec < 5 and kick['TmpMinute'] == lastmin then
                        if lastermes and lastersec and lastermin then
                            if kick['TmpMes'] == lastermes and kick['TmpSec'] - lastersec < 5 and kick['TmpMinute'] == lastermin then
                                    str = str..'{FFA500} [F]{ffffff}'
                            end
                        end
                        lastersec = lastsec
                        lastermes = lastmes
                        lastermin = lastmin
                    end
                end
                lastsec = kick['TmpSec']
                lastmes = kick['TmpMes']
                lastmin = kick['TmpMinute']
            end
            textt = textt..'\n'..str
 
        end
        if Config.Settings.oskfind then
            if textt then
                for i, val in pairs(Config.arr_osk) do 
                    if textt:find(val) then
                        if val ~= '{ff0000}'..val..'{ffffff}' then
                            textt = textt:gsub(val, '{ff0000}'..val..'{ffffff}')
                        end
                    end
                end
            end
        end
        text = textt
    end

    if string.find(title, 'Получены ', 1, true) then
        if Config.Settings.AutoUnd then
            local result, my2id = sampGetPlayerIdByCharHandle(PLAYER_PED)
            sampSendChat('/und '..my2id)
        else
            win.deadwind.v = true
            win.descwind.v = false
            win.chlogwind.v = false
            imgui.Process = win.deadwind.v
            ded = true
            chlog = false
            desc = false
        end
    end
    if not specstat then 
        if Config.Settings.ChlogHelp then 
            if title:find('chatlog (.+) ID {(.+)}(%d+)') then
                idch = title:match('chatlog .+ ID {.+}(%d+)')
                nickch = sampGetPlayerNickname(idch)
                win.chlogwind.v = true
                win.deadwind.v = false
                win.descwind.v = false
                imgui.Process = win.chlogwind.v
                chlog = true
                ded = false
                desc = false
            end
        end
    else 
        if title:find('chatlog (.+) ID {(.+)}(%d+)') then
            idch = title:match('chatlog .+ ID {.+}(%d+)')
            nickch = sampGetPlayerNickname(idch)
            win.chlogwind.v = true
            win.deadwind.v = false
            win.descwind.v = false
            chlog = true
            ded = false
            desc = false
            win.nakazwind.v = false
            imgui.Process = true
        end
    end
    if string.find(title, '{34C924}Описание', 1, true) then
        if not title:find('вашего') then
            if not specstat and Config.Settings.DescHelp then
                win.descwind.v = true
                win.deadwind.v = false
                win.chlogwind.v = false
                imgui.Process = win.descwind.v
                desc = true
                chlog = false
                ded = false
            end
        end
    end
    if admincheck then
        if text:find('Игрок {.+}(.+) находится в АФК (.+)') then
            afkadminnick1, afktime = text:match('Игрок {.+}(.+) находится в АФК (.+)')
            sampAddChatMessage('[AFK] Администратор {'..lvlcolor1..'}'..afkadminnick1..' {ffffff}АФК уже '..afktime, -1)
            return false
        end
    end

return {dialogId, style, title, button1, button2, text}
end
function q.onShowTextDraw(id, data)
    if Config.Settings.SpecPlayerCheck then
        if idspec ~= -1 then
            lua_thread.create(function()
                while true do 
                    wait(0)
                    if data.text:find('.*') then
                        sampTextdrawDelete(id)
                    end
                end
            end)
        end
    end
end

function q.onSendDialogResponse(dialogid, button, list, input)
    if dialogid == 45 and button == 0 or dialogid == 45 and button == 1 then 
        if chlog or desc or ded then
            if not win.second_window_state.v then
             imgui.Process = false
            end
         end
         if ded then
             win.deadwind.v = false
             ded = false
         end
         if chlog then
             win.chlogwind.v = false
             chlog = false
         end
         if desc then
             win.descwind.v = false
             desc = false
         end
    end
    if dialogid == 5760 and button == 0 or dialogid == 5760 and button == 1 then 
        if ded then
            win.deadwind.v = false
            imgui.Process = false
            ded = false
        end
    end
end

function q.onSendPlayerSync(data)
    if invActivate then 
        if not invActivatecar then
            data.position.x = MYX 
            data.position.y = MYY 
            data.position.z = -80
        end
    end
end

function q.onSendVehicleSync(data)
    if invActivatecar then
        data.position.x = MYX 
        data.position.y = MYY 
        data.position.z = -80
    end
end

function spec(arg)
    sampSendChat('/re '..arg)
end

sampRegisterChatCommand('relvl', function(lvl)
    local onMaxId = sampGetMaxPlayerId(false)
    if not sampIsPlayerConnected(0) or sampGetPlayerScore(0) ~= tonumber(lvl) then 
        for i = 0, sampGetMaxPlayerId(false), 1 do
            if sampIsPlayerConnected(i) and sampGetPlayerScore(i) == tonumber(lvl) and i ~= idspec then
                idspec = i
                sampSendChat('/re '..idspec)
                relvl = true
                lvlre = lvl
                specstat = true
                break
            end
        end
    end
end)
sampRegisterChatCommand('hrnick', function(arg)
    sampSendChat('/aban '..idspec..' HR '..nicknamespec..'')
end)
sampRegisterChatCommand('livban', function(arg)
    sampSendChat('/ofban '..ofnicknamespec..' '..arg)
end)

sampRegisterChatCommand('livwarn', function(arg)
    sampSendChat('/ofwarn '..ofnicknamespec..' '..arg)
end)

sampRegisterChatCommand('livbanlog', function(arg)
    sampSendChat('/ofbanlog '..ofnicknamespec..' '..arg)
end)

sampRegisterChatCommand('livcheck', function(arg)
    sampSendChat('/ofcheck '..ofnicknamespec..' '..arg)
end)

sampRegisterChatCommand('liviseek', function(arg)
    sampSendChat('/ofiseek '..ofnicknamespec..' '..arg)
end)

sampRegisterChatCommand('livaseek', function(arg)
    sampSendChat('/ofaseek '..ofnicknamespec..' '..arg)
end)

sampRegisterChatCommand('livabanc', function(arg)
    sampSendChat('/abanc '..ofnicknamespec..' '..arg)
end)

sampRegisterChatCommand('livnick', function(arg)
    sampSendChat('/aofban '..ofnicknamespec..' HR '..ofnicknamespec..'')
end)

sampRegisterChatCommand('repcolor', function(arg)
    Config.Settings.RepColor = arg
    inicfg.save(Config, 'ahelp.ini')
    sampAddChatMessage(tag.. '{FFFFFF}Цвет изменён на {'..Config.Settings.RepColor..'}TEST', 0x7172ee)
end)

sampRegisterChatCommand('acolor', function(arg)
    Config.Settings.ACHColor = arg
    inicfg.save(Config, 'ahelp.ini')
    sampAddChatMessage(tag..'{FFFFFF}Цвет изменён на {'..Config.Settings.ACHColor..'}TEST', 0x7172ee)
end)

sampRegisterChatCommand('test', function()
    sampAddChatMessage('{f27c7c}На игрока {faec73}ты долбаеб{f27c7c} уже 3й раз ругается античит.', -1)
end)

sampRegisterChatCommand('colors', function()
    Config.Settings.Colors = not Config.Settings.Colors
    inicfg.save(Config, 'ahelp.ini')
    if Config.Settings.Colors then
        sampAddChatMessage('ON', -1)
    else
        sampAddChatMessage('OFF', -1)
    end
end)

function avinfo()
    avinfon = not avinfon
    lasttic = tic
    sampSendChat('/vinfo')
end

sampRegisterChatCommand('bn', function(arg)
    if arg:find('(%d+) (%d+)') then
        bnid, bnkod = arg:match('(.+) (.+)')
        if sampGetPlayerNickname(bnid) then
            bnnick = sampGetPlayerNickname(bnid)
            tic = 0
            bno = true
            lasttic = tic
            sampSendChat('/banname '..bnid..' '..bnkod)
            sampAddChatMessage(tag..'{ffffff}Автоматический баннейм на {7172ee}ID '..bnid..' {ffffff}активирован. Для деактивации: {7172ee}/bn off', 0x7172ee)
        else
            sampAddChatMessage(tag..'{ffffff}Offline.', 0x7172ee)
        end
    elseif arg == 'off' then
        bno = false
        sampAddChatMessage(tag..'{ffffff}Автоматический баннейм {7172ee}деактивирован.', 0x7172ee)
    else
        sampAddChatMessage(tag..'Введите {7172ee}ID и код наказания{FFFFFF} для успешной активации этой команды.', 0x7172ee)
    end
end)


sampRegisterChatCommand('rew', function()
    if idw then
        if sampIsPlayerConnected(idw) then
            spec(idw)
        end
    else
        sampAddChatMessage(tag..'Варнингов нет.')
    end
end)

sampRegisterChatCommand('reg', function()
    setCharCoordinates(PLAYER_PED, MYXg, MYYg, MYZg)
    sampAddChatMessage(tag..'Вы возвращены.', -1)
end)

sampRegisterChatCommand('blockk', function(arg)
    bloknick = arg
end)

sampRegisterChatCommand('xyz', function(arg)
    
    if arg then
        if arg:match('(.+) (.+) (.+)') then
            x, y, z = arg:match('(.+) (.+) (.+)')
            setCharCoordinates(PLAYER_PED, x, y, z)
        end
    else
        sampAddChatMessage('/xyz x y z', -1)
    end
end)

sampRegisterChatCommand('adosk', function(arg)
    if arg ~= '' and arg ~= ' ' then
        Config.arr_osk[#Config.arr_osk+1] = arg
        inicfg.save(Config, 'ahelp.ini')
        sampAddChatMessage(tag..'{DC143C}Оск {ffffff}'..arg..' {DC143C}добавлен в список.', -1)
    else
        sampAddChatMessage(tag..'{DC143C}Пробелы {ffffff}запрещены {DC143C}в использовании.') 
    end
end)

sampRegisterChatCommand('oskfind', function()
    Config.Settings.oskfind = not Config.Settings.oskfind
    inicfg.save(Config, 'ahelp.ini')
    if Config.Settings.oskfind then
        sampAddChatMessage(tag..'{DC143C}Поиск оскорблений в chatlog {ffffff}активирован.', -1)
    else
        sampAddChatMessage(tag..'{DC143C}Поиск оскорблений в chatlog {ffffff}деактивирован.', -1)
    end
end)

sampRegisterChatCommand('uams', function(arg)
    if idspec then
        sampSendChat('/ames '..idspec..' '..arg)
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('ugl', function(arg)
    if idspec then
        sampSendChat('/amesx '..idspec..' Приятной игры <3')
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('ufg', function(arg)
    if idspec then
        sampSendChat('/ban '..idspec..' R fg')
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)


sampRegisterChatCommand('ucheck', function(arg)
    if idspec then
        sampSendChat('/check '..idspec)
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('uiseek', function(arg)
    if idspec then
        sampSendChat('/iseek '..idspec)
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('uaseek', function(arg)
    if idspec then
        sampSendChat('/aseek '..idspec)
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('ubanlog', function(arg)
    if idspec then
        sampSendChat('/banlog '..idspec)
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('uchlog', function(arg)
    if idspec then
        sampSendChat('/chlog '..idspec)
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('uban', function(arg)
    if idspec then
        sampSendChat('/ban '..idspec..' '..arg)
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('uwarn', function(arg)
    if idspec then
        sampSendChat('/warn '..idspec..' '..arg)
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('ujail', function(arg)
    if idspec then
        sampSendChat('/warn '..idspec..' '..arg)
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('ukick', function(arg)
    if idspec then
        sampSendChat('/kick '..idspec..' '..arg)
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('ush', function(arg)
    if idspec then
        sampSendChat('/ban '..idspec..' c sh')
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('ufly', function(arg)
    if idspec then
        sampSendChat('/ban '..idspec..' c fly')
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('uair', function(arg)
    if idspec then
        sampSendChat('/ban '..idspec..' c air')
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('ugm', function(arg)
    if idspec then
        sampSendChat('/ban '..idspec..' c gm')
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('ugs', function(arg)
    if idspec then
        sampSendChat('/ban '..idspec..' c gamespeed')
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('utp', function(arg)
    if idspec then
        sampSendChat('/ban '..idspec..' c tp')
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('uantifall', function(arg)
    if idspec then
        sampSendChat('/ban '..idspec..' c antifall')
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('ujumpcar', function(arg)
    if idspec then
        sampSendChat('/ban '..idspec..' c jumpcar')
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('uflipcar', function(arg)
    if idspec then
        sampSendChat('/ban '..idspec..' c flipcar')
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('usurf', function(arg)
    if idspec then
        sampSendChat('/ban '..idspec..' c surf')
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('ucarshot', function(arg)
    if idspec then
        sampSendChat('/ban '..idspec..' hc carshot')
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('urvanka', function(arg)
    if idspec then
        sampSendChat('/aban '..idspec..' hc rvanka')
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('uaim', function(arg)
    if idspec then
        sampSendChat('/ban '..idspec..' hc aim(shotinfo)')
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('uclicker', function(arg)
    if idspec then
        sampSendChat('/ban '..idspec..' hc autoclicker')
    else
        sampAddChatMessage(tag..'Вы не находитесь в режиме наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('warnin', function()
    waroff = not waroff
end)
sampRegisterChatCommand('sk', function()
    sampSendChat('/shotinfo')
    sampSendChat('/keyinfo')
end)
sampRegisterChatCommand('ukb', function()
    sampSendChat('/u traindriver_5')
end)
sampRegisterChatCommand('ukb2', function()
    sampSendChat('/u andromadapilot')
end)
sampRegisterChatCommand('rpm', function(arg)
    if idpm then
        sampSendChat('/pm '..idpm..' '..arg)
    end
end)
sampRegisterChatCommand('asetspawn', function()
    Config.Spawn.SX, Config.Spawn.SY, Config.Spawn.SZ = getCharCoordinates(playerPed)
    Config.Spawn.Active = true
    inicfg.save(Config, 'ahelp.ini')
    sampAddChatMessage(tag..'Точка спавна установлена.', 0x7172ee)
end)

sampRegisterChatCommand('asetspawnoff', function()
    Config.Spawn.Active = false
    inicfg.save(Config, 'ahelp.ini')
    sampAddChatMessage(tag..'Точка спавна удалена.', 0x7172ee)
end)

sampRegisterChatCommand('ahelp', function()
    if not specstat then
            win.mainwin.v = not win.mainwin.v
            imgui.Process = win.mainwin.v
            mainwindow = not mainwindow
    else
        sampAddChatMessage(tag..'Выйдите из режима наблюдения.', 0x7172ee)
    end
end)

sampRegisterChatCommand('togps', function(arg)
    if arg == '' then
        sampSendChat('/togps')
    else
        sampSendChat('/gps '..arg)
        lua_thread.create(function()
            wait(1000)
            sampSendChat('/togps')
        end)
    end
end)

sampRegisterChatCommand('adrep', function()
if tonumber(idwinrep) then
    if sampIsPlayerConnected(idwinrep) then
        nickname = sampGetPlayerNickname(tonumber(idwinrep))
        idad = tonumber(idwinrep)
        idj4 = idj3
        sampAddChatMessage(tag..'ID {e08989}'..idwinrep..'{ffffff} добавлен в AD.')
    end
end
end)

sampRegisterChatCommand('chlj', function()
if tonumber(idj4) then
    if sampIsPlayerConnected(idj4) then
        sampSendChat('/chlog '..idj4)
        lua_thread.create(function()
            wait(500)
            if Config.Settings.FastScreen then
                screenshot.requestEx('example', '_'..vremya..'_'..data)
            else
                makeScreenshot()
            end
        end)
    end
end
end)

sampRegisterChatCommand('agun', function(arg)
if arg ~= '' then
    sampSendChat('/ggun '..clientName..' '..arg)
else
    sampAddChatMessage('/agun {e08989}[gun id]', -1)
end
end)

sampRegisterChatCommand('reaob', function()
if sampGetPlayerIdByNickname(nickaob) then
    idaob = sampGetPlayerIdByNickname(nickaob)
    spec(idaob)
else
    sampAddChatMessage('Игрок установивший объект {7172ee}оффлайн.', 0x7172ee)
end
end)

sampRegisterChatCommand('jailaob', function()
if sampGetPlayerIdByNickname(nickaob) then
    idaob = sampGetPlayerIdByNickname(nickaob)
    sampSendChat('/jail '..nickaob..' 13')
else
    sampSendChat('/ofjail '..nickaob..' 13')
end
end)

sampRegisterChatCommand('jaillab', function()
if sampGetPlayerIdByNickname(nicklab) then
    idaob = sampGetPlayerIdByNickname(nicklab)
    sampSendChat('/jail '..nicklab..' 16')
else
    sampSendChat('/ofjail '..nicklab..' 16')
end
end)

sampRegisterChatCommand('lastrepdm', function()
if idj2 then
    idlastrepdm = idj2
    if sampGetPlayerNickname(idlastrepdm) then
        nicklastrepdm = sampGetPlayerNickname(idlastrepdm)
        nickdhlastch = true
        lua_thread.create(function()
            wait(500)
            if Config.Settings.FastScreen then
                screenshot.requestEx('example', '_'..vremya..'_'..data)
            else
                makeScreenshot()
            end
        end)
    end
    sampSendChat('/dhist '..idlastrepdm)
else
    sampAddChatMessage(tag..'Репортов не было.')
end
end)

function q.onPlayerChatBubble(id, col, dist, dur, msg)
if flymode == 1 then
	return {id, col, 1488, dur, msg}
end
end

function q.onSetPlayerPos(pos)
	if flymode == 1 then
		--setPlayerControl(playerchar, true)
		displayRadar(true)
		setCharCoordinates(PLAYER_PED, posX, posY, posZ)
		displayHud(true)
		radarHud = 0	    
		angPlZ = angZ * -1.0
		--setCharHeading(playerPed, angPlZ)
		--freezeCharPosition(playerPed, false)
		lockPlayerControl(false)
		--setCharProofs(playerPed, 0, 0, 0, 0, 0)
		--setCharCollision(playerPed, true)
		restoreCameraJumpcut()
		setCameraBehindPlayer()
		flymode = 0   
		fly = false
		lua_thread.create(function()
			wait(500)
			--setPlayerControl(playerchar, false)
			displayRadar(false)
			displayHud(false)	    
			posX, posY, posZ = getCharCoordinates(playerPed)
			angZ = getCharHeading(playerPed)
			angZ = angZ * -1.0
			setFixedCameraPosition(posX, posY, posZ, 0.0, 0.0, 0.0)
			angY = 0.0
			--freezeCharPosition(playerPed, false)
			--setCharProofs(playerPed, 1, 1, 1, 1, 1)
			--setCharCollision(playerPed, false)
			lockPlayerControl(true)
			flymode = 1
			fly = true
		--	sampSendChat('/anim 35')
		end)
	end
end

sampRegisterChatCommand('aadmins', function()
    sampAddChatMessage('{7172ee}Скиньте автору скрипта деньги, пожалуйста', 0x7172ee)
end)

sampRegisterChatCommand('seek', function()
    sampAddChatMessage('{FF0000}[WARNING] {ffffff}Команда временно заморожена.', 0x7172ee)
end)

sampRegisterChatCommand('iphelp', function()
    sampAddChatMessage('{FF0000}[WARNING] {ffffff}Команда временно заморожена.', 0x7172ee)
end)

function getPlayersNickname()
  for i = 0, 999 do
    if sampIsPlayerConnected(i) then
      PlayersNickname[i] = sampGetPlayerNickname(i)
    end
  end
end
sampRegisterChatCommand('nicks', function()
    getPlayersNickname()
    sampAddChatMessage(tag.. '{7172ee}Никнеймы с краткими именами онлайн:', 0x7172ee)
    for i=0, 999 do
        if PlayersNickname[i] then
            local pnick = PlayersNickname[i]
            for i, val in pairs(Config.arr_name) do
                if pnick:find(val) then
                    sampAddChatMessage(pnick, 0x7172ee)
                    activenicks = true
                end
            end
        end
    end
    if not activenicks then
        sampAddChatMessage(tag.. 'Ни одного.', 0x7172ee)
    end
    activenicks = false
end)

sampRegisterChatCommand('adnick', function(arg)
    if arg ~= '' and string.match(arg, '(%a+)') then
        arg = string.match(arg, '(%a+)')
        Config.arr_name[#Config.arr_name+1] = arg..'_'
        inicfg.save(Config, 'ahelp.ini')
        sampAddChatMessage(tag.. 'Имя "{7172ee}'..arg..'{FFFFFF}" добавлено в список.', 0x7172ee)
    else
        sampAddChatMessage(tag.. 'Пробелы запрещены!') 
    end
end)
sampRegisterChatCommand('nicksclear', function(arg)
    Config.arr_name = {}
    inicfg.save(Config, 'ahelp.ini')
    sampAddChatMessage(tag..'Список очищен.', 0x7172ee)
end)
sampRegisterChatCommand('hp', function(arg)
    if arg:find('(%d+)') then
        local hp = arg:match('(%d+)')
        sampSendChat('/sethp '..clientName..' '..hp)
    else
        sampSendChat('/hp')
    end
end)
local copas = require 'copas'
local http = require 'copas.http'

local copas = require 'copas'
local http = require 'copas.http'
local requests = require 'requests'
requests.http_socket, requests.https_socket = http, http

function httpRequest(method, request, args, handler) 
    if not copas.running then
        copas.running = true
        lua_thread.create(function()
            wait(0)
            while not copas.finished() do
                local ok, err = copas.step(0)
                if ok == nil then error(err) end
                wait(0)
            end
            copas.running = false
        end)
    end
    if handler then
        return copas.addthread(function(m, r, a, h)
            copas.setErrorHandler(function(err) h(nil, err) end)
            h(requests.request(m, r, a))
        end, method, request, args, handler)
    else
        local results
        local thread = copas.addthread(function(m, r, a)
            copas.setErrorHandler(function(err) results = {nil, err} end)
            results = table.pack(requests.request(m, r, a))
        end, method, request, args)
        while coroutine.status(thread) ~= 'dead' do wait(0) end
        return table.unpack(results)
    end
end
sampRegisterChatCommand('http', function(arg)
    local url = 'https://docs.google.com/forms/d/e/1FAIpQLSe0AsWPlQZcK0l35R9vl3KqODshzjFif8wGlh9vcP2YcDfFEw/formResponse?entry.1192058964='..urlencode(u8(arg))
    sampAddChatMessage(urlencode(arg), -1)
    asyncHttpRequest("GET", url, nil, 
    function(response)
           print(response.text ,-1)
    end,

    function(err)
        --print("[Error] Failed to get response from "..url.." | "..err)
        sampAddChatMessage("{e06666}Повторите{ffffff} запрос.", -1)
   end)
end)
sampRegisterChatCommand('tic', function()
    sampAddChatMessage(tic, -1)
end)