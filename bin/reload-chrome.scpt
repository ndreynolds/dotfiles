tell application "Google Chrome" 
    set activeURL to URL of active tab of first window as text
    if activeURL contains "localhost" then
        tell active tab of first window to reload
    end if
end tell
