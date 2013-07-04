service = ($http, $window, $q) ->
    Routing = $window.Routing
    S = {}

    # properties
    S.list =
        values: {}
        getLength: ->
            size = 0
            entries = S.list.values
            for key, value of entries
                if entries.hasOwnProperty key
                    size++
            return size

    # methods
    S.query = ($s) ->
        S.list.values = {}

        deferred = $q.defer()
        setTimeout(->
            $s.$apply ->
                for i in [1..10]
                    shit =
                        id: i
                        value: "#{i}: #{S.getValue()}"

                    S.list.values[shit.id] = shit

                deferred.resolve(S.list)
        , S.getRandom(250, 1000))
        return deferred.promise
    S.delete = ($s, shit) ->
        deferred = $q.defer()
        setTimeout( ->
            $s.$apply ->
                delete S.list.values[shit.id]
                deferred.resolve()
        , S.getRandom(50, 250))

        return deferred.promise
    S.getValue = ->
        characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
        length = characters.length
        value = ''
        for i in [1..10]
            value += characters.charAt Math.floor(Math.random() * length)
        return value
    S.getRandom = (min, max) ->
        return Math.random() * (max - min) + min

    return S
service.$inject = ['$http', '$window', '$q']
window.module.service 'BullshitService', service