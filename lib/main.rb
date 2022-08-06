require_relative './node.rb'
require_relative './setup.rb'

game = Setup.new
game.create_grid
game.set_player_color

until game.a_winner? 
    game.update_grid
    puts ""

    if game.play(game.p1) == false
        puts "its a draw"
        break
    end

    if game.a_winner?
        puts 'p1 wins'
        break
    end

    if game.play(game.p2) == false
        puts "its a draw"
        break
    end

    if game.a_winner?
        puts 'p2 wins'
        break
    end
end

