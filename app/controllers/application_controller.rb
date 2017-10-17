require 'csv'
require 'linear-regression'
class ApplicationController < ActionController::Base
protect_from_forgery with: :null_sessions

def sums
	CSV.foreach do |row|
	sum=0
	sum += row[0]
	sum=sum.ceil
	render plain: ('%.2f'%sum)
end

def filter
	CSV.foreach do |row|
	sum=0
	sum+erow[1] if row[2]%2!=0
	  end
	end	
	sum=sum.ceil
	render plain: ('%.2f'%sum)
end


def intervals
    sum=0
    line=1
    result=0
    file=CSV.parse(params[:file].read)
    while line < file.length-30 do
      i=0
      while i<30
        sum+=file[line+i][0].to_i
        i+=1
      end  
      if sum > result
        result=sum
      end 
      sum=0
      line+=1  
   end
   result=result.ceil
   render plain: ('%.2f' % result )

  end 

	def lin_regressions
		arr = CSV.parse(params["file"].read, converters: :numeric)
		x = (1..arr.length).to_a
		y = arr.map {|row| row[0]}
		linear = Regression::Linear.new(x, y)
		a = linear.slope
		b = linear.intercept
		render plain: "%.6f" % a + "," + "%.6f" % b
	end

end
