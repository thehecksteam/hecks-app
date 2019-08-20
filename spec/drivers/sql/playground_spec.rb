require 'spec_helper'
require 'date'
require_relative '../../../drivers/sql'

describe SoccerSeason::Matches::Match do
  let(:red_team) { SoccerSeason::Teams::Team.new(name: 'redteam').tap(&:save!) }
  let(:player) { SoccerSeason::Players::Player.new(name: 'Chris', team: red_team) }
  subject do
    described_class.new(
      fixture: SoccerSeason::Matches::Fixture.new(
        season: 'summer',
        date: Date.today,
        time: Time.now
      ),
      teams: [
        red_team,
        SoccerSeason::Teams::Team.new(name: 'blueteam').tap(&:save!)
      ],
      pitch: SoccerSeason::Matches::Pitch.new(name: 'backyard')
    )
  end

  describe '#save' do
    it '' do
      subject.add_goal!(
        player: player, time: Time.now
      )
      match = SQL::Database::Matches::Match.first
      expect(match.teams).to include(red_team.record)
    end
  end
end
