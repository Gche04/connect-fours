
require './lib/setup.rb'
require './lib/node.rb'

describe Setup do
    subject(:game) { described_class.new }

    context 'when p1 is x' do
        before do
            p1 = 'x'
            allow(game).to receive(:gets).and_return(p1)
        end

        it 'assigns "(o)" to p2' do
            game.set_player_color
            expect(game.instance_variable_get(:@p2)).to eql("(o)")
        end

        it 'assigns player1_selection to p1' do
            game.set_player_color
            expect(game.instance_variable_get(:@p1)).to eql("(x)")
        end
    end

    context 'when grid has been build correctly' do
        it 'has a height of 5' do
            game.create_grid
            grid = game.instance_variable_get(:@grid)
            heigth = 0
            while grid
                heigth = grid.index
                grid = grid.child
            end
            expect(heigth).to eql(5)
        end
    end

    context 'when grid is updated' do
        xit 'prints five arrays' do
            expect(game.update_grid).to receive(:puts).exactly(6).times
        end
    end

    context 'when token is dropped at an empty column' do
        it 'updates at the top of the grid at the give index' do
            idx = 0
            col = '(x)'
            game.create_grid
            game.drop_token(idx, col)
            grid = game.instance_variable_get(:@grid)
            result = ''
            while grid
                result = grid.arr[idx]
                grid = grid.child
            end
            
            expect(result).to eq("(x)")
        end
    end

    context 'if grid still has available slots' do
        it 'returns true if slots are available' do
            game.create_grid
            result = game.more_slot?
            expect(result).to eq(true)
        end
    end

    context 'checks for winner' do
        it 'returns false if no winner' do
            game.create_grid
            grid = game.instance_variable_get(:@grid)
            expect(game.a_winner?).to eq(false)
        end

        it 'returns true for horizontal four' do
            game.create_grid
            grid = game.instance_variable_get(:@grid)
            py1 = game.instance_variable_set(:@p1, '(x)')

            grid.arr[0] = py1
            grid.arr[1] = py1
            grid.arr[2] = py1
            grid.arr[3] = py1

            expect(game.a_winner?).to eq(true)
        end

        it 'returns true for vertical four' do
            game.create_grid
            grid = game.instance_variable_get(:@grid)
            py1 = game.instance_variable_set(:@p1, '(x)')

            grid.arr[0] = '(x)'
            grid.child.arr[0] = '(x)'
            grid.child.child.arr[0] = '(x)'
            grid.child.child.child.arr[0] = '(x)'

            expect(game.a_winner?).to eq(true)
        end

        it 'returns true for diagonal four' do
            game.create_grid
            grid = game.instance_variable_get(:@grid)
            py1 = game.instance_variable_set(:@p1, '(x)')

            grid.arr[0] = '(x)'
            grid.child.arr[1] = '(x)'
            grid.child.child.arr[2] = '(x)'
            grid.child.child.child.arr[3] = '(x)'

            expect(game.a_winner?).to eq(true)
        end
    end
end