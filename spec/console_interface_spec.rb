require_relative '../lib/consoleinterface'

describe ConsoleInterface do
    
    describe '#ask_question' do
        it 'sends a prompt question to output' do
            output = StringIO.new
            console_interface = ConsoleInterface.new(output: output)

            console_interface.ask_question('Would you like to continue? [yes/no]')

            expect(output.string).to include('continue?')
        end
    end

    describe '#answer' do
        it 'returns a formatted string received from input' do
            input = StringIO.new("iNPut\n")
            console_interface = ConsoleInterface.new(input: input)

            expect(console_interface.answer).to eq('iNPut')
        end
    end
end