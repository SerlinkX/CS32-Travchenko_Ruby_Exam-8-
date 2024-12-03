# Основний клас Timer
class Timer
  def self.measure
    start_time = Time.now
    yield
    end_time = Time.now
    elapsed_time = end_time - start_time
    puts "Час виконання: #{elapsed_time} секунд"
    elapsed_time
  end
end

# Юніт-тестування класу Timer
require 'minitest/autorun'

class TestTimer < Minitest::Test
  def test_measure_execution_time
    elapsed_time = Timer.measure do
      sleep(1)  # Блок, що імітує роботу протягом 1 секунди
    end
    assert_in_delta 1.0, elapsed_time, 0.1, "Час виконання повинен бути приблизно 1 секунда"
  end

  def test_measure_fast_execution
    elapsed_time = Timer.measure do
      sum = (1..1000).reduce(:+)
    end
    assert elapsed_time < 0.1, "Час виконання має бути меншим за 0.1 секунди для швидкого блоку"
  end

  def test_measure_empty_block
    elapsed_time = Timer.measure do
      # Порожній блок
    end
    assert elapsed_time < 0.01, "Час виконання порожнього блоку має бути дуже малим"
  end
end
