Circles = Class{}

require 'Bg'
Timer = require "timer"

function Circles:init()
    self.circle = love.graphics.newImage("graphics/circle70x70.png")
    self.restart = love.graphics.newImage("graphics/restart.png")

    numOfCircles = {3, 4, 5, 4, 6, 5, 6, 7, 7, 8}
    
    circleDiameter = 70
    radius = 35
    adjacency = {}
    adjacencyCount = {}
    adjacencyCountALL = 0
    lineCoordinates = {}
    intersect = 0
    -- creating coordinates for every level for circles
    coordinates = { 
                    -- LEVEL 1
                    {{x = WINDOW_WIDTH / 2 - 170 - radius, y = WINDOW_HEIGHT / 2 + 50},
                    {x = WINDOW_WIDTH / 2 + 170 - radius, y = WINDOW_HEIGHT / 2 + 50}, 
                    {x = WINDOW_WIDTH / 2 - radius, y = WINDOW_HEIGHT / 2 - 170}}, 
                    -- LEVEL 2
                    {{x = WINDOW_WIDTH / 2 - 130 - radius, y = WINDOW_HEIGHT / 2 - 250 }, 
                    {x = WINDOW_WIDTH / 2 + 200 - radius, y = WINDOW_HEIGHT / 2 - 250}, 
                    {x = WINDOW_WIDTH / 2 - 200 - radius, y = WINDOW_HEIGHT / 2 + 250}, 
                    {x = WINDOW_WIDTH / 2 + 130 - radius, y = WINDOW_HEIGHT / 2 + 250}},
                    -- LEVEL 3
                    {{x = WINDOW_WIDTH / 2 - radius, y = WINDOW_HEIGHT / 2 - radius}, 
                    {x = WINDOW_WIDTH / 2 - 250 - radius, y = WINDOW_HEIGHT / 2 - radius}, 
                    {x = WINDOW_WIDTH / 2 + 250 - radius, y = WINDOW_HEIGHT / 2 - radius}, 
                    {x = WINDOW_WIDTH / 2 - 250 - radius, y = WINDOW_HEIGHT / 2 - radius + 250}, 
                    {x = WINDOW_WIDTH / 2 + 250 - radius, y = WINDOW_HEIGHT / 2 - radius - 250}},
                    -- LEVEL 4
                    {{x = WINDOW_WIDTH / 2 - radius, y = WINDOW_HEIGHT / 2 - radius}, 
                    {x = WINDOW_WIDTH / 2 - radius, y = WINDOW_HEIGHT / 2 - radius + 210},
                    {x = WINDOW_WIDTH / 2 - radius - 170, y = WINDOW_HEIGHT / 2 - radius - 200},  
                    {x = WINDOW_WIDTH / 2 - radius + 170, y = WINDOW_HEIGHT / 2 - radius - 200}}, 
                    -- LEVEL 5
                    {{x = WINDOW_WIDTH / 2 - radius, y = WINDOW_HEIGHT / 2 - radius - 50}, 
                    {x = WINDOW_WIDTH / 2 - radius, y = WINDOW_HEIGHT / 2 - radius + 350}, 
                    {x = WINDOW_WIDTH / 2 - 200 - radius, y = WINDOW_HEIGHT / 2 - radius + 150}, 
                    {x = WINDOW_WIDTH / 2 + 200 - radius, y = WINDOW_HEIGHT / 2 - radius + 150}, 
                    {x = WINDOW_WIDTH / 2 - 200 - radius, y = WINDOW_HEIGHT / 2 - radius - 250}, 
                    {x = WINDOW_WIDTH / 2 + 200 - radius, y = WINDOW_HEIGHT / 2 - radius - 250}},
                    -- LEVEL 6
                    {{x = WINDOW_WIDTH / 2 - radius + 80, y = WINDOW_HEIGHT / 2 - radius}, 
                    {x = WINDOW_WIDTH / 2 - radius - 150 + 80, y = WINDOW_HEIGHT / 2 - radius - 150}, 
                    {x = WINDOW_WIDTH / 2 - radius + 150 + 80, y = WINDOW_HEIGHT / 2 - radius + 150}, 
                    {x = WINDOW_WIDTH / 2 - radius - 125 + 80, y = WINDOW_HEIGHT / 2 - radius + 125}, 
                    {x = WINDOW_WIDTH / 2 - 250 - radius + 80, y = WINDOW_HEIGHT / 2 - radius + 250}},
                    -- LEVEL 7 
                    {{x = WINDOW_WIDTH / 2 - radius, y = WINDOW_HEIGHT / 2 - radius + 300}, 
                    {x = WINDOW_WIDTH / 2 - radius, y = WINDOW_HEIGHT / 2 - radius + 200}, 
                    {x = WINDOW_WIDTH / 2 - radius + 150, y = WINDOW_HEIGHT / 2 - radius}, 
                    {x = WINDOW_WIDTH / 2 - radius - 150, y = WINDOW_HEIGHT / 2 - radius}, 
                    {x = WINDOW_WIDTH / 2 - radius, y = WINDOW_HEIGHT / 2 - radius - 200}, 
                    {x = WINDOW_WIDTH / 2 - radius , y = WINDOW_HEIGHT / 2 - radius - 300}},
                    -- LEVEL 8
                    {{x = WINDOW_WIDTH / 2 - radius, y = WINDOW_HEIGHT / 2 - radius - 450}, 
                    {x = WINDOW_WIDTH / 2 - radius - 200, y = WINDOW_HEIGHT / 2 - radius - 300}, 
                    {x = WINDOW_WIDTH / 2 - radius, y = WINDOW_HEIGHT / 2 - radius - 150}, 
                    {x = WINDOW_WIDTH / 2 - radius + 200, y = WINDOW_HEIGHT / 2 - radius}, 
                    {x = WINDOW_WIDTH / 2 - radius, y = WINDOW_HEIGHT / 2 - radius + 150}, 
                    {x = WINDOW_WIDTH / 2 - radius - 200, y = WINDOW_HEIGHT / 2 - radius + 300},
                    {x = WINDOW_WIDTH / 2 - radius, y = WINDOW_HEIGHT / 2 - radius + 450}},
                    -- LEVEL 9
                    {{x = WINDOW_WIDTH / 2 - radius, y = WINDOW_HEIGHT / 2 - radius}, 
                    {x = WINDOW_WIDTH / 2 - radius + 200, y = WINDOW_HEIGHT / 2 - radius - 300}, 
                    {x = WINDOW_WIDTH / 2 - radius - 200, y = WINDOW_HEIGHT / 2 - radius - 300}, 
                    {x = WINDOW_WIDTH / 2 - radius + 100, y = WINDOW_HEIGHT / 2 - radius}, 
                    {x = WINDOW_WIDTH / 2 - radius - 100, y = WINDOW_HEIGHT / 2 - radius}, 
                    {x = WINDOW_WIDTH / 2 - radius + 50, y = WINDOW_HEIGHT / 2 - radius + 300},
                    {x = WINDOW_WIDTH / 2 - radius - 50, y = WINDOW_HEIGHT / 2 - radius + 300}},
                    -- LEVEL 10
                    {{x = WINDOW_WIDTH / 2 - radius, y = WINDOW_HEIGHT / 2 - radius + 300}, 
                    {x = WINDOW_WIDTH / 2 - radius, y = WINDOW_HEIGHT / 2 - radius + 200}, 
                    {x = WINDOW_WIDTH / 2 - radius, y = WINDOW_HEIGHT / 2 - radius + 100}, 
                    {x = WINDOW_WIDTH / 2 - radius, y = WINDOW_HEIGHT / 2 - radius - 100}, 
                    {x = WINDOW_WIDTH / 2 - radius, y = WINDOW_HEIGHT / 2 - radius - 200},
                    {x = WINDOW_WIDTH / 2 - radius, y = WINDOW_HEIGHT / 2 - radius - 300},
                    {x = WINDOW_WIDTH / 2 - radius + 200, y = WINDOW_HEIGHT / 2 - radius - 200},
                    {x = WINDOW_WIDTH / 2 - radius - 200, y = WINDOW_HEIGHT / 2 - radius + 200}} 
                }
    
    self.restartX = WINDOW_WIDTH - circleDiameter - 30
    self.restartY = 30
    isDown = {}
    startX = {}
    startY = {}
    startX_stat = {}
    startY_stat = {}
    self.switch = 1
    level_counter = LEVEL
    
    indexCheckForIntersect1 = 1
    indexCheckForIntersect2 = 1
    oldindexCheckForIntersect1 = 1
    oldindexCheckForIntersect2 = 1
    

    self.counter = 0 
    self.finishedCounter = 0
    self.alphaTransition = 0
    self.alphaTransitionReversed = 255
    self.textColor = {colors[math.floor(WINDOW_HEIGHT / 2)][1] / 255, colors[math.floor(WINDOW_HEIGHT / 2)][2] / 255, colors[math.floor(WINDOW_HEIGHT / 2)][3] / 255}
    fade = 0

    for i = 1, 8 do
        adjacency[i] = {}
        lineCoordinates[i] = {}
        for j = 1, 8 do
            table.insert(adjacency[i], 0)
            table.insert(lineCoordinates[i], {})
        end
        isDown[i] = 0
        startX[i] = 0
        startY[i] = 0
        startX_stat[i] = 0
        startY_stat[i] = 0
        adjacencyCount[i] = 0
        
    end
