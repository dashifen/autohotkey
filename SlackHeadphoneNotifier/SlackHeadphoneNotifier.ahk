#persistent
#include JSON.ahk

Menu, TRAY, Icon, headphones.ico
Menu, TRAY, Tip, Slack Headphone Notifier by Dash

priorSong := ""
priorTime := ""
http := comobjcreate("WinHTTP.WinHttpRequest.5.1")

EnvGet, SlackToken, SlackToken

setTimer, main, 5000

main:
  try {
    parsed := JSON_load("playback.json")
    currentSong := parsed["song","title"]
    currentArtist := parsed["song","artist"]
    currentTime := parsed["time","current"]
    
    if (priorTime != currentTime) {
      priorTime := currentTime
       
      if (priorSong != currentSong) {
        emoji := ":headphones:"
        message := "Dash is listening to " currentSong " by " currentArtist
        priorSong := currentSong
      }
    } else if (priorSong != "") {
      emoji := ""
      message := ""
      priorSong := ""
    }
    
    http.Open("POST", "https://slack.com/api/users.profile.set", 0)
    http.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
    http.SetRequestHeader("Authorization", "Bearer " . SlackToken)
    http.Send("profile={""status_text"":""" message """, ""status_emoji"":""" emoji """}")
  }
  
  return


  
  
  
  
  