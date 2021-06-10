--Dear Programmer
--When I wrote this code only god and
--I knew how it worked.
--Now, Only god knows it!
--Therefore, if you are trying to optimize / fix
--this code and it fails please increase
--this counter as a warning for the next person

--totalHoursWastedHere = 18

--Copyright 2021 - 2022 cdbrunow
--Access control program WIP
--Dear god send help, lord knows I need it

--Create a sleep function
local clock = os.clock
local function sleep(n)  -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end
--local function sleep(n)
--    os.sleep(n)    
--end
--Create a function for scrolling text
local function scrollText(text, time)
    local len = string.len(text)
    for i = 1,len,1
    do
        if i == len then
            Scroll = text
        else
            Scroll = string.sub(text, 1, i) .. "\r"
        end
    if time ~= nil then
        Slep = time
    else
        Slep = 0.05
    end
    sleep(Slep)
    io.write(Scroll)
    Scroll = nil
    Slep = nil
    end
end
--Create a function for checking if a file exsists
local function file_exists(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
 end
 --- Check if a file or directory exists in this path
function file_exists(file)
    local ok, err, code = os.rename(file, file)
    if not ok then
       if code == 13 then
          -- Permission denied, but it exists
          return true
       end
    end
    return ok, err
 end
 
 --- Check if a directory exists in this path
 function IsDir(path)
    -- "/" works on both Unix and Windows
    if file_exists(path.."/") == nil then
        return false
    else
        return true
    end
 end
 --Create a checkpassword function
local function checkpass(pass)
    scrollText("Password?" .. "\n")
    scrollText("Input: ")
    local read = io.read()
    local hash = sha.sha256(read)
    if hash == pass then return true else return false
    end
end
--Add a version number
version = "0.1.0-alpha.4"
--Load SHA Dependency
sha = require("sha2")
--Some Fancy text
for I=1,math.random(1,10),1
do
io.write("Starting Interpreter." .. "\r")
sleep(1)
io.write("Starting Interpreter.." .. "\r")
sleep(1)
io.write("Starting Interpreter..." .. "\r")
sleep(1)
io.write("Starting Interpreter   " .. "\r")
sleep(1)
end
io.write("Starting Interpreter   " .. "\n")
scrollText("Done!" .. "\n")
scrollText("Loaded version: " .. version .. "\n")
scrollText("CBrunow Systems Inc. All rights reserved" .. "\n")
scrollText("ACCESS control program. Secure System." .. "\n")
sleep(2)
os.execute("cls")
scrollText("System Ready")
read = io.read()
if string.byte(read) ~= 13 then
    os.execute("cls")
    print("System Ready")
else
    os.execute("cls")
end
-- VVVVV  VERY VERY important
LoggedIn = false
Admin = false
-- ^^^^^
--Create a while loop for execution of the program
scrollText("-------------------------------------------------" .. "\n")
while true do
--Create a > for a terminal indicator
if Admin == false then
    scrollText("> ")
else
    scrollText("$ ")
end
--Read commands that are typed in. Make sure all commands are accepted no matter capitalization
io.input(io.stdin)
local read1 = io.read()
local read = string.lower(read1)
--Check login status
if LoggedIn == false then
    --Help command detailing help on all commands
    if read == "help" then
        scrollText("------------------------------" .. "\n")
        scrollText("List of Commands" .. "\n")        
        scrollText("Help:   This menu" .. "\n")
        scrollText("Login: Allows you to login" .. "\n")
        scrollText("Exit: Exits the Program" .. "\n")
        scrollText("NewUser: Allows you to create an account" .. "\n")
        scrollText("Version: Shows the current version" .. "\n")
    --Exit command which, You guessed it, Exits the program
    elseif read == "exit" then
        scrollText("Goodbye!" .. "\n")
        os.exit()
    --Login command, You guessed it, Used to login
    elseif read == "login" then
        --Ask for a username
        scrollText("Username?" .. "\n")
        scrollText("Input: ")
        username = io.read()
        --See if user exsists, If so check password. If both are good then login with that user. If not throw an error
        if IsDir("Users/" .. username) == true then
            File = io.open("Users/" .. username .. "/" .. "password.txt", "r")
            Passwd = File:read()
            File:close()
            if checkpass(Passwd) == true then
                User = username
                LoggedIn = true
                scrollText("Logged in!" .. "\n")
            else
                --Error for wrong password
                User = nil
                LoggedIn = false    
                scrollText("Wrong Password!" .. "\n")        
            end
        else
            --Error incase user doesn't exsist
            scrollText("User does not exist!" .. "\n")
            User = nil
        end
    --Create a newuser command. Asks for a new username and password and then creates them. Throw errors for already exsisting users. (Maybe move to only admin accounts???)
    elseif read == "version" then
        scrollText(version .. "\n")
    
    else
     --If you don't type in any command within the list, It won't work.
        scrollText("Unknown Command!" .. "\n")
    end    
else
--Now we're logged in. WIP    
    if read == "help" then
        scrollText("------------------------------" .. "\n")
        scrollText("List of Commands" .. "\n")        
        scrollText("Help:   This menu" .. "\n")
        scrollText("Exit: Exits the Program" .. "\n")
        scrollText("Logout: Logs you out" .. "\n")
        scrollText("NewUser: Creates a new user" .. "\n")
        scrollText("DelUser: Deletes an existing user" .. "\n")
    elseif read == "exit" then
        if Admin == true then
            Admin = false
        else
            scrollText("Goodbye!" .. "\n")
            os.exit()
        end
    elseif read == "logout" then
        LoggedIn = false
        User = nil
        Admin = false
        scrollText("Logged Out!" .. "\n")
    elseif read == "newuser" then
        if Admin == true then
            scrollText("Username?" .. "\n")
            scrollText("Input: ")
            local input = io.read()
            local username = input
            --Check if user exists
            if IsDir("Users/" .. username) == false then
                os.execute("cd Users & mkdir " .. username .. " & cd ..")
                File = io.open("Users/" .. username .. "/" .. "password.txt", "w")
                scrollText("Password?" .. "\n")
                scrollText("Input: ")
                local input = io.read()
                local password = sha.sha256(input)
                File:write(password)
                scrollText("----------------------------------------------" .. "\n")
                scrollText("User created!" .. "\n")
                scrollText("Save this info for later!" .. "\n")
                scrollText("Username: " .. username .. "\n")
                scrollText("Password: " .. input .. "\n")
                File:close()
                local input = nil
            else
                --If user exsists then throw error
                scrollText("User already exists!" .. "\n")
                print(IsDir("Users/" .. username))
            end
            input= nil
            username = nil
        else
            scrollText("Error: No Privilege")
        end
    elseif read == "su" then
        file = io.open("admins.txt", "r")
        io.input(file)
        loop = true
        while loop == true do
            sleep(1)
            local read = io.read("*l")
            if read == User then
                Admin = true
                scrollText("Privilege Elevated!" .. "\n")
                loop = false
                file:close()
            elseif read == nil then
                if Admin == false then
                    scrollText("You are not an admin!" .. "\n")
                    loop = false
                    file:close()
                else
                end
            else
            end
        end
    
    
    elseif read == "deluser" then
        if Admin == true then
            scrollText("User?" .. "\n")
            scrollText("Input: ")
            local input = io.read()
            local username = input
            if IsDir("Users/" .. username) == true then
                scrollText("User Exsists: Confirm Delete?" .. "\n")
                scrollText("Input: ")
                local input = io.read()
                local read = string.lower(input)
                if read == "y" or read == "yes" then
                   os.execute("cd Users & rmdir /s /q " .. username .. "& cd ..")
                    scrollText("User: " .. username .. " Deleted!" .. "\n")
                else
                    scrollText("Aborting!" .. "\n")
                end
            else
                scrollText("User does not exist. Aborting!" .. "\n")
            end
        else    
            scrollText("You are not an admin!")
        end

    else
        scrollText("Unknown Command!" .. "\n")
end
end
end