end

function Circles:update(dt)
    Timer.update(dt)
    -- restart
    if adjacencyCountALL ~= numOfCircles[LEVEL] and love.mouse.isDown(1) and mouseX > self.restartX and mouseX < self.restartX + circleDiameter and mouseY > self.restartY and mouseY < self.restartY + circleDiameter then 
        ding:play()
        intersect = 0
        indexCheckForIntersect1 = 1
        indexCheckForIntersect2 = 1
        oldindexCheckForIntersect1 = 1
        oldindexCheckForIntersect2 = 1
        for i = 1, numOfCircles[LEVEL] do
            -- isDown[i] = 0
            -- startX[i] = 0
            -- startY[i] = 0
            -- startX_stat[i] = 0
            -- startY_stat[i] = 0
            adjacencyCount[i] = 0
            for j = 1, numOfCircles[LEVEL] do
                adjacency[i][j] = 0
                lineCoordinates[i][j] = {}
            end
        end
        adjacencyCountALL = 0
        -- lineCoordinates = {}
    end

    if adjacencyCountALL == numOfCircles[LEVEL] then
        if fade ~= 2 then
            fade = 1
        end
        if fade == 1 then
            if self.alphaTransition > 130 then
                completedLevel:play()
            end
            if self.alphaTransition <= 100 then
                self.alphaTransition = math.lerp(self.alphaTransition, 255, dt) * 1.001
                self.alphaTransitionReversed = math.lerp(self.alphaTransitionReversed, 0, dt) / 1.07
            elseif self.alphaTransition < 253 then
                self.alphaTransition = math.lerp(self.alphaTransition, 255, dt) * 1.007
                self.alphaTransitionReversed = math.lerp(self.alphaTransitionReversed, 0, dt) / 1.07
            end
            
            if self.alphaTransition >= 253 then
                self.alphaTransition = 255
                self.alphaTransitionReversed = 0
                if LEVEL < 10 then
                    if self.switch == 1 then
                        LEVEL = LEVEL + 1
                        self.switch = 0
                    end
                    Timer.after(1, function()
                        for i = 1, numOfCircles[LEVEL] do
                            adjacencyCount[i] = 0
                            for j = 1, numOfCircles[LEVEL] do
                                adjacency[i][j] = 0
                                lineCoordinates[i][j] = {}
                            end
                        end
                        bg = Bg()
                        fade = 2
                    end)
                else
                    Timer.after(1, function()
                    bg = Bg()
                    WIN = 1
                    fade = 2
                    end)
                end
            end
        end
    end
    if fade == 2 then
        adjacencyCountALL = 0
        if self.alphaTransition >= 150 then
            self.alphaTransition = math.lerp(self.alphaTransition, 0, dt) / 1.007
            self.alphaTransitionReversed = math.lerp(self.alphaTransitionReversed, 255, dt) * 1.05
        elseif self.alphaTransition >= 75 then
            self.alphaTransition = math.lerp(self.alphaTransition, 0, dt) / 1.015
            self.alphaTransitionReversed = math.lerp(self.alphaTransitionReversed, 255, dt) * 1.008
        else
            self.alphaTransition = math.lerp(self.alphaTransition, 0, dt) / 1.035
            self.alphaTransitionReversed = math.lerp(self.alphaTransitionReversed, 255, dt) * 1.002
        end
        if self.alphaTransition <= 8 then
            self.alphaTransition = 0
            if self.alphaTransitionReversed >= 245 then
                self.switch = 1
                self.alphaTransitionReversed = 255
                level_counter = level_counter + 1
                fade = 0
            end
        end
    end
