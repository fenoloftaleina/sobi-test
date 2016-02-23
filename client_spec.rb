require './client'

describe 'client.rb' do
  let(:bike_id) { 1234 }

  describe '#main' do
    let(:redis) { double(publish: nil) }

    before do
      allow(Redis).to receive(:new).and_return(redis)
    end

    context 'with bike_id' do
      let(:args) { [bike_id] }

      it 'publishes the random message with the bike_id' do
        expect(redis).to receive(:publish).with(anything, /#{bike_id},\w{690}/)

        main(args)
      end

      it 'returns 0' do
        expect(main(args)).to eq(0)
      end
    end

    context 'with custom port' do
      it 'runs redis with the custom port' do
        port = 4321
        args = [bike_id, port]

        expect(Redis).to receive(:new).with(port: port)

        main(args)
      end
    end

    context 'without bike_id' do
      let(:args) { [] }

      it 'does not publish anything' do
        expect(redis).not_to receive(:publish)

        main(args)
      end

      it 'returns -1' do
        expect(main(args)).to eq(-1)
      end
    end
  end
end
