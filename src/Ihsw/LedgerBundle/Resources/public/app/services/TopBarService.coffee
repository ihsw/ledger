service = ($l, $rootScope) ->
    S = {}

    # misc
    createCallback = (button) ->
        button._callback = ->
            if 'callback' of button
                button.callback()
                return

            if 'href' of button
                $l.path button.href
                return

            console.log 'WHAT DO I DO'
        return button

    # properties
    S.$directiveScope

    # methods
    S.initialize = ($directiveScope) ->
        S.$directiveScope = $directiveScope
    S.setButtons = (buttons) ->
        S.$directiveScope.buttons = (createCallback button for button in buttons)
    S.addButton = (button) ->
        S.$directiveScope.buttons.push createCallback button
    S.resetButtons = ->
        if typeof S.$directiveScope == 'undefined'
            return
        S.$directiveScope.refresh()

    return S
service.$inject = ['$location']
window.module.service 'TopBarService', service