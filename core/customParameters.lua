local getKey = helper.getKey

while true do
    print("\nDo you want to add custom options? (y/n):")
    local input = getUserInput():lower()
    if input == "y" then
        print("Moving to custom paramater selection.")
        break
    elseif input == "n" then
        print("Skipping custom parameter selection.")
        dofile("core/executor.lua")
        return
    else
        helper.beg(input)
    end
end

print("\nEnter a custom parameter:")
while true do
    print("Type 'list' to view all selected parameters.")
    print("Type 'del {parameter}' to remove a parameter.\n")

    local parameterInput = io.read()
    local trimmedInput = parameterInput:match("^%s*(.-)%s*$")

    -- Lists all parameters selected
    if trimmedInput == "list" then
        if #params == 0 then
            print("\nNo parameters have been selected.\n")
        else
            print("\nSelected parameters: " .. table.concat(params, ", ") .. "\n")
        end
    -- Deletes parameters
    elseif trimmedInput:sub(1, 4) == "del " then
        local rest = trimmedInput:sub(5)
        for delParam in rest:gmatch("%S+") do
            local actualParam = delParam:match("^%s*(.-)%s*$")
            local paramKey = getKey(actualParam)
            local found = false

            for i, v in ipairs(params) do
                if getKey(v) == paramKey then
                    table.remove(params, i)
                    print("'" .. actualParam .. "' removed from selection.\n")
                    found = true
                    break
                end
            end

            if not found then
                print("'" .. actualParam .. "' not found in the selection.\n")
            end
        end
    else
        local index = 1
        local len = #trimmedInput
        while index <= len do
            -- Match start of a new parameter
            local start, stop, prefix = trimmedInput:find("()%s*(-?%-?)%S", index)
            if not start then
                break
            end

            index = start

            -- Find the next parameter or end of string
            local nextStart = trimmedInput:find(" %-%-?%S", index + 1)
            local paramChunk
            if nextStart then
                paramChunk = trimmedInput:sub(index, nextStart - 1)
                index = nextStart
            else
                paramChunk = trimmedInput:sub(index)
                index = len + 1
            end

            local actualParam = paramChunk:match("^%s*(.-)%s*$")
            local paramKey = getKey(actualParam)
            local found = false

            for i, v in ipairs(params) do
                if getKey(v) == paramKey then
                    found = true
                    if v == actualParam then
                        print(
                            "'" ..
                                actualParam .. "' already exists. Type 'del " .. actualParam .. "' to remove it.\n"
                        )
                    else
                        params[i] = actualParam
                        print("'" .. actualParam .. "' replaced the old '" .. v .. "'.\n")
                    end
                    break
                end
            end

            if not found then
                table.insert(params, actualParam)
                print("'" .. actualParam .. "' added to selection.\n")
            end
        end
    end
end