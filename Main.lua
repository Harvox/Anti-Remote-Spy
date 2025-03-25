--[[ 
This mainly targets Simple Spy and Hydroxide, I'm not sure
how well this will go against other remote spies.
]]

getgenv().Settings = {
  RefreshTimes = 1, -- The delay in which the honeypot remote will be ran
  Crash = false, -- If set to true it will crash the user
}

local HoneypotRemote = Instance.new("RemoteEvent", cloneref(game:GetService("ReplicatedStorage")))

function Detected()
if getgenv().Settings.Crash then
    while true do end
  end

for i,v in next, workspace:GetDescendants() do 
pcall(v.Destroy)
end
game:GetService("Players").LocalPlayer:Kick()
end

coroutine.resume(coroutine.create(function()
        while true do 
            task.wait(getgenv().Settings.RefreshTimes)
            HoneypotRemote:FireServer("Caught using remote spy...")
        end
end))

coroutine.resume(coroutine.create(function()
      while true do 
        task.wait(getgenv().Settings.RefreshTimes)
              for _,v in next, getgc(false) do 
        if typeof(v) == 'function' and islclosure(v) and (table.find(debug.getconstants(v), HoneypotRemote.Name) or table.find(debug.getupvalues(v), HoneypotRemote.Name)) then
            Detected()
        end
        end
      end  
end))
