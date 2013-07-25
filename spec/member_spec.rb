require "spec_helper"


module FutebolApp
  describe Member do
    let(:team) { double("a team")  }
    let(:league) { double("a league") }
    subject { Member.new team: team, league: league  }

    context "before playing any matches" do
      it "starts with zero points" do
        expect( subject.points  ).to eq 0
      end

      it "starts with zero games played" do
        expect( subject.games_played  ).to eq 0
      end

      it "starts with zero wins "do
        expect( subject.wins  ).to eq 0
      end

      it "starts with zero losses "do
        expect( subject.losses  ).to eq 0
      end

      it "starts with zero draws "do
        expect( subject.draws  ).to eq 0
      end

      it "starts with zero goals scored "do
        expect( subject.goals_scored  ).to eq 0
      end

      it "starts with zero goals against" do
        expect( subject.goals_against  ).to eq 0
      end
      
      it "starts with no goal difference" do
        expect( subject.goal_difference  ).to eq 0
      end
    end

    context "after playing a match" do
      let(:result) { double("a match result", id: "an match id") }

      context "after winning" do
        let!(:goals) { Random.rand 1..10 }
        let!(:goals_suffered) { Random.rand 0..goals }
        before do
          result.stub(:goals_for).and_return(goals)
          result.stub(:goals_for_opponent).and_return(goals_suffered)
          subject.win!(result)
        end

        it "gains 3 points" do
          expect(subject.points).to eq 3
        end

        it "raises games played by 1" do
          expect(subject.games_played).to eq 1
        end
        
        it "raises wins by 1" do
          expect(subject.wins).to eq 1
        end
        
        it "keeps losses in 0" do
          expect(subject.losses).to eq 0
        end

        it "keeps draws in 0" do
          expect(subject.draws).to eq 0
        end

        it "raises goals scored" do
            expect(subject.goals_scored).to eq(goals)
        end

        it "raises goals against" do
          expect(subject.goals_against).to eq(goals_suffered)
        end

        it "raises goal difference" do
          expect(subject.goal_difference).to eq(goals - goals_suffered)
        end

        context "doesn't compute more than once the same match" do
          before do
            subject.win!(result)
          end

          it "doesn't change game statistics" do
            expect(subject.points).to eq 3
            expect(subject.games_played).to eq 1
            expect(subject.wins).to eq 1
            expect(subject.losses).to eq 0
            expect(subject.draws).to eq 0
            expect(subject.goals_scored).to eq(goals)
            expect(subject.goals_against).to eq(goals_suffered)
            expect(subject.goal_difference).to eq(goals - goals_suffered)
          end


        end

      end

      context "after losing" do
        let!(:goals_suffered) { Random.rand 1..10 }
        let!(:goals) { Random.rand 0..goals_suffered }
        before do
          result.stub(:goals_for).and_return(goals)
          result.stub(:goals_for_opponent).and_return(goals_suffered)
          subject.loss!(result)
        end

        it "doesn't gain points" do
          expect(subject.points).to eq 0
        end

        it "raises games played by 1" do
          expect(subject.games_played).to eq 1
        end
        
        it "doesn't raises wins" do
          expect(subject.wins).to eq 0
        end
        
        it "raises losses to 1" do
          expect(subject.losses).to eq 1
        end

        it "keeps draws in 0" do
          expect(subject.draws).to eq 0
        end

        it "raises goals scored" do
            expect(subject.goals_scored).to eq(goals)
        end

        it "raises goals against" do
          expect(subject.goals_against).to eq(goals_suffered)
        end

        it "raises goal difference" do
          expect(subject.goal_difference).to eq(goals - goals_suffered)
        end
        
        context "doesn't compute more than once the same match" do
          before do
            subject.loss!(result)
          end

          it "doesn't change game statistics" do
            expect(subject.points).to eq 0
            expect(subject.games_played).to eq 1
            expect(subject.wins).to eq 0
            expect(subject.losses).to eq 1
            expect(subject.draws).to eq 0
            expect(subject.goals_scored).to eq(goals)
            expect(subject.goals_against).to eq(goals_suffered)
            expect(subject.goal_difference).to eq(goals - goals_suffered)
          end


        end


      end

      context "after drawing" do
        let!(:goals) { Random.rand 1..10 }
        let!(:goals_suffered) { goals }
        before do
          result.stub(:goals_for).and_return(goals)
          result.stub(:goals_for_opponent).and_return(goals_suffered)
          subject.draw!(result)
        end

        it "gains 1 point" do
          expect(subject.points).to eq 1 
        end

        it "raises games played by 1" do
          expect(subject.games_played).to eq 1
        end
        
        it "keeps wins in 0" do
          expect(subject.wins).to eq 0
        end
        
        it "keeps losses in 0" do
          expect(subject.losses).to eq 0
        end

        it "raises draws by 1" do
          expect(subject.draws).to eq 1
        end

        it "raises goals scored" do
            expect(subject.goals_scored).to eq(goals)
        end

        it "raises goals against" do
          expect(subject.goals_against).to eq(goals_suffered)
        end

        it "keeps goal_difference in zero" do
          expect(subject.goal_difference).to eq 0
        end
        context "doesn't compute more than once the same match" do
          before do
            subject.draw!(result)
          end

          it "doesn't change game statistics" do
            expect(subject.points).to eq 1
            expect(subject.games_played).to eq 1
            expect(subject.wins).to eq 0
            expect(subject.losses).to eq 0
            expect(subject.draws).to eq 1
            expect(subject.goals_scored).to eq(goals)
            expect(subject.goals_against).to eq(goals_suffered)
            expect(subject.goal_difference).to eq 0
          end
        end
      end
    end

    context "with a reset!" do
      let(:result) { double("a match result", id: "an match id") }
      let!(:goals) { Random.rand 3..5 }
      let!(:goals_suffered) { Random.rand 1..3 }

      before do
        result.stub(:goals_for).and_return(goals)
        result.stub(:goals_for_opponent).and_return(goals_suffered)
        subject.win!(result)
        subject.reset!
      end
      
      it "resets game statistics" do
        expect(subject.points).to eq 0
        expect(subject.games_played).to eq 0
        expect(subject.wins).to eq 0
        expect(subject.losses).to eq 0
        expect(subject.draws).to eq 0
        expect(subject.goals_scored).to eq  0
        expect(subject.goals_against).to eq 0
        expect(subject.goal_difference).to eq 0
      end
        

      it "permits recomputation of results" do
        subject.win!(result)
        expect(subject.points).to eq 3
        expect(subject.games_played).to eq 1
        expect(subject.wins).to eq 1
        expect(subject.losses).to eq 0
        expect(subject.draws).to eq 0
        expect(subject.goals_scored).to eq  goals
        expect(subject.goals_against).to eq goals_suffered
        expect(subject.goal_difference).to eq(goals - goals_suffered)
      end
    end
  end
end
