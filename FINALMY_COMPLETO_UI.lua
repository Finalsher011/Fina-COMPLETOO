-- FINALMY | Interface de configuracao / prototipo
-- LocalScript: StarterPlayer > StarterPlayerScripts
-- Os controles de combate sao apenas demonstrativos e nao executam cheats.
-- Use funcionalidades de jogo somente em experiencias que voce desenvolve/tem permissao.

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
if not player then return end
local pg = player:WaitForChild("PlayerGui")
local old = pg:FindFirstChild("FINALMY")
if old then old:Destroy() end

local C = {
    bg = Color3.fromRGB(14, 15, 21),
    side = Color3.fromRGB(19, 20, 28),
    card = Color3.fromRGB(27, 29, 39),
    card2 = Color3.fromRGB(35, 37, 49),
    text = Color3.fromRGB(237, 239, 245),
    muted = Color3.fromRGB(143, 148, 164),
    accent = Color3.fromRGB(225, 65, 82),
    green = Color3.fromRGB(65, 205, 145),
}
local state = {}
local gui = Instance.new("ScreenGui")
gui.Name = "FINALMY"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = pg

local function make(class, props, parent)
    local o = Instance.new(class)
    for k,v in pairs(props or {}) do o[k] = v end
    o.Parent = parent
    return o
end
local function round(o, r)
    make("UICorner", {CornerRadius=UDim.new(0,r or 8)}, o)
end
local function outline(o, color)
    make("UIStroke", {Color=color or Color3.fromRGB(57,60,74), Thickness=1, Transparency=0.15}, o)
end
local function txt(parent, value, size, pos, font, color)
    return make("TextLabel", {
        BackgroundTransparency=1, Text=value, Size=size, Position=pos,
        Font=font or Enum.Font.Gotham, TextSize=12, TextColor3=color or C.text,
        TextXAlignment=Enum.TextXAlignment.Left, TextYAlignment=Enum.TextYAlignment.Center
    }, parent)
end

local window = make("Frame", {
    Name="Window", Size=UDim2.fromOffset(850,540),
    Position=UDim2.new(0.5,-425,0.5,-270),
    BackgroundColor3=C.bg, BorderSizePixel=0
}, gui)
round(window,13); outline(window, Color3.fromRGB(76,80,98))

local top = make("Frame", {Size=UDim2.new(1,0,0,58), BackgroundColor3=Color3.fromRGB(31,34,46), BorderSizePixel=0}, window)
round(top,13)
make("Frame", {Position=UDim2.new(0,0,1,-12), Size=UDim2.new(1,0,0,12), BackgroundColor3=Color3.fromRGB(31,34,46), BorderSizePixel=0}, top)
txt(top,"FINALMY",UDim2.fromOffset(190,34),UDim2.fromOffset(20,7),Enum.Font.GothamBlack,C.accent).TextSize=24
txt(top,"CONFIGURATION HUB  •  TRAINING BUILD",UDim2.fromOffset(300,18),UDim2.fromOffset(22,37),Enum.Font.GothamBold,C.muted).TextSize=9
local close = make("TextButton",{Size=UDim2.fromOffset(34,32),Position=UDim2.new(1,-48,0,13),Text="×",TextSize=22,Font=Enum.Font.GothamBold,TextColor3=C.text,BackgroundColor3=C.card2,BorderSizePixel=0},top)
round(close,7)
close.Activated:Connect(function() gui.Enabled=false end)

local sidebar = make("Frame",{Position=UDim2.fromOffset(0,58),Size=UDim2.new(0,190,1,-58),BackgroundColor3=C.side,BorderSizePixel=0},window)
local navTitle = txt(sidebar,"MENU PRINCIPAL",UDim2.new(1,-24,0,25),UDim2.fromOffset(15,14),Enum.Font.GothamBold,C.muted)
navTitle.TextSize=9
local nav = make("ScrollingFrame",{Position=UDim2.fromOffset(9,45),Size=UDim2.new(1,-18,1,-58),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=C.accent,CanvasSize=UDim2.new(0,0,0,0)},sidebar)
local navLayout=make("UIListLayout",{Padding=UDim.new(0,5),SortOrder=Enum.SortOrder.LayoutOrder},nav)
navLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() nav.CanvasSize=UDim2.fromOffset(0,navLayout.AbsoluteContentSize.Y+8) end)

