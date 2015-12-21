require 'csv'
require 'pry'
require 'matrix'
class NeuralNet

  def initialize#(json)
    @training_size = 10000
    @iteration = 1

    @correct = 0
    @correct_log = []
    # functions
    @output_function = 'softmax'
    @hidden_function = 'sigmoid'

    @bias1 = 1.0
    @bias2 = 1.0
    # inputs
    @input_size = 784
    @input_size_bias = @input_size + 1
    @bit = 255.0
    # hidden
    @hidden_layer_size = 20
    @hidden_layer_size_bias = @hidden_layer_size + 1
    # classes
    @output_size = 10
    # logs
    @classification_logs = []
    @error_logs = []

    # learning rate
    @lr = 0.05
    set_initial_weights
    # array with only
    @label = 1
    ##
    @y = Array.new(@output_size) { 0 }

    @training_data = []
    @testing_data = []

    CSV.foreach('train.csv') do |row|
      if @training_data.size <= @training_size
        @training_data << row.map(&:to_i)
        puts 'Row: ', @training_data.size
      else
        @testing_data << row.map(&:to_i)
        puts 'Row: ', (@training_data.size + @testing_data.size)
      end

      break if @training_data.size + @testing_data.size == @training_size + (@training_size/5.0).to_i
    end
    ##
  end
  def outclass
    @testing_data = []
    CSV.foreach('test.csv') do |row|
        @testing_data << row.map(&:to_i)
        puts 'Row: ', @testing_data.size
    end
    test
  end

  def feedback

    dt = (Time.now-@t_1)
    puts 'time', dt
    puts 'iterations per ', @iteration/dt
    puts 'eta', (@training_size - @iteration)*dt/@iteration
    puts 'Iteration: ', @iteration
    puts 'Fraction correct: ', @correct_log.count(true).to_f / @iteration.to_f
    if @iteration > 1000
      puts 'Fraction correct last 1000: ', @correct_log[@correct_log.size-1000..-1].count(true).to_f / 1000
    end
    puts 'Classification: ', @classification_logs.last
    puts 'Error: ', @error_logs.last
    puts 'Bias1: ', @bias1
    puts 'Bias2: ', @bias2
    puts 'Weights 1: ', @weights_hidden.row(0)[0]
    puts 'Weights 2: ', @weights_output.row(0)[0]
  end
  def train
    @t_1 = Time.now
    @iteration = 1
    (@training_size-2).times do
      @features = @training_data[@iteration][1..@input_size]
      @label = @training_data[@iteration][0]
      forward(@features, @label)
      feedback
      @iteration = @iteration + 1
    end
    save_weights
  end
  def test
    @correct = 0
    @correct_log =[]
    @iteration = 1
    @testing_data.size.times do
      @features = @testing_data[@iteration-1][1..@input_size]
      @label = @testing_data[@iteration-1][0]
      classification = classifying(@features, @label)

      feedback
      @iteration = @iteration + 1
    end
  end
  def testing(features)
    @label == classifying(features)
  end

  def classifying(features, label)
    i_a = Vector.elements(features << @bias1) / @bit
    z_v_h = []
    @hidden_layer_size.times do |i|
      z_v_h << @weights_hidden.row(i).inner_product(i_a)
    end
    z_p_h = sigmoid_prime(z_v_h)
    #  z_vector_hidden = (dot_mat(@weights_hidden, input_activation).to_nm+@bias1).to_a
    #
    h_a = Vector.elements(activation(@hidden_function, z_v_h) << @bias2)
    #
    z_v_o = []

    @output_size.times do |i|
      z_v_o << @weights_output.row(i).inner_product(h_a)
    end
    z_p_o = sigmoid_prime(z_v_o)

    # z_vector_output = (dot_mat(@weights_output, hidden_activation.to_a).to_nm+@bias2).to_a
    o_a = activation(@output_function, z_v_o)

    guess = o_a.find_index(o_a.max(1)[0])
    o_a = Vector.elements(o_a)
    @classification_logs << [guess, label]
    @correct += 1 if guess == label
    @correct_log << (guess == label)
    y = Array.new(10) { 0 }
    y[label] = 1.0

    dC = (o_a - Vector.elements(y))
    return  i_a, h_a, z_p_o, z_p_h,dC,guess,label
  end

  def training(data)
    @training_size.times do
      @features = data[@iteration + 1][1..@input_size]
      @label = data[@iteration + 1][0]
      forward(@features, @label)

      @iteration += 1
    end
  end

  def generalize(features,label)
    binding.pry



  end


  def forward(features, label)
    classification = classifying(features, label)
    back(classification[0],classification[1],classification[2],classification[3],classification[4])
  end

  def back(input_activation, hidden_activation,z_p_o, z_p_h,dC)

    # error_output = hadamard(dC,soft_max_prime(z_vector_output),1)
    o_e = []
    h_e = []
    @hidden_layer_size.times do |w|
      h_e << (@weights_output.column(w).inner_product(dC) * z_p_h[w])
    end
    # @weights_hidden.transpose.row_count.times do |w|
    #   h_e << @weights_hidden.transpose.row(w).inner_product(Vector.elements(o_e)) * input_activation[w]
    # end

    dWh = []
    dWo = []
    @hidden_layer_size.times do |l|
      if l == 0
        r = []
        @input_size_bias.times do |o|
          r << h_e[l] * input_activation[o]
        end
        dWh = Vector.elements(r).covector
        r = []
      else
        r = []
        @input_size_bias.times do |o|
          r << h_e[l] * input_activation[o]
        end

        dWq = Vector.elements(r).covector
        dWh = dWh.vstack(dWq)
        r = []
      end
    end

    @output_size.times do |l|
      if l == 0
        r = []
        @hidden_layer_size_bias.times do |o|
          r << dC[l] * hidden_activation[o]
        end
        dWo = Vector.elements(r).covector
      else
        r = []
        @hidden_layer_size_bias.times do |o|
          r << dC[l] * hidden_activation[o]
        end
        dWv = Vector.elements(r).covector
        dWo = dWo.vstack(dWv)
        r = []

      end
    end
    # change weights with gradient decent
    # @weights_hidden = @weights_hidden.to_nm - error_hidden.dot(input_activation)*@lr*0.1).to_a
    # @weights_output = (@weights_output.to_nm - error_output,hidden_activation)*@lr).to_a
    @weights_hidden = (@weights_hidden - dWh * @lr)
    @weights_output = (@weights_output - dWo * @lr)
    @error_logs << dC.collect(&:abs).inject(:+)

    #   @bias1 = @bias1 - h_e.inject(:+)*@lr
    #   @bias2 = @bias2 - o_e.inject(:+)*@lr
    # logs
  end
  def save_weights
    CSV.open("weight.csv", "a+") do |csv_file|
        csv_file <<[@weights_hidden.to_a]
        csv_file <<[@weights_output.to_a]
    end
  end

  def set_initial_weights
    @init_factor_1 = 1 / ((@input_size)**(0.5))
    @init_factor_2 = 1 / (@hidden_layer_size**(0.5))
    h_w = []
    o_w = []

    @hidden_layer_size.times do |i|
      if i == 0
        h_w = (Vector.elements(Array.new(@input_size_bias) { (rand(0.1) - 0.5) })).covector
      else
        n_w = (Vector.elements(Array.new(@input_size_bias) { (rand(0.1) - 0.5) })).covector
        h_w = h_w.vstack(n_w)
      end
    end
    @output_size.times do |i|
      if i == 0
        o_w = (Vector.elements(Array.new(@hidden_layer_size_bias) { (rand(0.1) - 0.5) })).covector
      else
        l_w = (Vector.elements(Array.new(@hidden_layer_size_bias) { (rand(0.1) - 0.5) })).covector
        o_w = o_w.vstack(l_w)
      end
    end

    # h_w[0] = [column of weights for hidden node 1]
    @weights_hidden = h_w * @init_factor_1
    @weights_output = o_w * @init_factor_2
  end

  # matrix math
  def dot(m, n)
    sum = 0.0
    for i in 0...m.size
      sum += m[i] * n[i]
    end
    sum
  end

  def dot_mat(m, l)
    a = []

    sum = 0.0
    m.size.times do |r|
      m[r].size.times do |i|
        sum += m[r][i] * l[i]
      end

      a << sum
      sum = 0
    end
    a
  end

  def hadamard(m, n, const)
    unless n.class == Array
      hold = n
      n = Array.new(m.size)
      m.size.times do |r|
        n[r] = hold
      end
    end
    o = []
    m.size.times do |r|
      o[r] = m[r] * n[r] * const
    end
    n = []
    hold = n[0]
    o
  end

  def mat_sub(m, n)
    o = Array.new(m.size)
    m.size.times do |r|
      o[r] = m[r] - n[r]
    end
    o
  end

  # activation
  def activation(activation_function, z_vector)
    if activation_function = @hidden_function
      return sigmoid(z_vector)
    elsif activation_function = @output_function
      return soft_max(z_vector)
    end
  end

  # activation functions and devrivatives
  def sigmoid(z)
    res = Array.new(z.size)
    z.each_with_index do |z, i|
      res[i] = (1.0 / (1.0 + Math.exp(-z)))
    end
    res
  end

  def sigmoid_prime(z)
    res = Array.new(z.size)
    z.each_with_index do |z, i|
      res[i] = ((1.0 / (1.0 + Math.exp(-z))) * (1 - (1.0 / (1.0 + Math.exp(-z)))))
    end
    res
  end

  def soft_max(z)
    res = Array.new(z.size)
    z.each_with_index do |z, i|
      res[i] = Math.exp(z)
    end
    sum = res.inject(:+)
    res.each_with_index do |res, i|
      res[i] = res / sum
    end
    res
  end

  def sof_max_prime
  end
end
