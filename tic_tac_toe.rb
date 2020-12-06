class Players
    attr_reader :marker
    attr_reader :name
    def initialize(marker,name)
        @marker = marker
        @name = name
    end
end

class Game


    @@board = (1..9).to_a
    @@win_condition = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    def initialize
        @p1_name = ''
        @p2_name= ''
        @p1_marker = ''
        @p2_marker = ''

        start_set()

        @player1 = Players.new(@p1_marker, @p1_name)
        @player2 = Players.new(@p2_marker, @p2_name)
    end

    public
    def play_game
        display_board()
        for i in (0..4)
            play_a_round(@player1.marker,@player1.name)
            if verify_win == true
                break
            end
            if verify_tie == true
                break
            end
            play_a_round(@player2.marker,@player2.name)
        end
        
    end
    
    private
    def start_set
        print 'Player 1 name: '
        @p1_name = gets.chomp
        print 'Player 1 marker (X or O): '
        @p1_marker = gets.chomp.upcase
        while @p1_marker != 'X' && @p1_marker != 'O'
            puts 'Invalid marker'
            print 'Player 1 marker (X or O): '
            @p1_marker = gets.chomp.upcase
        end
        print 'Player 2 name: '
        @p2_name = gets.chomp
        @p2_marker = auto_marker(@p1_marker)
        puts "#{@p2_name} marker will be #{@p2_marker}"
    end

    
    private
    def auto_marker(val)
        new_val = ''
        val == 'O' ? new_val = 'X' : new_val = 'O'
        return new_val 
    end


    private
    def mark_board(marker,index)
        r_index = index-1
        @@board[r_index] = marker
    end

    private
    def display_board
        line = '-------------'
        puts line
        puts "| #{@@board[0]} | #{@@board[1]} | #{@@board[2]} |"
        puts line
        puts "| #{@@board[3]} | #{@@board[4]} | #{@@board[5]} |"
        puts line
        puts "| #{@@board[6]} | #{@@board[7]} | #{@@board[8]} |"
        puts line
    end

    private
    def play_a_round(marker, player)
        puts "#{player} enter a value"
        value = gets.chomp.to_i
        while value < 1 || value > 9 || @@board[value-1] == 'X' || @@board[value-1] == 'O'
            puts 'Invalid index'
            puts "#{player} enter a value"
            value = gets.chomp.to_i 

        end
        mark_board(marker,value)
        display_board()
    end
    
    private
    def verify_tie
        count = 0
        @@board.each do |mark|
            if mark == 'X' || mark == 'O'
                count += 1
            end
        end
        if count == 9
            puts 'No one wins. This a tie.'
            return true
        end
    end

    
    private 
    def verify_win
        @@win_condition.each do |win|
            val1 = win[0]
            val2 = win[1]
            val3 = win[2]
            if @@board[val1] == @@board[val2] && @@board[val1] == @@board[val3]
                puts "#{@@board[val1]} won this match!"
                return true
            end
        end
    end
end



game = Game.new()
game.play_game()