end

function Circles:render()
    love.graphics.setColor(1, 1, 1, self.alphaTransition / 255)
    love.graphics.setFont(simplificaFont75)
    love.graphics.rectangle("fill", 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)
    if fade == 0 then
        self.textColor = {colors[math.floor(WINDOW_HEIGHT / 2)][1] / 255, colors[math.floor(WINDOW_HEIGHT / 2)][2] / 255, colors[math.floor(WINDOW_HEIGHT / 2)][3] / 255} 
    end
    love.graphics.setColor( self.textColor[1], self.textColor[2], self.textColor[3], self.alphaTransition / 255)
    love.graphics.print("Level " .. level_counter .. " Completed", WINDOW_WIDTH / 2 - 180, WINDOW_HEIGHT / 2 - 50)
    
    love.graphics.setColor(1, 1, 1, 1)

    if fade ~= 0 then
        love.graphics.setColor(1, 1, 1, self.alphaTransitionReversed / 255)
    end

    love.graphics.setLineWidth(7)
    if WIN == 0 then
        for i = 1, numOfCircles[LEVEL] do
            love.graphics.draw(self.circle, coordinates[LEVEL][i].x, coordinates[LEVEL][i].y)
        end
        love.graphics.draw(self.restart, self.restartX, self.restartY)
    end
    mouseX, mouseY = love.mouse.getPosition()
    
    for i = 1, numOfCircles[LEVEL] do
        for j = 1, numOfCircles[LEVEL] do
            if i ~= j and fade ~= 2 and adjacency[i][j] == 1 and adjacencyCount[i] <= 2 and adjacencyCount[j] <= 2 and lineCoordinates[i][j].x1 ~= nil then
                love.graphics.line(lineCoordinates[i][j].x1, lineCoordinates[i][j].y1, lineCoordinates[i][j].x2, lineCoordinates[i][j].y2)
            end
        end
    end

    for i = 1, numOfCircles[LEVEL] do
        self.counter = 0
        for j = 1, numOfCircles[LEVEL] do
            if isDown[j] == 0 then
                self.counter = self.counter + 1
            end
        end
        if self.counter == numOfCircles[LEVEL] and isDown[i] == 0 and love.mouse.isDown(1) and mouseX > coordinates[LEVEL][i].x and mouseX < coordinates[LEVEL][i].x + circleDiameter and mouseY > coordinates[LEVEL][i].y and mouseY < coordinates[LEVEL][i].y + circleDiameter then
            isDown[i] = 1
        end
        if isDown[i] == 1 and fade ~= 2 then
            N = math.sqrt((mouseX * mouseX) - 2 * (mouseX * (coordinates[LEVEL][i].x + radius)) + ((coordinates[LEVEL][i].x + radius)  * (coordinates[LEVEL][i].x + radius) ) + (mouseY * mouseY) - 2 * (mouseY * (coordinates[LEVEL][i].y + radius)) + ((coordinates[LEVEL][i].y + radius) * (coordinates[LEVEL][i].y + radius)))
            startX[i] = (coordinates[LEVEL][i].x + radius) + ((mouseX - (coordinates[LEVEL][i].x + radius)) * radius) / N
            startY[i] = (coordinates[LEVEL][i].y + radius) + ((mouseY - (coordinates[LEVEL][i].y + radius)) * radius) / N
            love.graphics.line(startX[i], startY[i], mouseX, mouseY)
        end
        
    end
    -- love.graphics.print(intersect, WINDOW_WIDTH - 100, WINDOW_HEIGHT - 100)
