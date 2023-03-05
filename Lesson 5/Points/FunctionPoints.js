function getStarPoints(centerX, centerY, outerRadius, innerRadius, points) {
    var angle = Math.PI / points
    var result = []
    for (var i = 0; i < 2 * points; i++) {
        var r = (i % 2 == 0) ? outerRadius : innerRadius
        var currX = centerX + r * Math.sin(i * angle)
        var currY = centerY + r * Math.cos(i * angle)
        result.push(currX)
        result.push(currY)
    }
    return result
}

function getRingPoints(centerX, centerY, radius, thickness) {
    var innerRadius = radius - thickness
    var outerPoints = getStarPoints(centerX, centerY, radius, innerRadius, 50)
    var innerPoints = getStarPoints(centerX, centerY, innerRadius, radius, 50)
    return outerPoints.concat(innerPoints)
}

function getHousePoints(centerX, centerY, width, height) {
    var roofHeight = height / 2
    var roofWidth = width / 2
    var result = []
    result.push(centerX - roofWidth, centerY)
    result.push(centerX, centerY - height / 2)
    result.push(centerX + roofWidth, centerY)
    result.push(centerX + roofWidth, centerY + roofHeight)
    result.push(centerX - roofWidth, centerY + roofHeight)
    return result
}

function getHourglassPoints(centerX, centerY, width, height) {
    var result = []
    result.push(centerX - width / 2, centerY - height / 2)
    result.push(centerX + width / 2, centerY - height / 2)
    result.push(centerX, centerY)
    result.push(centerX - width / 2, centerY + height / 2)
    result.push(centerX + width / 2, centerY + height / 2)
    return result
}
