# ---------------------------------------------------
# Write methods in the Scheduler class to generate the following output
#
#	 (after 1 sec) time is now 1 seconds
#	 (after 2 sec) time is now 2 seconds
#	 (after 3 sec) time is now 3 seconds
#
# from the program:
#
#			 class Scheduler
#			 end

#			 Scheduler.after 3 do
#			 	puts "time is now 3 seconds"
#			 end

#			 Scheduler.after 2 do
#			 	puts "time is now 2 seconds"
#			 end

#			 Scheduler.after 1 do
#			 	puts "time is now 1 seconds"
#			 end

#			 Scheduler.run
# ---------------------------------------------------

require 'pry'

class Scheduler
  @@jobs = []

  def self.run
    @@jobs.sort_by! { |job| job[0] }

    current_time = 0

    @@jobs.each do |start_time, handler|
      puts "before call: current_time = #{Time.now}"

      sleep(start_time - current_time)
      handler.call

      puts "after call: current_time = #{Time.now}"
      puts

      current_time = start_time
      end
  end

  def self.after(period, &handler)
    @@jobs << [period, handler]
  end
end

Scheduler.after 8 do
  puts "time is now 8 seconds"
end

Scheduler.after 5 do
  puts "time is now 5 seconds"
end

Scheduler.after 2 do
  puts "time is now 2 seconds"
end

Scheduler.after 1 do
  puts "time is now 1 seconds"
end

Scheduler.run
