require 'pp'
poses = [
  { name: "सूर्यनमस्कार", steps: 12, reps: 6, interval: '3000', sub_poses: ['ताड़ासना','हस्त उत्तनासना','पादासना','अश्व संचालासना','दण्डासना','अष्टांग नमस्कारा','भुजंगासना','अधो मुखा  स्वनासना','अश्व संचालासना','पादासना','हस्त उत्तनासना','ताड़ासना'] },
  { name: "वीरभद्रासना on right leg", steps: 15, reps: 3, interval: '2500'},
  { name: "वीरभद्रासना on left leg", steps: 15, reps: 3, interval: '2500'},
  { name: "उत्कटासना", steps: 15, reps: 1, wait: 20, interval: '1000'},
  { name: "दंडासना", steps: 15, reps: 1, wait: 20, interval: '1000',},
  { name: "पश्चिमोत्तासना", steps: 30, reps: 1 , interval: '1000'},
  { name: "धनुरासना", steps: 10, reps: 1, interval: '1000'},
  { name: "सर्वांगसना", steps: 60,reps: 1, wait: 10, interval: '1000'},
  { name: "मत्स्येन्द्रासना", steps: 30,reps: 1, wait: 10, interval: '1000'},
  { name: "सीरसासना", steps: 60,reps: 1, wait: 10, interval: '1000'}
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
      breath = (counter % 2 == 1 ) ? " Exhale " : " Inhale "
      sub_pose = ""
      
      if pose.has_key?(:sub_poses) && (!pose[:sub_poses][counter - 1].nil?)
        sub_pose = "<break time='100ms' /> #{pose[:sub_poses][counter - 1]}"
      end
      puts "#{breath} #{sub_pose}<break time='#{break_time}ms'/>"      
    end
    # break
  end
  # break
end

puts "<break time='500ms'/>Take a short break for pranayama</speak>"