local area=make("Frame",{Position=UDim2.fromOffset(190,58),Size=UDim2.new(1,-190,1,-58),BackgroundColor3=Color3.fromRGB(17,18,25),BorderSizePixel=0},window)
local heading=txt(area,"AIMBOT",UDim2.new(1,-40,0,30),UDim2.fromOffset(22,13),Enum.Font.GothamBlack,C.text)
heading.TextSize=19
local subtitle=txt(area,"Painel de configuracao FINALMY",UDim2.new(1,-40,0,20),UDim2.fromOffset(23,42),Enum.Font.Gotham,C.muted)
subtitle.TextSize=10
local search=make("TextBox",{Size=UDim2.fromOffset(190,30),Position=UDim2.new(1,-212,0,15),BackgroundColor3=C.card,TextColor3=C.text,PlaceholderText="Pesquisar opcao...",PlaceholderColor3=C.muted,Text="",Font=Enum.Font.Gotham,TextSize=10,ClearTextOnFocus=false,BorderSizePixel=0},area)
round(search,8); outline(search)

local pages={}
local current="Aimbot"
local function page(name)
    local p=make("ScrollingFrame",{Name=name,Position=UDim2.fromOffset(20,78),Size=UDim2.new(1,-40,1,-96),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=C.accent,CanvasSize=UDim2.new(0,0,0,0),Visible=false},area)
    local grid=make("UIGridLayout",{CellSize=UDim2.new(0.5,-8,0,76),CellPadding=UDim2.fromOffset(12,10),SortOrder=Enum.SortOrder.LayoutOrder},p)
    grid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() p.CanvasSize=UDim2.fromOffset(0,grid.AbsoluteContentSize.Y+10) end)
    pages[name]=p
    return p
end
local names={"Aimbot","Silent Aim","Trigger & Rage","Gun Mods","Visuais","World","Skins","Gun Skins","Misc","Settings"}
for _,n in ipairs(names) do page(n) end

local function card(parent,title,desc,order,height)
    local f=make("Frame",{BackgroundColor3=C.card,BorderSizePixel=0,LayoutOrder=order or 1},parent)
    round(f,9); outline(f)
    txt(f,title,UDim2.new(1,-20,0,21),UDim2.fromOffset(12,6),Enum.Font.GothamBold,C.text).TextSize=11
    if desc then txt(f,desc,UDim2.new(1,-20,0,17),UDim2.fromOffset(12,27),Enum.Font.Gotham,C.muted).TextSize=9 end
    if height then f.Size=UDim2.new(1,0,0,height) end
    return f
end
local function toggle(parent,title,desc,key,order)
    local f=card(parent,title,desc,order)
    local b=make("TextButton",{Size=UDim2.fromOffset(38,20),Position=UDim2.new(1,-51,0.5,-10),Text="",BackgroundColor3=C.card2,BorderSizePixel=0},f)
    round(b,10)
    local dot=make("Frame",{Size=UDim2.fromOffset(14,14),Position=UDim2.fromOffset(3,3),BackgroundColor3=C.text,BorderSizePixel=0},b)
    round(dot,8)
    state[key]=false
    local function draw()
        b.BackgroundColor3=state[key] and C.accent or C.card2
        dot.Position=state[key] and UDim2.fromOffset(21,3) or UDim2.fromOffset(3,3)
    end
    b.Activated:Connect(function() state[key]=not state[key]; draw() end)
    draw()
    return f
end
local function slider(parent,title,desc,key,min,max,default,order)
    local f=card(parent,title,desc,order,88)
    local value=default
    local val=txt(f,tostring(value),UDim2.fromOffset(48,18),UDim2.new(1,-60,0,5),Enum.Font.GothamBold,C.accent)
    val.TextXAlignment=Enum.TextXAlignment.Right
    local bar=make("Frame",{Size=UDim2.new(1,-26,0,6),Position=UDim2.fromOffset(13,62),BackgroundColor3=C.card2,BorderSizePixel=0},f)
    round(bar,5)
    local fill=make("Frame",{Size=UDim2.new((value-min)/(max-min),0,1,0),BackgroundColor3=C.accent,BorderSizePixel=0},bar)
    round(fill,5)
    local hit=make("TextButton",{Size=UDim2.new(1,0,0,24),Position=UDim2.new(0,0,0.5,-12),BackgroundTransparency=1,Text=""},bar)
    local function setFromX(x)
        local ratio=math.clamp((x-bar.AbsolutePosition.X)/math.max(bar.AbsoluteSize.X,1),0,1)
        value=math.floor(min+ratio*(max-min))
        fill.Size=UDim2.new(ratio,0,1,0); val.Text=tostring(value); state[key]=value
    end
    hit.Activated:Connect(function() setFromX(UIS:GetMouseLocation().X) end)
    state[key]=value
    return f
