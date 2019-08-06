#persistent
#include JSON.ahk

Menu, TRAY, Icon, headphones.ico
Menu, TRAY, Tip, Slack Headphone Notifier by Dash

priorIsPlaying := ""
http := comobjcreate("WinHTTP.WinHttpRequest.5.1")

EnvGet, SlackToken, SlackToken

setTimer, main, 5000

main:
  isPlaying := getIsPlaying()
  
  if (isPlaying != priorIsPlaying) {
    priorIsPlaying := isPlaying
  
    if (isPlaying) { 
      message := "Dash is listening to music."
      emoji := ":headphones:"
    } else {
      message := ""
      emoji := ""
    }
       
    http.Open("POST", "https://slack.com/api/users.profile.set", 0)
    http.SetRequestHeader("Content-type", "application/x-www-form-urlencoded")
    http.SetRequestHeader("Authorization", "Bearer " . SlackToken)
    http.Send("profile={""status_text"":""" message """, ""status_emoji"":""" emoji """}")
  }  
  return

getIsPlaying() {
  fileread newFileContent, playback.json
  parsed := JSON.Load(newFileContent)
  return parsed.playing
}