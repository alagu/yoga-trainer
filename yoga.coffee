$(document).ready ->
  window.yoga = yoga = time_count: 1, time_out: null, pose_index: 0, pose_rep: 1, voice: null
  window.count_array = {}
  # yoga.poses = [
  #   name: "Suryanamaskar"
  #   time: 60
  #   reps: 2
  # ,
  #   name: "Trikonasana"
  #   time: 30
  #   reps: 2
  # ,
  #   name: "Ardha Matsyendrasana"
  #   time: 30
  #   reps: 2
  # ,
  #   name: "Leg Raise"
  #   time: 50
  #   reps: 2
  # ,
  #   name: "Paschimottasana"
  #   time: 60
  #   reps: 1
  # , 
  #   name: "Plank Pose"
  #   time: 60
  #   reps: 1
  # , 
  #   name: "Dhanurasana"
  #   time: 30
  #   reps: 1
  # ,
  #   name: "Chair Pose"
  #   time: 60
  #   reps: 1
  # ,
  #   name: "Sarvangasana"
  #   time: 60
  #   reps: 1
  # ,
  #   name: "Sirasasana"
  #   time: 60
  #   reps: 1
  # ]
  
  yoga.poses = [
    name: "Sarvangasana"
    time: 120
    reps: 1
  ]

  speak = (text, followup)->
    msg = new SpeechSynthesisUtterance
    voices = window.speechSynthesis.getVoices()
    if yoga.voice != null
      msg.voice = voices[yoga.voice]
      
    msg.voiceURI = 'native'
    msg.volume = 1
    # msg.rate = 1
    # msg.pitch = 2
    msg.text = text
    msg.lang = 'en_IN'
    msg.onend = (e) ->
      console.log 'Finished in ' + event.elapsedTime + ' seconds.'
      window.count_array[text]=event.elapsedTime
      console.log(window.count_array)
      followup()
      return
    
    console.log(msg)

    speechSynthesis.speak msg
  
  playTimer =->
    if yoga.time_count > yoga.poses[yoga.pose_index].time 
      if yoga.pose_index == yoga.poses.length - 1
        yogaEnded()
      else
        yoga.time_count = 0
        if yoga.pose_rep == yoga.poses[yoga.pose_index].reps
          yoga.pose_rep = 1
          yoga.pose_index = yoga.pose_index + 1
          nextPose()
        else
          yoga.pose_rep = yoga.pose_rep + 1
          nextRep()
    else
      speak(inWords(window.yoga.time_count.toString()), ->)
      yoga.time_count = yoga.time_count + 1
      if yoga.time_count == 1
        $("#current-time").html("-")
      else
        $("#current-time").html(yoga.time_count - 1)
        
      yoga.time_out = setTimeout(playTimer,1200)
  
  nextRep =->
    $("#current-pose").html(yoga.poses[yoga.pose_index].name + " #" + yoga.pose_rep)
    speak("Starting Rep #{yoga.pose_rep} of #{yoga.poses[yoga.pose_index].name} in 3 seconds", ->
      setTimeout(playTimer, 1000)
    )
    
  nextPose =->
    $("#current-pose").html(yoga.poses[yoga.pose_index].name + " #" + yoga.pose_rep)
    speak("Starting #{yoga.poses[yoga.pose_index].name} in 5 seconds", ->)
    setTimeout(playTimer, 5000)
    
  getVoice =->
    voices = speechSynthesis.getVoices()
    final_voices = voices.filter (x) -> (x.voiceURI == "Google हिन्दी" || x.voiceURI == "Hindi India")
    if final_voices.length > 0 and voices.indexOf final_voices[0] > 0
      voices.indexOf(final_voices[0])
    else
      null

    
  playYoga =->
    if yoga.pose_index == 0 and yoga.time_count == 1
      nextPose()
    
    return false
  
  yogaEnded =->
    setTimeout(-> 
      speak("Good job!", ->)
      speak("Today's Yoga session is complete.", -> )
    , 2000)
  
  $("#start-yoga").click ->
    $(".pre-start").hide()
    $(".current-yoga").removeClass("d-none")
    playYoga()
    return false
    
  $("#pause-yoga").click -> 
    clearTimeout(window.yoga.time_out)
    
  init =->
    console.log("Initializing")
    yoga.voice = getVoice()
    console.log("Voice id #{yoga.voice}")
  
  setTimeout(init, 2000)
