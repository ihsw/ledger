module = window.module
module.service 'ItemService', ['$http', '$window', ($http, $window) ->
    Routing = $window.Routing
    S = {}

    # properties
    S.list = []
    S.idIndex = []

    # functions
    S.query = ->
        S.list = []
        S.idIndex = []

        $http.get(Routing.generate('items')).then (response) ->
            for i, item of response.data
                S.list.push item
                S.idIndex.push item.id

            return S.list
    S.create = (item) ->
        $http.post(Routing.generate('item_create'), item).then (response) ->
            item = response.data
            S.idIndex.push item.id
            S.list.push item

            return item
    S.delete = (item) ->
        $http.delete(Routing.generate('item_delete', { itemId: item.id })).then (response) ->
            i = S.idIndex.indexOf item.id
            if i < 0
                return

            S.list.splice i, 1
            S.idIndex.splice i, 1

    return S
]
module.service 'EntryService', ['$http', '$window', ($http, $window) ->
    Routing = $window.Routing
    S = {}

    # properties
    S.list = []
    S.idIndex = []

    # functions
    S.query = ->
        S.list = []
        S.idIndex = []

        $http.get(Routing.generate('entries')).then (response) ->
            for i, entry of response.data
                entry['occurred_at'] = new Date entry['occurred_at']
                S.list.push entry
                S.idIndex.push entry.id

            return S.list
    S.create = (entry) ->
        $http.post(Routing.generate('entry_create'), entry).then (response) ->
            entry = response.data
            entry['occurred_at'] = new Date entry['occurred_at']
            S.list.push entry
            S.idIndex.push entry.id

            return entry
    S.delete = (entry) ->
        $http.delete(Routing.generate('entry_delete', { entryId: entry.id })).then (response) ->
            i = S.idIndex.indexOf entry.id
            if i < 0
                return

            S.list.splice i, 1
            S.idIndex.splice i, 1
    S.get = (entryId) ->
        $http.get(Routing.generate('entry_show', { entryId: entryId })).then (response) ->
            return response.data
    S.addEntryItem = (entryItem) ->
        $http.post(Routing.generate('entry_add_entryitem', { entryId: entryItem.entry.id }), entryItem).then (response) ->
            return response.data

    return S
]
module.service 'BullshitService', ['$http', '$window', '$q', ($http, $window, $q) ->
    Routing = $window.Routing
    S = {}

    # properties
    S.list = []
    S.idIndex = []

    # methods
    S.query = ($s) ->
        S.list = []
        S.idIndex = []

        deferred = $q.defer()
        setTimeout(->
            $s.$apply ->
                for i in [1..10]
                    shit =
                        id: i
                        value: "#{i}: #{S.getValue()}"

                    S.list.push shit
                    S.idIndex.push shit.id

                deferred.resolve(S.list)
        , S.getRandom(250, 1000))
        return deferred.promise
    S.delete = ($s, shit) ->
        deferred = $q.defer()
        setTimeout( ->
            $s.$apply ->
                i = S.idIndex.indexOf shit.id
                if i < 0
                    return

                S.list.splice i, 1
                S.idIndex.splice i, 1
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
]