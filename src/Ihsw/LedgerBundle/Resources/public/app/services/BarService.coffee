service = ($l) ->
    S = {}

    # properties
    S.bars = {}

    # methods
    S.initialize = (name) ->
        S.bars[name] =
            name: name
            groups: {}
        return S.bars[name]
    S.setBarGroups = (name, groups) ->
        if !(name of S.bars)
            throw "tried to assign a bar to #{name} which does not exist"
        S.bars[name].groups = groups
    S.resetBarGroups = ->
        for name, bar of S.bars
            S.bars[name].groups = {}
    S.call = ($s, href, callback) ->
        # misc
        callback = callback ? null
        href = href ? null

        # handling
        if callback != null
            phase = $s.$root.$$phase
            if phase == '$apply' or phase == '$digest'
                $s.$eval $s.callback
            else
                $s.$apply $s.callback
        else if href != null
            $l.path href

    return S
service.$inject = ['$location']
window.module.service 'BarService', service