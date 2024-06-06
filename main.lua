-- Projeto Lab18-Persistência
lume = require('lume')

local LK = love.keyboard.isDown
local LG = love.graphics
personagem = {}
carteira = {}

function love.load()
  LG.setFont(LG.newFont(16))
  Inicia()
end

function love.draw()
  LG.draw(personagem.img, personagem.x, personagem.y, 0, personagem.esc, personagem.esc, personagem.img:getWidth()/
    2, personagem.img:getHeight()/2)
  for c, atual in ipairs(carteira) do
    LG.draw(atual.img, atual.x, atual.y, 0, 1, 1, atual.img:getWidth()/2, atual.img:getHeight()/2)
  end
end

function Inicia()
  personagem = {x=30, y=50, tam=50, esc=1, img=nil, v=200}
  carteira = {}
  math.randomseed(os.time())
  personagem.img = LG.newImage('coletor.png')
  moeda = LG.newImage('bitcoin.png')
  for c=1, 25 do
    table.insert(carteira, {
        x = math.random(50, LG.getWidth() - 50),
        y = math.random(50, LG.getHeight() - 50),
        img = moeda,
        tam = 25
      }
    )
  end
end

function love.update(dt)
  if LK('i') then
    Inicia()
  end
  if LK('escape') then
    love.event.quit()
  end
  if LK('left') and personagem.x > personagem.tam / 2 then
    personagem.x = personagem.x - personagem.v * dt
  elseif LK('right') and personagem.x < LG.getWidth() - personagem.tam / 2 then
    personagem.x = personagem.x + personagem.v * dt
  end
  if LK ('up') and personagem.y > personagem.tam / 2 then
    personagem.y = personagem.y - personagem.v * dt
  elseif LK('down') and personagem.y < LG.getHeight() - personagem.tam / 2 then
    personagem.y = personagem.y +  personagem.v * dt
end
for c = #carteira, 1, -1 down
  if temColisao(personagem, carteira[c]) then 
    table.remove(carteira, c)

end

function temColisao(p1, p2)
  local dist = math.sqrt((p1.x-p2.x)^(p1.y-p2.y)^2)