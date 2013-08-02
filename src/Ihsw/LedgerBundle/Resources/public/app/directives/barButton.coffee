# controller
controller = ($s, $f, BarService) ->
    C = @

    ### SCOPE
    ###
    # properties
    $s.button = {}
    $s.items = {}

    # methods
    $s.call = (href, callback) ->
        if $f('dictLength')($s.items) == 0
            BarService.call $s, href, callback
            return

        $s.button.opened = !$s.button.opened
    $s.getItems = ->
        return $f('dictListReverse')($s.items)

    # watches
    $s.$watch 'disabled', ->
        if typeof $s.disabled == 'undefined'
            return

        if $s.disabled == false
            i = $s.button.classes.indexOf 'disabled'
            if i < 0
                return
            $s.button.classes.splice i, 1
            return

        $s.button.classes.push 'disabled'

    ### CONTROLLER
    ###
    C.addItem = (item) ->
        item.id = $f('dictLength')($s.items)
        $s.items[item.id] = item

    return C
controller.$inject = ['$scope', '$filter', 'BarService']

# link
link = ($s, element, attrs, BarGroupController) ->
    # generating a button
    classValue = attrs.class ? ''
    button = $s.button =
        label: attrs.label
        classes: classValue.split(' ')
        icon: attrs.icon
        items: $s.getItems()
        opened: false
        call: ->
            $s.call attrs.href, attrs.callback

    # pushing it up
    BarGroupController.addButton button

# directive definition
window.module.directive 'barButton', ->
    return {
        require: '^barGroup'
        restrict: 'E'
        scope:
            callback: '&'
            disabled: '='
        controller: controller
        link: link
    }