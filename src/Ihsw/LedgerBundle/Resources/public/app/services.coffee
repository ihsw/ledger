module = window.module
module.service 'ItemService', ['$http', '$window', ($http, $window) ->
    Routing = $window.Routing
    S = {}

    # properties
    S.items = []
    S.itemKeys = {}

    # functions
    S.query = () ->
        $http.get(Routing.generate('items')).then (response) ->
            S.items = response.data
            for i, item of S.items
                S.itemKeys[item.id] = i
            return S.items
    S.create = (item) ->
        $http.post(Routing.generate('item_create'), item).then (response) ->
            item = response.data
            S.itemKeys[item.id] = S.items.length
            S.items.push item
            return item
    S.delete = (item) ->
        $http.delete(Routing.generate('item_delete', { itemId: item.id })).then (response) ->
            S.items.splice S.itemKeys[item.id], 1
            delete S.itemKeys[item.id]

    return S
]
module.service 'EntryService', ['$http', '$window', ($http, $window) ->
    Routing = $window.Routing
    S = {}

    # properties
    S.entries = []
    S.entryKeys = {}

    # functions
    S.query = () ->
        $http.get(Routing.generate('entries')).then (response) ->
            S.entries = response.data
            for i, entry of S.entries
                entry['occurred_at'] = new Date entry['occurred_at']
                S.entries[i] = entry
                S.entryKeys[entry.id] = i
            return S.entries
    S.create = (entry) ->
        $http.post(Routing.generate('entry_create'), entry).then (response) ->
            entry = response.data
            entry['occurred_at'] = new Date entry['occurred_at']

            S.entryKeys[entry.id] = S.entries.length
            S.entries.push entry
            return entry
    S.delete = (entry) ->
        $http.delete(Routing.generate('entry_delete', { entryId: entry.id })).then (response) ->
            S.entries.splice S.entryKeys[entry.id], 1
            delete S.entryKeys[entry.id]

    return S
]