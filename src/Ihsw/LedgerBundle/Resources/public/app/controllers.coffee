module = window.module
module.controller 'ItemController', ['$rootScope', '$timeout', '$scope', 'ItemService', ($rootScope, $timeout, $s, ItemService) ->
    # nav
    $rootScope.section = 'items'

    # properties
    $s.loading = false
    $s.createDisabled = false
    $s.name = ''
    $s.items = {}
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
        if !$s.itemMetadata[item.id].deleteDisabled
            $s.itemMetadata[item.id].deleteDisabled = true

            ItemService.delete(item).then ->
                delete $s.itemMetadata[item.id]
    $s.refresh = ->
        $s.loading = true

        ItemService.query().then (items) ->
            $s.loading = false
            $s.items = items

            itemMetadata = {}
            for itemId, item of items
                itemMetadata[itemId] = { deleteDisabled: false }
            $s.itemMetadata = itemMetadata

    # initial load
    $s.refresh()
]
module.controller 'HomeController', ['$rootScope', ($rootScope) ->
    $rootScope.section = 'home'
]
module.controller 'EntryController', ['$rootScope', '$scope', 'EntryService', ($rootScope, $s, EntryService) ->
    # nav
    $rootScope.section = 'entries'

    # misc
    defaultModalOptions =
        backdropFade: true
        dialogFade: true

    # properties
    $s.entryModalOptions = defaultModalOptions
    $s.itemsModalOptions = defaultModalOptions
    $s.loading = false
    $s.isEntryModalOpen = false
    $s.createEntryDisabled = false
    $s.isItemsModalOpen = false

    # functions
    $s.refresh = ->
        $s.loading = true

        EntryService.query().then (entries) =>
            $s.loading = false
            $s.entries = entries
    $s.showModal = ->
        $s.isEntryModalOpen = true
    $s.closeModal = ->
        $s.isEntryModalOpen = false
    $s.create = ->
        if $s.createEntryDisabled
            return
        $s.createEntryDisabled = true

        EntryService.create({occurredAt: $s.occurredAt}).then (entry) =>
            $s.occurredAt = ''
            $s.createEntryDisabled = false
    $s.showItemsModal = ->
        $s.isItemsModalOpen = true
    $s.closeItemsModal = ->
        $s.isItemsModalOpen = false

    # initial load
    $s.refresh()
]