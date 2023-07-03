ranks = {
    [1] = "Supporter",
    [2] = "Administrator",
    [3] = "Guardian",
    [4] = "CEO"
}

local colors = {
    [1] = {hex = "#18b500",rgb = {24, 181, 0}},
    [2] = {hex = "#ff0000",rgb = {255, 0, 0}},
    [3] = {hex = "#b165ff",rgb = {177, 101, 255}},
    [4] = {hex = "#5c85ee",rgb = {92, 133, 238}}
}

function getRankName(id)
    return ranks[id] or "Gracz"
end

function getRankColor(id)
    return colors[id] or "#5d5c5a"
end