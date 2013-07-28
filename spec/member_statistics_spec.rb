require "spec_helper"

module FutebolApp
  describe MemberStatistics do
    context "rank" do
      let(:member) { double("A team").as_null_object }
      subject { MemberStatistics.new member }
      let(:another_team) { double("Another Team").as_null_object }

      it "is first when has more points" do
        another_team.stub(points: 0)
        subject.stub(points: 3)
      end

      it "is first when has the same points, but more wins" do
        another_team.stub(points: 4, wins: 0 )
        subject.stub(points: 4, wins: 1 )
      end

      it "is first when has the same points and wins, but greater goal_difference" do
        another_team.stub(points: 4, wins: 1, goal_difference: 2 )
        subject.stub(points: 4, wins: 1, goal_difference: 4)
      end

      it "is first when has the same points, wins and goal_difference, but more goals_scored" do
        another_team.stub(points: 4, wins: 1, goal_difference: 4, goals_scored: 12 )
        subject.stub(points: 4, wins: 1, goal_difference: 4, goals_scored: 16)
      end

      it "is first when all criterias are the same, but the team name is lexicographically short than the other team name" do
        another_team.stub(points: 4, wins: 1, goal_difference: 4, goals_scored: 16, name: "Real Madrid"  )
        subject.stub(points: 4, wins: 1, goal_difference: 4, goals_scored: 16, name: "Barcelona")
      end

      after do
        expect(subject <=> another_team).to eq -1
      end

    end

  end

end