end

function love.mousereleased(x, y, button)
    if LEVEL ~= 0 then
        for i = 1, numOfCircles[LEVEL] do
            if fade == 0 and button == 1 and isDown[i] == 1 then
                for j = 1, numOfCircles[LEVEL] do
                    if i ~= j and adjacency[i][j] ~= 1 and adjacency[j][i] ~= 1 then
                        
                        
                        if adjacencyCount[i] <= 1 and adjacencyCount[j] <= 1 and love.mouse.getX() > coordinates[LEVEL][j].x and love.mouse.getX() < coordinates[LEVEL][j].x + circleDiameter and mouseY > coordinates[LEVEL][j].y and mouseY < coordinates[LEVEL][j].y + circleDiameter then     
                            oldindexCheckForIntersect1 = indexCheckForIntersect1
                            oldindexCheckForIntersect2 = indexCheckForIntersect2
                            P = math.sqrt(((coordinates[LEVEL][i].x + radius) * (coordinates[LEVEL][i].x + radius)) - 2 * ((coordinates[LEVEL][i].x + radius) * (coordinates[LEVEL][j].x + radius)) + ((coordinates[LEVEL][j].x + radius)  * (coordinates[LEVEL][j].x + radius) ) + ((coordinates[LEVEL][i].y + radius) * (coordinates[LEVEL][i].y + radius)) - 2 * ((coordinates[LEVEL][i].y + radius) * (coordinates[LEVEL][j].y + radius)) + ((coordinates[LEVEL][j].y + radius) * (coordinates[LEVEL][j].y + radius)))
                            startX_stat[j] = math.floor((coordinates[LEVEL][j].x + radius) + (((coordinates[LEVEL][i].x + radius) - (coordinates[LEVEL][j].x + radius)) * radius) / P)
                            startY_stat[j] = math.floor((coordinates[LEVEL][j].y + radius) + (((coordinates[LEVEL][i].y + radius) - (coordinates[LEVEL][j].y + radius)) * radius) / P)
                            
                            M = math.sqrt(((coordinates[LEVEL][j].x + radius) * (coordinates[LEVEL][j].x + radius)) - 2 * ((coordinates[LEVEL][j].x + radius) * (coordinates[LEVEL][i].x + radius)) + ((coordinates[LEVEL][i].x + radius)  * (coordinates[LEVEL][i].x + radius) ) + ((coordinates[LEVEL][j].y + radius) * (coordinates[LEVEL][j].y + radius)) - 2 * ((coordinates[LEVEL][j].y + radius) * (coordinates[LEVEL][i].y + radius)) + ((coordinates[LEVEL][i].y + radius) * (coordinates[LEVEL][i].y + radius)))
                            startX_stat[i] = math.floor((coordinates[LEVEL][i].x + radius) + (((coordinates[LEVEL][j].x + radius) - (coordinates[LEVEL][i].x + radius)) * radius) / M)
                            startY_stat[i] = math.floor((coordinates[LEVEL][i].y + radius) + (((coordinates[LEVEL][j].y + radius) - (coordinates[LEVEL][i].y + radius)) * radius) / M)
                            
                            lineCoordinates[i][j] = { x1 = startX_stat[i], y1 = startY_stat[i], x2 = startX_stat[j], y2 = startY_stat[j]}
                            -- lineCoordinates[j][i] = { x1 = startX_stat[i], y1 = startY_stat[i], x2 = startX_stat[j], y2 = startY_stat[j]}
                            indexCheckForIntersect1 = i        
                            indexCheckForIntersect2 = j
                            
                            if lineCoordinates[indexCheckForIntersect1][indexCheckForIntersect2].x1 ~= nil then
                                X1 = lineCoordinates[indexCheckForIntersect1][indexCheckForIntersect2].x1
                                Y1 = lineCoordinates[indexCheckForIntersect1][indexCheckForIntersect2].y1
                                X2 = lineCoordinates[indexCheckForIntersect1][indexCheckForIntersect2].x2
                                Y2 = lineCoordinates[indexCheckForIntersect1][indexCheckForIntersect2].y2   
                        
                                for k = 1, numOfCircles[LEVEL] do
                                    for p = 1, numOfCircles[LEVEL] do
                                        if k ~= p and lineCoordinates[k][p].x1 ~= nil then
                                            -- seccond line
                                            X3 = lineCoordinates[k][p].x1
                                            Y3 = lineCoordinates[k][p].y1
                                            X4 = lineCoordinates[k][p].x2
                                            Y4 = lineCoordinates[k][p].y2
                                            
                                            if (X1 ~= X3 and X2 ~= X4) and (Y1 ~= Y3 and Y2 ~= Y4) then
                                                if (X1 - X2 == 0) or (X3 - X4 == 0) then                -- FIX BUG IN LEVEL 10 = MAYBE DIVIDING BY ZERO 
                                                    A1 = (Y1 - Y2) / 1
                                                    A2 = (Y3 - Y4) / 1
                                                else
                                                    A1 = (Y1 - Y2) / (X1 - X2)
                                                    A2 = (Y3 - Y4) / (X3 - X4)
                                                end
                                                b1 = Y1 - A1 * X1
                                                b2 = Y3 - A2 * X3
                                                Xa = (b2 - b1) / (A1 - A2)
                                                if A1 == A2 and intersect == 0 then
                                                    intersect = 0
                                                elseif math.max(X1,X2) < math.min(X3,X4) and intersect == 0 then
                                                    intersect = 0
                                                elseif (Xa < math.max( math.min(X1,X2), math.min(X3,X4) ) or Xa > math.min( math.max(X1,X2), math.max(X3,X4) )) and intersect == 0 then
                                                    intersect = 0
                                                else
                                                    intersect = 1
                                                    break
                                                end
                                            end
                                        end
                                    end
                                end
                                if intersect == 0 then
                                    click:play()
                                    adjacencyCount[i] = adjacencyCount[i] + 1
                                    adjacencyCount[j] = adjacencyCount[j] + 1
                                    adjacencyCountALL = adjacencyCountALL + 1
                                    adjacency[i][j] = 1
                                    adjacency[j][i] = 1
                                    
                                end
                            end
                        end
                        
                    end
                end
            end
        end
        intersect = 0
        
        for z = 1, numOfCircles[LEVEL] do
            isDown[z] = 0
        end
    else
        if love.mouse.getX() > WINDOW_WIDTH / 2 - 72 and love.mouse.getX() < WINDOW_WIDTH / 2 + 72 and love.mouse.getY() > WINDOW_HEIGHT / 2 - 100 and love.mouse.getY() < WINDOW_HEIGHT / 2 + 100 then
            click:play()
            LEVEL = 1
            level_counter = 1
        end
    end
