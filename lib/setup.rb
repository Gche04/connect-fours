
require_relative './node.rb'

class Setup
    attr_accessor :p1, :p2
    def initialize
        @p1 = ""
        @p2 = ""
        @grid = Node.new
    end

    def play(player)
        if more_slot? 
            
            puts "p1 pick an available index between 0 and 6"
            idx = gets.chomp.to_i
            puts ""
    
            drop_token(idx, player)
            update_grid
            puts ""
        else
            return false
        end
    end

    def set_player_color
        @p1 = "(#{player1_selection})"
        @p1 == '(x)' ? @p2 = '(o)' : @p2 = '(x)'
    end
    
    def create_grid
        count = 1
        g = @grid

        5.times {
            g.child = Node.new
            g.child.index = count
            g = g.child
            count += 1
        }
    end

    def update_grid(rt = @grid)
        return if rt == nil
        print rt.arr
        puts ""
        update_grid(rt.child)
    end

    def drop_token(idx, color, rt = @grid)
        return if rt == nil
        
        if idx > 6 || idx < 0 || rt.arr[idx] != "()"
            puts "invalid input"
            puts "pick another slot"
            puts ""
            idx = gets.chomp.to_i
            drop_token(idx, color)
            return
        end

        if rt.child == nil
            rt.arr[idx] = color
            return
        end

        unless rt.child.arr[idx] == "()"
            rt.arr[idx] = color
            return
        end

        drop_token(idx, color, rt.child)
    end

    def more_slot?
        @grid.arr.any?{|slot| slot == '()'}
    end

    def a_winner?
        return true if check_vertical?
        return true if check_horizontal?
        return true if check_diagonal?
        false
    end

    private
    def player1_selection
        p1_col = ''

        until p1_col == 'x' || p1_col == 'o'
            puts "p1 - pick 'x'  or   'o'"
            p1_col = gets.chomp
        end
        p1_col
    end

    def check_diagonal?
        point = 0
        count = 0
        num = 7

        until point == 2
            until count == num
                return true if check_diagonal_fours?(count, point)
                point == 0 ? count += 1 : count -= 1
            end
            point += 1
            num = 0
        end
        false
    end

    def check_horizontal?(rt = @grid)
        return if rt == nil

        count = 0
        while count < 4
            fst = rt.arr[count]
            snd = rt.arr[count + 1]
            trd = rt.arr[count + 2]
            fth = rt.arr[count + 3]
            

            return true if fst == @p1 && snd == @p1 && trd == @p1 && fth == @p1
            return true if fst == @p2 && snd == @p2 && trd == @p2 && fth == @p2

            count += 1
        end
        check_horizontal?(rt.child)
    end

    def check_vertical?
        count = 0
        until count == 7
            return true if check_fours?(count)
            count += 1
        end
        false
    end

    def check_fours?(idx, rt = @grid)
        return false if rt.index == 3
        check_fours?(idx, rt.child) if rt.arr[idx] == '()'

        parent = rt
        chld = parent.child
        gchild = chld.child
        ggchild = gchild.child

        return true if parent.arr[idx] == @p1 && chld.arr[idx] == @p1 && gchild.arr[idx] == @p1 && ggchild.arr[idx] == @p1
        return true if parent.arr[idx] == @p2 && chld.arr[idx] == @p2 && gchild.arr[idx] == @p2 && ggchild.arr[idx] == @p2

        check_fours?(idx, rt.child)
    end


    def check_diagonal_fours?(idx, point, rt = @grid)
        return false if rt.index == 3
        check_diagonal_fours?(idx, point, rt.child) if rt.arr[idx] == '()'

        parent = rt
        child = parent.child
        gchild = child.child
        ggchild = gchild.child

        if point == 0
            return true if parent.arr[idx] == @p1 && child.arr[idx +1] == @p1 && gchild.arr[idx +2] == @p1 && ggchild.arr[idx +3] == p1
            return true if parent.arr[idx] == @p2 && child.arr[idx +1] == @p2 && gchild.arr[idx +2] == @p2 && ggchild.arr[idx +3] == p2
        else
            return true if parent.arr[idx] == @p1 && child.arr[idx -1] == @p1 && gchild.arr[idx -2] == @p1 && ggchild.arr[idx -3] == p1
            return true if parent.arr[idx] == @p2 && child.arr[idx -1] == @p2 && gchild.arr[idx -2] == @p2 && ggchild.arr[idx -3] == p2
        end
        check_diagonal_fours?(idx, point, rt.child)
    end
end

#s = Setup.new
#s.create_grid
#s.update_grid
#puts ""
#s.set_player_color
#s.drop_token(0, s.p1)
#s.drop_token(0, s.p1)
#s.drop_token(0, s.p1)
#s.drop_token(0, s.p1)

#s.update_grid

#puts s.a_winner?