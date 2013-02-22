misc-ruby-code
==============

**fibonacci_sequence.rb**

  Program for generating the fibonacci sequence of numbers:

    index:                1  2  3  4  5  6  7   8
    fibonacci sequence:   0, 1, 1, 2, 3, 5, 8, 13, ...

----------------------------------------------------------------

soc.rb:
 - Given a text file(data.txt), treat each line of the file as a string.
 - Generate and print out all the permutations of each of these strings.

----------------------------------------------------------------

scheduler.rb:
 Given the test program:

       class Scheduler
       end

       Scheduler.after 3 do
       	puts "time is now 3 seconds"
       end

       Scheduler.after 2 do
       	puts "time is now 2 seconds"
       end

       Scheduler.after 1 do
       	puts "time is now 1 seconds"
       end

       Scheduler.run

 Write methods in the Scheduler class to generate the following output

        - (after 1 sec) time is now 1 seconds
        - (after 2 sec) time is now 2 seconds
        - (after 3 sec) time is now 3 seconds
