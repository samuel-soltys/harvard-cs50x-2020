Screens = Class{}

Timer = require "timer"

function Screens:init()
    play = love.graphics.newImage("graphics/play.png")
    self.alpha = 0
    self.alpha2 = 0
end

function Screens:update(dt)
    Timer.update(dt)
    if WIN == 1 then
        Timer.after(5, function()
        self.alpha = math.lerp(self.alpha, 255, dt)
        end)
        Timer.after(10, function()
            self.alpha2 = math.lerp(self.alpha2, 255, dt)
        end)
    end
end

function Screens:render()
    if LEVEL <= 0 then
        love.graphics.setFont(simplificaFont100)
        love.graphics.setLineWidth(3)
        love.graphics.circle("line", 300, 370 - 50, 15)
        love.graphics.line(290, 310, 235, 285)
        love.graphics.line(310, 370 - 10 - 50, 360, 335 - 50)
        love.graphics.circle("line", 370, 407 - 50, 15)
        love.graphics.line(312, 370 + 8 - 50, 380 - 22, 407 - 8 - 50)
        love.graphics.print("C i r c u i t", WINDOW_WIDTH / 2 - 140, WINDOW_HEIGHT / 2 - 430)

        love.graphics.draw(play, WINDOW_WIDTH / 2 - 36, WINDOW_HEIGHT / 2 - 50)
        love.graphics.setFont(simplificaFont50)
        love.graphics.print("By: Samuel Soltys", WINDOW_WIDTH - 250, WINDOW_HEIGHT - 70)
        love.graphics.print("Harvard CS50x Final Project", WINDOW_WIDTH / 2 - 180, WINDOW_HEIGHT / 2 + 250)
    elseif WIN == 1 then
        love.graphics.setFont(simplificaFont100)
        love.graphics.setColor(0, 0, 0, self.alpha / 255)
        love.graphics.print("Y o u  W I N !", WINDOW_WIDTH / 2 - 170, WINDOW_HEIGHT / 2 - 75)
        love.graphics.print("Y o u  W I N !", WINDOW_WIDTH / 2 - 170 - 2, WINDOW_HEIGHT / 2 - 75)
        love.graphics.print(vv"Y o u  W I N !", WINDOW_WIDTH / 2 - 170 - 3, WINDOW_HEIGHT / 2 - 75)
        love.graphics.setFont(simplificaFont50)
        love.graphics.setColor(0, 0, 0, self.alpha2 / 255)
        love.graphics.print("Thank you for playing :D", WINDOW_WIDTH / 2 - 165, WINDOW_HEIGHT / 2 + 200)
    end
end