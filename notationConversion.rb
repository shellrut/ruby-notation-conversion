#!/usr/bin/ruby

#--------------------------------------------------#									
#	Developer -- Shelby Rutland					
#	Date ------- March 15, 2021					
#												
#	This Ruby program converts expressions		
#	from postfix notation to infix notation.	
#--------------------------------------------------#

#--------------------------------------------------#
#	Stack										
#												
#	This class represents the stack and			
#	includes methods for the fundamental stack	
#	operations: push, pop, and isEmpty.			
#--------------------------------------------------#

# Class to represent the stack
class Stack
	# Initialize the stack
	def initialize
		@data = []
		@head = -1
	end
	# Push method
	def push value
		@data << value
		@head += 1
	end
	# Pop method
	def pop
		result = @data[@head]
		@data.delete_at(@head)
		@head -= 1
		result
	end
	# isEmpty method
	def isEmpty
		@head == -1
	end
end

#--------------------------------------------------#
#	main program								
#												
#	The main program will prompt the user for	
#	the names of the input and output files,	
#	read each expression in the input file,		
#	perform the conversion, and write the		
#	resulting infix expressions to an output
#	file.								
#												
#	If the input file contains too many			
#	operators or operands, the program won't	
#	complete the conversion, but instead will	
#	output an error message with the
#	ill-formed postfix expression.							
#--------------------------------------------------#

def main
	print "Input filename: "
	input = gets.chomp
	print "Output filename: "
	output = gets.chomp
	file = File.open(input)
	str = file.read
	stack = Stack.new
	operand = /[A-Z]/
	operator = /[\-\+\*\/]/
	str.each_line do |line|
		line.each_char do |i|
			if (i =~ operand)
				stack.push(i)
			elsif (i =~ operator)
				op1 = stack.pop
				op2 = stack.pop
				stack.push("(#{op1} #{i} #{op2})")
			end
		end
	end 
	File.open(output,"w") do |f|
		until stack.isEmpty
			f.puts(stack.pop)
		end
		if stack =! 0
			f.puts("Error: ill-formed postfix expression" + stack.pop)
		end
	end
end

main
