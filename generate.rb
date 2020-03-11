require 'pp'
poses = [
  { name: "सूर्यनमस्कार", steps: 12, reps: 6, interval: '1200' },
  { name: "त्रिकोणासन", steps: 30, reps: 2, interval: '500'},
  { name: "अर्ध मत्स्येन्द्रासन", steps: 30, reps: 2 , interval: '500'},
  { name: "Leg Raise", steps: 50, reps: 2 , interval: '500'},
  { name: "पश्चिमोत्तासन", steps: 60, reps: 1 , interval: '500'},
  { name: "Plank Pose", steps: 60, reps: 1 , interval: '500'},
  { name: "धनुरासन", steps: 30, reps: 1, interval: '500'},
  { name: "Chair Pose",steps: 60,reps: 1, wait: 10, interval: '500'},
  { name: "सर्वांगासन",steps: 60,reps: 1,wait: 10, interval: '500'},
  { name: "सिरसासन",steps: 60,reps: 1,wait: 10, interval: '500'}
]

# poses = [
#   { name: "सूर्यनमस्कार", steps: 12, reps: 1, interval: '1500' },
#   { name: "त्रिकोणासन", steps: 30, reps: 2, interval: '500'},
#   { name: "अर्ध मत्स्येन्द्रासन", steps: 30, reps: 2 , interval: '500'}
# ]

short_poses = [
  { name: "सूर्यनमस्कार",steps: 60,reps: 1,interval: 5},
  { name: "Leg Raise",steps: 30,reps: 2,},
  { name: "पश्चिमोत्तासन",steps: 60,reps: 1,},
  { name: "धनुरासन",steps: 30,reps: 1,},
  { name: "सर्वांगासन",steps: 60,reps: 1,wait: 5},
  { name: "सिरसासन",steps: 60,reps: 1,wait: 5}
]

other_experimental_poses = [
  { name: "Lizard Pose",steps: 60,reps: 1,interval: 5},
  { name: "Crow Pose",steps: 60,reps: 1,interval: 5},
  { name: "Pigeon Pose",steps: 60,reps: 1,interval: 5},
  { name: "Warrior Pose Sequence",steps: 60,reps: 1,interval: 5},
]


if ARGV.length > 0 and ARGV.first == 'short'
  poses = short_poses
end

puts "<speak>"
poses.each_with_index do |pose,index|
  if index == 0
    puts "<break time='1s' />Get ready for #{pose[:name]} <break time='5s' />"
  else
    if pose.has_key? :wait
      wait = pose[:wait]
    else
      wait = 5
    end
    
    puts "Take a short break <break time='5s' />Starting #{pose[:name]} in #{wait} <break time='#{wait}s' />Starting #{pose[:name]} <break time='500ms'/>"
  end 


  (1..pose[:reps]).each do |rep|
    puts "Starting round #{rep} of #{pose[:name]} <break time='2s' />" if rep != 1
    (1..pose[:steps]).each do |counter|
      break_time = pose[:interval]
      say_time = pose[:steps] - counter + 1
      puts "#{say_time} <break time='#{break_time}ms'/>"      
    end
  end
end

puts "<break time='500ms'/>Your Yoga Session is Complete.</speak>"