end
local function dropdown(parent,title,desc,key,options,order)
    local f=card(parent,title,desc,order,78)
    local idx=1
    local b=make("TextButton",{Size=UDim2.new(1,-24,0,25),Position=UDim2.fromOffset(12,45),BackgroundColor3=C.card2,Text=options[idx].."   ▾",TextColor3=C.text,Font=Enum.Font.GothamBold,TextSize=10,BorderSizePixel=0},f)
    round(b,6)
    state[key]=options[idx]
    b.Activated:Connect(function()
        idx=idx%#options+1; state[key]=options[idx]; b.Text=options[idx].."   ▾"
    end)
    return f
end
local function note(parent,title,desc,order)
    local f=card(parent,title,desc,order,64)
    return f
end

-- Combate: controles demonstrativos, sem ligar mira automatica ou manipular disparos.
local p=pages["Aimbot"]
note(p,"Aimbot (demo)","Controles ilustrativos; nao altera a mira do jogo.",1)
dropdown(p,"Parte do alvo","Preferencia visual", "aim_part",{"Head","Torso","HumanoidRootPart"},2)
dropdown(p,"Prioridade","Modo de selecao", "aim_priority",{"Crosshair","Distancia","Vida"},3)
dropdown(p,"Modo da tecla","Atalho ilustrativo", "aim_keymode",{"Toggle","Hold"},4)
slider(p,"FOV (demo)","Valor visual de referencia","aim_fov",10,300,150,5)
slider(p,"Distancia maxima (demo)","Valor de referencia","aim_distance",50,1500,500,6)
toggle(p,"Mostrar circulo FOV","Apenas indicador visual","aim_circle",7)
toggle(p,"Alvo visivel (demo)","Preferencia de interface","aim_visible",8)

p=pages["Silent Aim"]
note(p,"Silent Aim (demo)","Aba demonstrativa; nao redireciona tiros nem eventos.",1)
dropdown(p,"Prioridade","Preferencia de exibicao","silent_priority",{"Crosshair","Distancia","Vida"},2)
toggle(p,"Somente visiveis","Estado visual do controle","silent_visible",3)
slider(p,"Distancia maxima","Valor demonstrativo","silent_distance",50,1500,500,4)
toggle(p,"Ativar modulo (demo)","Nao executa Silent Aim","silent_demo",5)

p=pages["Trigger & Rage"]
note(p,"Trigger & Rage (demo)","Botoes de prototipo sem automatizar ataques.",1)
toggle(p,"Triggerbot (demo)","Nao dispara automaticamente","trigger_demo",2)
toggle(p,"Ragebot (demo)","Nao altera comportamento de combate","rage_demo",3)
dropdown(p,"Modo","Preferencia ilustrativa","rage_mode",{"Padrao","Rapido","Personalizado"},4)

p=pages["Gun Mods"]
note(p,"Gun Mods (demo)","Sem alteracao de armas ou projeteis.",1)
toggle(p,"No Recoil (demo)","Apenas estado visual","recoil_demo",2)
toggle(p,"No Spread (demo)","Apenas estado visual","spread_demo",3)

p=pages["Visuais"]
note(p,"Visualizacao de treino","Opcoes para prototipo visual; nao revela jogadores.",1)
toggle(p,"NPC ESP","Destaque de NPCs da sua experiencia","npc_esp",2)
toggle(p,"Nome do NPC","Exibicao de nomes de NPCs","npc_names",3)
toggle(p,"Vida do NPC","Exibicao de vida de NPCs","npc_health",4)
toggle(p,"Distancia do NPC","Exibicao de distancia de NPCs","npc_distance",5)
toggle(p,"Contorno","Contorno de NPCs do seu jogo","npc_outline",6)
dropdown(p,"Cor do ESP","Tema visual","esp_color",{"Vermelho","Verde","Azul","Roxo"},7)
dropdown(p,"Posicao da vida","Layout do indicador","health_position",{"Acima","Abaixo","Dos lados"},8)
toggle(p,"Mostrar equipe (demo)","Nao identifica equipes de outros jogos","team_demo",9)

p=pages["World"]
note(p,"World / Ambiente","Ajustes de ambiente apenas para sua experiencia.",1)
toggle(p,"Fullbright (demo)","Controle visual ilustrativo","fullbright_demo",2)
toggle(p,"No Flash (demo)","Sem efeito em jogos de terceiros","flash_demo",3)
toggle(p,"No Smoke (demo)","Sem efeito em jogos de terceiros","smoke_demo",4)
slider(p,"Brilho (demo)","Valor de referencia","world_brightness",0,100,50,5)
slider(p,"Campo de visao da camera","Valor de referencia","camera_fov",50,120,70,6)

