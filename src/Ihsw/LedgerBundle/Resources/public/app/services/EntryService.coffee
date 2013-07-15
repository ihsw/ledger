service = ($http, $window) ->
    R = $window.Routing
    S = {}

    # misc
    initialize = (entry) ->
        entry.occurred_at = new Date entry.occurred_at

        entry_items = {}
        for i, entryItem of entry.entry_items
            entry_items[entryItem.id] = entryItem
        entry.entry_items = entry_items

        return entry

    # properties
    S.list = {}

    # functions
    S.query = ->
        S.list = {}

        $http.get(R.generate('entries')).then (response) ->
            for i, entry of response.data
                S.list[entry.id] = initialize entry

            return S.list
    S.create = (entry) ->
        $http.post(R.generate('entry_create'), entry).then (response) ->
            entry = response.data
            S.list[entry.id] = initialize entry

            return entry
    S.delete = (entry) ->
        $http.delete(R.generate('entry_delete', { entryId: entry.id })).then (response) ->
            delete S.list[entry.id]
    S.get = (entryId) ->
        $http.get(R.generate('entry_show', { entryId: entryId })).then (response) ->
            entry = initialize response.data
            S.list[entry.id] = entry
            return entry
    S.update = (entry, newEntry) ->
        $http.put(R.generate('entry_update', { entryId: entry.id }), newEntry).then (response) ->
            entry = initialize response.data
            S.list[entry.id] = entry
            return entry

    # utility
    S.onEntryItemDelete = (entryItem) ->
        delete S.list[entryItem.entry.id].entry_items[entryItem.id]

    return S
service.$inject = ['$http', '$window']
window.module.service 'EntryService', service