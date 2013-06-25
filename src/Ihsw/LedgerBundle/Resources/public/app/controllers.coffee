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
    $s.list = []
    $s.listMetadata = {}

    # functions
    $s.create = ->
        if $s.createDisabled
            return
        $s.createDisabled = true

        ItemService.create({ name: $s.name }).then (item) ->
            $s.name = ''
            $s.listMetadata[item.id] = { deleteDisabled: false }
            $s.createDisabled = false
    $s.delete = (item) ->
        if !(String(item.id) in Object.keys($s.listMetadata)) or $s.listMetadata[item.id].deleteDisabled
            return
        $s.listMetadata[item.id].deleteDisabled = true

        ItemService.delete(item).then ->
            delete $s.listMetadata[item.id]
    $s.refresh = ->
        $s.loading = true

        ItemService.query().then (items) ->
            $s.loading = false
            $s.list = items

            listMetadata = {}
            for i, item of items
                listMetadata[item.id] = { deleteDisabled: false }
            $s.listMetadata = listMetadata

    # initial load
    $s.refresh()
]
module.controller 'ItemNewController', ['$rootScope', '$scope', '$location', 'ItemService', ($rootScope, $s, $l, ItemService) ->
    # nav
    $rootScope.section = 'items'

    # properties
    $s.submitDisabled = true
    $s.name = ''

    # functions
    $s.refresh = ->
        $s.name = ''
        $s.submitDisabled = false
    $s.create = ->
        if $s.submitDisabled
            return
        $s.submitDisabled = true

        ItemService.create({ name: $s.name }).then (item) ->
            $s.refresh()
            $l.path '/items'

    # initial load
    $s.refresh()
]

# entry controllers
module.controller 'EntryController', ['$rootScope', '$scope', 'EntryService', ($rootScope, $s, EntryService) ->
    # nav
    $rootScope.section = 'entries'

    # properties
    $s.loading = false
    $s.listMetadata = {}
    $s.list = []

    # functions
    $s.refresh = ->
        $s.loading = true

        EntryService.query().then (entries) ->
            $s.loading = false
            $s.list = entries

            listMetadata = {}
            for i, entry of entries
                listMetadata[entry.id] = { deleteDisabled: false }
            $s.listMetadata = listMetadata
    $s.delete = (entry) ->
        if !(String(entry.id) in Object.keys($s.listMetadata)) or $s.listMetadata[entry.id].deleteDisabled
            return
        $s.listMetadata[entry.id].deleteDisabled = true

        EntryService.delete(entry).then ->
            delete $s.listMetadata[entry.id]

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
module.controller 'EntryViewController', ['$rootScope', '$scope', '$routeParams', 'EntryService', ($rootScope, $s, $r, EntryService) ->
    # nav
    $rootScope.section = 'entries'

    # properties
    $s.loading = false

    # methods
    $s.refresh = (entryId) ->
        $s.loading = true

        EntryService.get(entryId).then (entry) ->
            $s.loading = false
            $s.entry = entry

    # initial load
    $s.refresh($r.entryId)
]

# bullshit
module.controller 'BullshitController', ['$rootScope', '$scope', 'BullshitService', ($rootScope, $s, BullshitService) ->
    # nav
    $rootScope.section = 'bullshit'

    # properties
    $s.loading = false
    $s.list = []
    $s.listMetadata = {}

    # methods
    $s.refresh = ->
        $s.loading = true

        BullshitService.query($s).then (shits) ->
            $s.loading = false
            $s.list = shits

            listMetadata = {}
            for i, shit of shits
                listMetadata[shit.id] = { deleteDisabled: false }
            $s.listMetadata = listMetadata
    $s.delete = (shit) ->
        if !(String(shit.id) in Object.keys($s.listMetadata)) or $s.listMetadata[shit.id].deleteDisabled
            return
        $s.listMetadata[shit.id].deleteDisabled = true

        BullshitService.delete($s, shit).then ->
            delete $s.listMetadata[shit.id]

    # initial load
    $s.refresh()
]