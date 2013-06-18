module = window.module
module.service 'ItemService', ['$http', '$window', ($http, $window) ->
    Routing = $window.Routing
    S = {}

    # properties
    S.items = []
    S.itemIndex = []

    # functions
    S.query = () ->
        $http.get(Routing.generate('items')).then (response) ->
            S.items = response.data
            for i, item of S.items
                S.itemIndex.push item.id
            return S.items
    S.create = (item) ->
        $http.post(Routing.generate('item_create'), item).then (response) ->
            item = response.data
            S.itemIndex.push item.id
            S.items.push item
            return item
    S.delete = (item) ->
        $http.delete(Routing.generate('item_delete', { itemId: item.id })).then (response) ->
            i = S.itemIndex.indexOf item.id
            if i < 0
                return
            S.items.splice i, 1
            S.itemIndex.splice i, 1

    return S
]
module.service 'EntryService', ['$http', '$window', ($http, $window) ->
    Routing = $window.Routing
    S = {}

    # properties
    S.entries = []
    S.entryIndex = []

    # functions
    S.query = () ->
        $http.get(Routing.generate('entries')).then (response) ->
            S.entries = response.data
            for i, entry of S.entries
                entry['occurred_at'] = new Date entry['occurred_at']
                S.entryIndex.push entry.id
            return S.entries
    S.create = (entry) ->
        $http.post(Routing.generate('entry_create'), entry).then (response) ->
            entry = response.data
            entry['occurred_at'] = new Date entry['occurred_at']

            S.entries.push entry
            S.entryIndex.push entry.id
            return entry
    S.delete = (entry) ->
        $http.delete(Routing.generate('entry_delete', { entryId: entry.id })).then (response) ->
            i = S.entryIndex.indexOf entry.id
            if i < 0
                return
            S.entries.splice i, 1
            S.entryIndex.splice i, 1

    return S
]