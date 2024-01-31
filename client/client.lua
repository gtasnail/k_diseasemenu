diseases = {}

if (GetResourceState('ox_lib') and GetResourceState('k_diseases') ) ~= 'started' then print('^1 Please make sure to install ox_lib and k_disease and make sure they are both started.') return end


lib.registerMenu({
    id = 'disease',
    title = 'Current Diseases',
    position = 'top-right',
    options = diseases
})

function convertToPercentage(number, maxNumber)
    if number < 0 then
        number = 0
    elseif number > maxNumber then
        number = maxNumber
    end
    local percentage = (number / maxNumber) * 100
    return percentage
end


RegisterCommand('diseases', function()
    local myDiseases = exports['k_diseases']:GetDiseases()

    diseases = {}
    if myDiseases then
        for k,v in pairs(myDiseases) do
            if v.hasDiseases then
                diseases[#diseases+1] = {label = k, icon = 'disease', description=math.floor(convertToPercentage(v.iterations, Config.Diseases[k].iterations))..'%',  progress=convertToPercentage(v.iterations, Config.Diseases[k].iterations), colorScheme='blue', iconAnimation='beat', close=false}
            end
        end
        if #diseases == 0 then
            lib.notify({
                title = 'Diseases',
                description = 'You have no active disease.',
                type = 'error'
            })
            return
        end
    end
    
    lib.setMenuOptions('disease', diseases)
    lib.showMenu('disease')
end)
