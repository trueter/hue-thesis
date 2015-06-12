angular.module('HueThesis').service '$visualizer', class VisualizerService

    constructor :  ( $rootScope, $interval, $hue ) ->

        @song = null
        elements = [ 'bars', 'beats', 'sections' ] #'segments', 'tatums'

        $rootScope.$on 'song:select', ( e, song ) =>

            latency = 250

            start = new Date() - latency

            for e in elements
                for i, idx in song.analysis[e] when i.confidence > 0.3

                    do ( item = i, element = e, index = idx ) ->

                        diff = new Date() - start

                        setTimeout ->
                            $rootScope.$emit 'song:event',
                                type     : element.slice(0,-1)
                                duration : item.duration
                                index    : index
                                start    : item.start
                                confidence : item.confidence


                        , item.start * 1000 - diff



        bassColors = [50000]#, 0]
        barColors = [0, 20000, 35000]
        barColorIndex = 0
        lampIndex = 0

        $rootScope.$on 'song:select', ->

            def =
                on : true
                bri : 128
            $hue.set 2, def
            $hue.set 1, def
            $hue.set 0, def
            $hue.set 3, def
#        $hue.set 2, hue : 30000
#        $hue.set 3, hue : 50000

        latestBassBri = 0

        li = ( n ) ->
            ( lampIndex + n ) % 4

        $rootScope.$on 'song:event', ( ctx, e ) ->

            if e.type is 'beat'
                if e.confidence > 0.7
                    color = bassColors[e.index % bassColors.length]
                    console.log "beat", color
                    latestBassBri += 62

                    $hue.set li(1),
                        hue : color
                        bri : ( latestBassBri ) % 255
                    $hue.set li(2),
                        hue : color
                        bri : ( latestBassBri ) % 255

            if e.type is 'bar'

                #color = barColor[e.index % barColor.length]

                $hue.set li(3), hue: barColors[barColorIndex % barColors.length]
                $hue.set li(4), hue: barColors[barColorIndex % barColors.length]

#
            if e.type is 'section'
                barColorIndex++
                lampIndex++




#
#
#            $interval ->
#                $rootScope.$emit 'song:event',
#                    type : "beat"
#                    time : +new Date()
#                    duration : 0.15
#            , 1000
#            $interval ->
#                  $rootScope.$emit 'song:event',
#                      type : "bar"
#                      time : +new Date()
#                      duration : 4
#            , 4002
#            $interval ->
#                  $rootScope.$emit 'song:event',
#                      type : "section"
#                      time : +new Date()
#                      duration : 0.5
#            , 8000
#
