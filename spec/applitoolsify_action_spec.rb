describe Fastlane::Actions::ApplitoolsifyAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The applitoolsify plugin is working!")

      Fastlane::Actions::ApplitoolsifyAction.run(nil)
    end
  end
end