p=pages["Skins"]
note(p,"Skins","Personalizacao ilustrativa para itens do seu proprio jogo.",1)
dropdown(p,"Skin de personagem","Selecao de exemplo","skin_character",{"Padrao","Classica","Neon","Dourada"},2)
dropdown(p,"Faca (demo)","Catalogo ilustrativo","skin_knife",{"Padrao","Vermelha","Azul","Dourada"},3)
dropdown(p,"Luvas (demo)","Catalogo ilustrativo","skin_gloves",{"Padrao","Esportiva","Neon"},4)

p=pages["Gun Skins"]
note(p,"Gun Skins","Catalogo de aparencia para armas da sua experiencia.",1)
dropdown(p,"Arma","Item de exemplo","gun_choice",{"Rifle","Pistola","SMG","Shotgun"},2)
dropdown(p,"Acabamento","Tema visual","gun_finish",{"Padrao","Carbono","Neon","Dourado"},3)
toggle(p,"Preview da skin","Somente demonstracao","gun_preview",4)

p=pages["Misc"]
note(p,"Utilitarios","Opcoes de interface e teste.",1)
toggle(p,"Auto Buy (demo)","Nao realiza compras","autobuy_demo",2)
toggle(p,"Mostrar codigos","Exibe area de codigos local","codes_show",3)
toggle(p,"Modo streamer","Oculta informacoes da interface","streamer_mode",4)
dropdown(p,"Idioma","Idioma do painel","language",{"Portugues","English","Espanol"},5)

p=pages["Settings"]
note(p,"Configuracoes gerais","Preferencias locais do painel.",1)
dropdown(p,"Tema","Aparencia","theme",{"Escuro","Vermelho","Azul"},2)
dropdown(p,"Escala da interface","Tamanho do painel","ui_scale",{"90%","100%","110%","120%"},3)
toggle(p,"Animacoes","Animacoes da interface (demo)","animations",4)
toggle(p,"Abrir ao iniciar","Preferencia local (demo)","startup",5)
note(p,"Atalhos","RightShift: mostrar ou ocultar o FINALMY.",6)

local buttons={}
local function show(name)
    current=name
    heading.Text=string.upper(name)
    subtitle.Text=({
        ["Aimbot"]="Configuracoes de mira • modo demonstracao",
        ["Silent Aim"]="Opcoes ilustrativas • sem redirecionamento de tiros",
        ["Trigger & Rage"]="Controles demonstrativos de combate",
        ["Gun Mods"]="Opcoes ilustrativas de armas",
        ["Visuais"]="Opcoes visuais para NPCs da sua experiencia",
        ["World"]="Ambiente da sua propria experiencia",
        ["Skins"]="Personalizacao de itens",
        ["Gun Skins"]="Aparencia de armas",
        ["Misc"]="Utilitarios e preferencias",
        ["Settings"]="Configuracoes do FINALMY",
    })[name] or "FINALMY"
    for n,pg in pairs(pages) do pg.Visible=(n==name) end
    for n,b in pairs(buttons) do
        b.BackgroundColor3=(n==name) and Color3.fromRGB(61,34,43) or C.side
        b.TextColor3=(n==name) and C.accent or C.muted
    end
end
for i,n in ipairs(names) do
    local b=make("TextButton",{Size=UDim2.new(1,0,0,34),BackgroundColor3=C.side,Text="   "..n,TextXAlignment=Enum.TextXAlignment.Left,TextColor3=C.muted,Font=Enum.Font.GothamBold,TextSize=11,BorderSizePixel=0,LayoutOrder=i},nav)
    round(b,6); buttons[n]=b
    b.Activated:Connect(function() show(n) end)
end
show("Aimbot")

search:GetPropertyChangedSignal("Text"):Connect(function()
    local q=string.lower(search.Text)
    for _,pg in pairs(pages) do
        for _,child in ipairs(pg:GetChildren()) do
            if child:IsA("Frame") then
                local title=child:FindFirstChildWhichIsA("TextLabel")
                child.Visible=(q=="") or (title and string.find(string.lower(title.Text),q,1,true)~=nil)
            end
        end
    end
end)

-- Arrastar pela barra superior
local drag, start, origin
top.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
        drag=true; start=input.Position; origin=window.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if drag and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
        local d=input.Position-start
        window.Position=UDim2.new(origin.X.Scale,origin.X.Offset+d.X,origin.Y.Scale,origin.Y.Offset+d.Y)
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then drag=false end
end)
UIS.InputBegan:Connect(function(input,processed)
    if not processed and input.KeyCode==Enum.KeyCode.RightShift then gui.Enabled=not gui.Enabled end
end)
print("[FINALMY] Interface carregada. RightShift oculta/mostra o painel.")
