describe '测试日报类源' do

  before do
    @list = []
  end

  it 'get daily source list' do
    OneStore.daily_source_list do | result |
      @list = result
    end

    wait 3 do
      SpecHelper.sp('@list', @list)
      @list.size.should.not.be == 0
      (@list.first.instance_of? JSSource).should.be == true
    end

  end

  # it 'daily source load' do
  #
  # end

end