end





-- DEBUGING TOOLS
    -- love.graphics.print(indexCheckForIntersect1, 10, 10)
    -- love.graphics.print(indexCheckForIntersect2, 10, 100)
    -- for i = 1, numOfCircles[LEVEL] do
    --     for j = 1, numOfCircles[LEVEL] do
            -- if lineCoordinates[i][j].x1 ~= nil then
            -- if lineCoordinates[indexCheckForIntersect1][indexCheckForIntersect2].x1 ~= nil then
            --     -- love.graphics.print(lineCoordinates[i][j].x1 .. ", " .. lineCoordinates[i][j].y1 .. ", " .. lineCoordinates[i][j].x2 .. ", " .. lineCoordinates[i][j].y2, 200 * j - 180, 80 * i)
            --     love.graphics.print(lineCoordinates[indexCheckForIntersect1][indexCheckForIntersect2].x1)
            -- else
            --     love.graphics.print("nil")
            -- end
    --     end
    -- end
    -- for i = 1, numOfCircles[LEVEL] do
    --     for j = 1, numOfCircles[LEVEL] do
    --         love.graphics.print(adjacency[i][j], 100 * j, 100 * i - 80)
    --     end
    -- end


-- function findIntersect(l1p1x,l1p1y, l1p2x,l1p2y, l2p1x,l2p1y, l2p2x,l2p2y, seg1, seg2)
-- 	local a1,b1,a2,b2 = l1p2y-l1p1y, l1p1x-l1p2x, l2p2y-l2p1y, l2p1x-l2p2x
-- 	local c1,c2 = a1*l1p1x+b1*l1p1y, a2*l2p1x+b2*l2p1y
-- 	local det,x,y = a1*b2 - a2*b1
-- 	if det==0 then return true end  -- dont intersect = paraller
-- 	x,y = (b2*c1-b1*c2)/det, (a1*c2-a2*c1)/det
-- 	if seg1 or seg2 then
-- 		local min,max = math.min, math.max
-- 		if seg1 and not (min(l1p1x,l1p2x) <= x and x <= max(l1p1x,l1p2x) and min(l1p1y,l1p2y) <= y and y <= max(l1p1y,l1p2y)) or
-- 		   seg2 and not (min(l2p1x,l2p2x) <= x and x <= max(l2p1x,l2p2x) and min(l2p1y,l2p2y) <= y and y <= max(l2p1y,l2p2y)) then
-- 			return true        -- dont intersect = paraller
-- 		end
-- 	end
-- 	return false
-- end