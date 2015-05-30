hueBulbs = [ 'LCT001' ]
livingColors = [
    'LLC006'
    'LLC007'
]

angular.module('HueThesis').service '$hue', class HueService


    ip : '192.168.0.16'

    user : 'newdeveloper'

    _lights : []


    constructor :  ( $rootScope, $http, $q, config, $console ) ->

        q = $q.defer()


        @lights = ->
            q.promise

        @sync = ->

            if q.promise.$$state.status is 1
                q = $q.defer()


            @api = "http://#{ @ip }/api/#{ @user }/"

            $http.get( @api + "lights" ).then ( resp ) =>

                lights = []
                for k, v of resp.data
                    lights.push v

                q.resolve lights

                @_lights = (l.state for l in lights)
                q

            , ( err ) -> q.reject err

            @



        @toggleAll = ->

            for l, i in @_lights
                @set i, on: ! l.on


        @set = ( n, data ) ->
            console.log "set"
            data = @normalize n, data

            console.log JSON.stringify data

            promise = $http.put "http://#{ @ip }/api/#{ @user }/lights/" + ( n + 1 ) + "/state", data

            promise.then ( resp ) =>
                for d in resp.data
#                    console.log "itereate data point"
                    for k, v of d.success
#                        console.log "itereate success"
                        [ prefix, path ] = k.split '/state/'
