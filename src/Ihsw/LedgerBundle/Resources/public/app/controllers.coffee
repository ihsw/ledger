module = window.module

# home controller
module.controller 'HomeController', ['$rootScope', ($rootScope) ->
    $rootScope.section = 'home'
]

# item controllers
module.controller 'ItemController', ['$rootScope', '$timeout', '$scope', 'ItemService', ($rootScope, $timeout, $s, ItemService) ->
    # nav
    $rootScope.section = 'items'

    # properties
    $s.loading = false
    $s.createDisabled = false
    $s.name = ''
    $s.items = []
    $s.itemMetadata = {}

    # functions
    $s.create = ->
        if $s.createDisabled
            return
        $s.createDisabled = true

        ItemService.create({ name: $s.name }).then (item) ->
            $s.name = ''
            $s.itemMetadata[item.id] = { deleteDisabled: false }
            $s.createDisabled = false
    $s.delete = (item) ->
        if $s.itemMetadata[item.id].deleteDisabled
            return
        $s.itemMetadata[item.id].deleteDisabled = true

        ItemService.delete(item).then ->
            delete $s.itemMetadata[item.id]
    $s.refresh = ->
        $s.loading = true

        ItemService.query().then (items) ->
            $s.loading = false
            $s.items = items

            itemMetadata = {}
            for i, item of items
                itemMetadata[item.id] = { deleteDisabled: false }
            $s.itemMetadata = itemMetadata

    # initial load
    $s.refresh()
]

# entry controllers
module.controller 'EntryController', ['$rootScope', '$scope', 'EntryService', ($rootScope, $s, EntryService) ->
    # nav
    $rootScope.section = 'entries'

    # properties
    $s.loading = false
    $s.entryMetadata = {}
    $s.entries = []

    # functions
    $s.refresh = ->
        $s.loading = true

        EntryService.query().then (entries) ->
            $s.loading = false
            $s.entries = entries

            entryMetadata = {}
            for i, entry of entries
                entryMetadata[entry.id] = { deleteDisabled: false }
            $s.entryMetadata = entryMetadata
    $s.delete = (entry) ->
        if !(String(entry.id) in Object.keys($s.entryMetadata)) or $s.entryMetadata[entry.id].deleteDisabled
            return
        $s.entryMetadata[entry.id].deleteDisabled = true

        EntryService.delete(entry).then ->
            delete $s.entryMetadata[entry.id]

    # initial load
    $s.refresh()
]
module.controller 'EntryNewController', ['$rootScope', '$scope', '$location', 'EntryService', ($rootScope, $s, $l, EntryService) ->
    # nav
    $rootScope.section = 'entries'

    # properties
    $s.submitDisabled = true
    $s.occurredAt = ''
    $s.occurredAtPlaceholder = new Date()

    # methods
    $s.refresh = ->
        $s.occurredAt = ''
        $s.submitDisabled = false
    $s.create = ->
        if $s.submitDisabled
            return
        $s.submitDisabled = true

        EntryService.create({occurredAt: $s.occurredAt}).then (entry) ->
            $s.refresh()
            $l.path '/entries'

    # initial load
    $s.refresh()
]

# bullshit
module.controller 'BullshitController', ['$rootScope', '$scope', ($rootScope, $s) ->
    # nav
    $rootScope.section = 'bullshit'

    getValue = () ->
        characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
        length = characters.length
        value = ''
        for i in [1..10]
            value += characters.charAt Math.floor(Math.random() * length)
        return value

    # properties
    $s.shits = []
    $s.shitIndex = []
    for i in [1..10]
        shit = {
            id: i,
            value: "#{i}: #{getValue()}"
        }
        $s.shitIndex.push shit.id
        $s.shits.push shit

    # methods
    $s.delete = (shit) ->
        i = $s.shitIndex.indexOf shit.id
        if i < 0
            console.log 'wtf'
            return

        $s.shits.splice i, 1
        $s.shitIndex.splice i, 1
]