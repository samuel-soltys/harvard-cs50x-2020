Bg = Class{}

function Bg:init()
    colors = {}
    for i = 1, WINDOW_HEIGHT do
        colors[i] = {0, 0, 0}
    end

    -- BG colors for all levels
    self.startColor = { {254, 137, 99}, 
                        {229, 196, 182}, 
                        {176, 106, 179},
                        {155, 185, 190},
                        {130, 15, 100},
                        {155, 185, 210},
                        {247, 187, 151},
                        {220, 227, 91},
                        {255, 106, 0},
                        {183, 248, 219} }
    self.endColor = { {213, 48, 72},
                    {165, 166, 197},
                    {69, 104, 220},
                    {250, 240, 213},
                    {250, 80, 57},
                    {237, 231, 226},
                    {221, 94, 137},
                    {69, 182, 73},
                    {238, 9, 121},
                    {80, 167, 194}}
    if LEVEL >= 1 then
        if WIN == 0 then
            calculateColors(self.startColor[LEVEL], self.endColor[LEVEL], WINDOW_HEIGHT)
        else
            love.graphics.setBackgroundColor(1, 1, 1)
        end
    else
        calculateColors({255, 81, 47}, {221, 36, 118}, WINDOW_HEIGHT)
    end
end


function calculateColors(startColor, endColor, steps)
    for i = 0, steps - 1 do
        colors[i] = {startColor[1] + ( endColor[1] - startColor[1] ) * (i / (steps - 1)),
        startColor[2] + ( endColor[2] - startColor[2] ) * (i / (steps - 1)), 
        startColor[3] + ( endColor[3] - startColor[3] ) * (i / (steps - 1))}
    end
end

function Bg:render()
    if WIN == 0 then
        for i = 0, WINDOW_HEIGHT do
            love.graphics.setColor(colors[i][1] / 255, colors[i][2] / 255, colors[i][3] / 255, 1)
            love.graphics.rectangle("fill", 0, i, WINDOW_WIDTH, 1)
            love.graphics.setColor(1, 1, 1, 1)
        end
    end
end