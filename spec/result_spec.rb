require "spec_helper"

module FutebolApp
  describe Result do
    let(:match) { double("a match") }
    let(:home) { double("home team", to_s: "home team").as_null_object }
    let(:visitors) { double("visitors team", to_s: "visitors team").as_null_object }
    let(:goal) { double("a goal", team: home) }
    let(:goal_against) { double("a goal against", team: visitors) }
    let(:victory_goal) { double("victory goal", team: home) }

   
    before(:each) do
      match.stub(:home).and_return(home)
      match.stub(:visitors).and_return(visitors)
    end

    subject { Result.new(match: match) }

    it "sets the match" do
      expect(subject.match).to eq match
    end

    it "starts as a scheduled game" do
      expect(subject.status).to eq :scheduled  
    end

    it "starts with scores tied" do
      expect(subject.for_home).to eq 0
      expect(subject.for_visitors).to eq 0
      expect(subject.draw?).to be_true
    end

    it "doesn't let add_goals until kickoff!" do
      expect { subject.add_goal goal  }.to_not change { subject.goals  }
    end

    it "adds goals after kickoff!" do
      subject.kickoff!
      expect { subject.add_goal goal }.to change { subject.goals }.from([]).to([goal])
      expect { subject.add_goal victory_goal}.to change { subject.goals }.to([goal, victory_goal])
    end

    it "changes the status to playing when kickoff! is called" do
      expect{subject.kickoff!}.to change {subject.status}.from(:scheduled).to(:playing)
    end

    context "Home team wins" do
      before do
        subject.kickoff!
      end

      it "makes one goal and the visitors none" do
        subject.add_goal goal
      end

      it "wins with one goal of differene" do
        subject.add_goal goal
        subject.add_goal goal_against
        subject.add_goal victory_goal
      end

      context "with a walkover" do
        it "wins by walkover" do
          subject.walkover!(home)
        end
      end

      after do
        subject.finish!
        expect(subject.winner).to eq(home)
      end

    end

    context "Home team loses" do
      let(:loss_goal) { double("victory goal", team: visitors) }

      before do
        subject.kickoff!
      end

      it "suffers one goal and make none" do
        subject.add_goal goal_against
      end

      it "makes one goal but suffer two" do
        subject.add_goal goal
        subject.add_goal goal_against
        subject.add_goal loss_goal
      end

      context "with a walkover" do
        it "loses by walkover" do
          subject.walkover!(visitors)
        end
      end

      after do
        subject.finish!
        expect(subject.winner).to eq(visitors)
      end
    end

    context "Home team draws" do
      it "is a tie when none of the teams scores" do
        expect(subject.goals).to eq []
      end

      it "is a tie when both teams scores the same number of times" do
        subject.add_goal goal
        subject.add_goal goal_against
      end

      after do
        subject.finish!
        expect(subject.draw?).to be_true
      end
    
    end

    context "The Score" do
      before do
        subject.kickoff!
      end
      it "prints the score" do
        expect(subject.to_s).to eq "home team - 0 vs 0 - visitors team"
      end

      it "counts the home team score" do
        subject.add_goal goal
        subject.add_goal victory_goal
        expect(subject.goals_for(home)).to eq 2
        expect(subject.for_home).to eq 2
      end

      it "counts the visitors team score" do
        subject.add_goal goal_against
        expect(subject.goals_for_opponent(home)).to eq 1
        expect(subject.for_visitors).to eq 1 
      end
    end
  end
end