#                        console.log 'path', path
#                        console.log 'v', v
#                        console.log "prev", @_lights[ n ][ path ]

                        if path not in ['effect']
                            @_lights[ n ][ path ] = v

            , ( err ) ->
                #console.error err


        @sync()



    normalize : ( n, data ) ->

        for k, v of data
            if k is 'hue'
                if v > 65535
                    v = v -  65535 while v > 65535
                    data.hue = v


            if k is 'on'
                if v is @_lights[ n ].on
                    delete data.on


        data.transitiontime ?= 0
        data



    # https://github.com/Q42/hue-color-converter
    xyBriToRgb : ( xyb ) ->
        if 0 > xyb.x or xyb.x > .8
            throw 'x property must be between 0 and .8, but is: ' + xyb.x
        if 0 > xyb.y or xyb.y > 1
            throw 'y property must be between 0 and 1, but is: ' + xyb.y
        if 0 > xyb.bri or xyb.bri > 1
            throw 'bri property must be between 0 and 1, but is: ' + xyb.bri
        x = xyb.x
        y = xyb.y
        z = 1.0 - x - y
        Y = xyb.bri
        X = Y / y * x
        Z = Y / y * z
        r = X * 1.612 - Y * 0.203 - Z * 0.302
        g = -X * 0.509 + Y * 1.412 + Z * 0.066
        b = X * 0.026 - Y * 0.072 + Z * 0.962
        r = if r <= 0.0031308 then 12.92 * r else (1.0 + 0.055) * r ** (1.0 / 2.4) - 0.055
        g = if g <= 0.0031308 then 12.92 * g else (1.0 + 0.055) * g ** (1.0 / 2.4) - 0.055
        b = if b <= 0.0031308 then 12.92 * b else (1.0 + 0.055) * b ** (1.0 / 2.4) - 0.055

        cap = ( x ) ->
            Math.max 0, Math.min(1, x)

        return {
            r: cap(r)
            g: cap(g)
            b: cap(b)
        }

    rgbToXyBri : (rgb) ->
        if 0 > rgb.r or rgb.r > 1 or 0 > rgb.g or rgb.g > 1 or 0 > rgb.b or rgb.b > 1
            throw 'r, g, and, b properties must be between 0 and 1'
        red = rgb.r
        green = rgb.g
        blue = rgb.b
        r = if red > 0.04045 then ((red + 0.055) / (1.0 + 0.055)) ** 2.4 else red / 12.92
        g = if green > 0.04045 then ((green + 0.055) / (1.0 + 0.055)) ** 2.4 else green / 12.92
        b = if blue > 0.04045 then ((blue + 0.055) / (1.0 + 0.055)) ** 2.4 else blue / 12.92
        X = r * 0.649926 + g * 0.103455 + b * 0.197109
        Y = r * 0.234327 + g * 0.743075 + b * 0.022598
        Z = r * 0.0000000 + g * 0.053077 + b * 1.035763
        cx = X / (X + Y + Z)
        cy = Y / (X + Y + Z)
        if isNaN(cx)
            cx = 0.0
        if isNaN(cy)
            cy = 0.0

        return {
            x: cx
            y: cy
            bri: Y
        }

    rgbToHexString : (rgb) ->

        f : (x) ->
            x = Math.round(x * 255)
            s = '0' + x.toString(16)
            s.substr -2

        f(rgb.r) + f(rgb.g) + f(rgb.b)

    hexStringToRgb : (s) ->
        {
        r: parseInt(s.substring(0, 2), 16) / 255
        g: parseInt(s.substring(2, 4), 16) / 255
        b: parseInt(s.substring(4, 6), 16) / 255
        }

    hexStringToXyBri : (s) ->
        rgbToXyBri hexStringToRgb(s)

    triangleForModel : (model) ->
        if hueBulbs.indexOf(model) > -1
            {
            r:
                x: .675
                y: .322
            g:
                x: .4091
                y: .518
            b:
                x: .167
                y: .04
            }
        else if livingColors.indexOf(model) > -1
            {
            r:
                x: .704
                y: .296
            g:
                x: .2151
                y: .7106
            b:
                x: .138
                y: .08
            }
        else
            {
            r:
                x: 1
                y: 0
            g:
                x: 0
                y: 1
            b:
                x: 0
                y: 0
            }

    crossProduct : (p1, p2) ->
        p1.x * p2.y - p1.y * p2.x

    isPointInTriangle : (p, triangle) ->
        red = triangle.r
        green = triangle.g
        blue = triangle.b
        v1 =
            x: green.x - red.x
            y: green.y - red.y
        v2 =
            x: blue.x - red.x
            y: blue.y - red.y
        q =
            x: p.x - red.x
            y: p.y - red.y
        s = crossProduct(q, v2) / crossProduct(v1, v2)
        t = crossProduct(v1, q) / crossProduct(v1, v2)
        s >= 0.0 and t >= 0.0 and s + t <= 1.0

    closestPointOnLine : (a, b, p) ->
        ap =
            x: p.x - a.x
            y: p.y - a.y
        ab =
            x: b.x - a.x
            y: b.y - a.y
        ab2 = ab.x * ab.x + ab.y * ab.y
        ap_ab = ap.x * ab.x + ap.y * ab.y
        t = ap_ab / ab2
        t = Math.min(1, Math.max(0, t))
        {
        x: a.x + ab.x * t
        y: a.y + ab.y * t
        }

    distance : (p1, p2) ->
        dx = p1.x - p2.x
        dy = p1.y - p2.y
        dist = Math.sqrt(dx * dx + dy * dy)
        dist

    xyForModel : (xy, model) ->
        triangle = triangleForModel(model)
        if isPointInTriangle(xy, triangle)
            return xy
        pAB = closestPointOnLine(triangle.r, triangle.g, xy)
        pAC = closestPointOnLine(triangle.b, triangle.r, xy)
        pBC = closestPointOnLine(triangle.g, triangle.b, xy)
        dAB = distance(xy, pAB)
        dAC = distance(xy, pAC)
        dBC = distance(xy, pBC)
        lowest = dAB
        closestPoint = pAB
        if dAC < lowest
            lowest = dAC
            closestPoint = pAC
        if dBC < lowest
            lowest = dBC
            closestPoint = pBC
        closestPoint

    xyBriForModel : (xyb, model) ->
        xy = xyForModel(xyb, model)
        {
        x: xy.x
        y: xy.y
        bri: xyb.bri
        }



# ---
# generated by js2coffee 2.0.3