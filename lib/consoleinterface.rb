class ConsoleInterface

    def initialize(input: $stdin, output: $stdout)
        @input = input
        @output = output
    end
    
    def ask_question(question)
        @output.puts question
    end

    def answer
        @input.gets.chomp
    end
end