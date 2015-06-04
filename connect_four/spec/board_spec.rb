require "spec_helper"

module ConnectFour
  describe Board do
    context "#initialize" do
      it "initializes the board with a grid" do
        expect {Board.new(grid: "grid")}.to_not raise_error
      end

      it "sets the grid with six rows by default" do
        board = Board.new
        expect(board.grid.size).to eq(6)
      end

      it "creates seven things in each row by default" do
        board = Board.new
        board.grid.each do |row|
          expect(row.size).to eq(7)
        end
      end
    end

    context "#grid" do
      it "returns the grid" do
        board = Board.new(grid: "blah")
        expect(board.grid).to eq "blah"
      end
    end

    context "get_cell" do
      it "returns the cell based on the (x, y) coordinate" do
        grid = [
                 ["", "", "", "", "", "", ""],
                 ["", "", "", "", "", "", ""],
                 ["", "", "", "", "Something", "", ""],
                 ["", "", "", "", "", "", ""],
                 ["", "", "", "", "", "", ""],
                 ["", "", "", "", "", "", ""]
               ]
        board = Board.new(grid: grid)
        expect(board.get_cell(4, 3)).to eq "Something"
      end
    end

    context "#set_cell" do
      it "updates the values of the cell object at a (x, y) coordinate" do
        board = Board.new
        board.set_cell(0, 0, "meow")
        expect(board.get_cell(0, 0).value).to eq "meow"
      end
    end
    
    TestCell = Struct.new(:value)
    let(:x_cell) {TestCell.new("X")}
    let(:y_cell) {TestCell.new("Y")}
    let(:empty) {TestCell.new}

    context "#game_over" do
      it "returns :winner if winner? is true" do
        board = Board.new
        allow(board).to receive(:winner?) {true}
        expect(board.game_over).to eq :winner
      end

      it "returns :draw if winner? is false and draw? is true" do
        board = Board.new
        allow(board).to receive(:winner?) {false}
        allow(board).to receive(:draw?) {true}
        expect(board.game_over).to eq :draw
      end

      it "returns false if winner? is false and draw? is false" do
        board = Board.new
        allow(board).to receive(:winner?) {false}
        allow(board).to receive(:draw?) {false}
        expect(board.game_over).to be false
      end
    end
  end
end
