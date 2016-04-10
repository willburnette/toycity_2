require 'json'

# Get path to products.json, read the file into a string,
# and transform the string into a usable hash
def setup_files
    path = File.join(File.dirname(__FILE__), '../data/products.json')
    file = File.read(path)
    $products_hash = JSON.parse(file)
    $report_file = File.new("../report.txt", "w+")
	end

def create_report
	  print_heading
	  print_data
	end

def start
	  setup_files # load, read, parse, and create the files
	  create_report # create the report!
	end

def print_heading
		$report_file.puts ascii_sales
		$report_file.puts todays_date
	end

def print_data
		make_products_section
		make_brands_section
	end

# Products section methods
def name(toy)
    toy["title"]
  end

def retail_price(toy)
    toy["full-price"].to_f
  end

def purchases(toy)
		toy["purchases"].length
	end

def total_sales(toy)
	  toy["purchases"].inject(0) { |total, purchase| total += purchase["price"] }
end

def avg_price(toy)
	  total_sales(toy) / purchases(toy)
	end

def avg_disc(toy)
	  retail_price(toy).to_f - avg_price(toy).to_f
  end

def disc_perc(toy)
	  (avg_disc(toy).to_f / retail_price(toy).to_f) * 100
  end

def make_products_section
		$report_file.puts ascii_products
			$products_hash["items"].each do |toy|  
			# Print the name of the toy
			$report_file.puts name(toy)
			# Print asterisk line
			$report_file.puts line_asterisk
			# Print the retail price of the toy
			$report_file.puts "Retail Price: $#{retail_price(toy)}"
			# Calculate and print the total number of purchases
			$report_file.puts "Number Purchases: #{purchases(toy)}"
			# Calculate and print the total amount of sales
			$report_file.puts "Total Sales: $#{total_sales(toy)}"
			# Calculate and print the average price the toy sold for
			$report_file.puts "Average Price: $#{avg_price(toy).round(2)}"
			# Calculate and print the average discount ($) based off the average sales price
			$report_file.puts "Average Discout: $#{avg_disc(toy).round(2)}"
			# Calculate and print the average discount (%) based off the average sales price
			$report_file.puts "Average Discount Percentage: #{disc_perc(toy).round(2)}%"
			$report_file.puts "\n"
		end		
	end

# Brands section methods
def make_brands_section
		$report_file.puts ascii_brands
	end

# Print "Sales Report" in ascii art
def ascii_sales
"           _                                       _   
 ___  __ _| | ___  ___   _ __ ___ _ __   ___  _ __| |_ 
/ __|/ _` | |/ _ \/ __| | '__/ _ \ '_ \ / _ \| '__| __|
\__ \ (_| | |  __/\__ \ | | |  __/ |_) | (_) | |  | |_ 
|___/\__,_|_|\___||___/ |_|  \___| .__/ \___/|_|   \__|
                                 |_|                   
\n"                                                  
  end

def line_asterisk
		"*" * 17
	end
# Print today's date
def todays_date
    "Today's Date: #{Time.now.strftime("%x")}"
  end

# Print "Products" in ascii art
def ascii_products
"                     _            _       
                    | |          | |      
 _ __  _ __ ___   __| |_   _  ___| |_ ___ 
| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|
| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\
| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/
| |                                       
|_|                                       "
	end

# Print "Brands" in ascii art
def ascii_brands
" _                         _     
| |                       | |    
| |__  _ __ __ _ _ __   __| |___ 
| '_ \\| '__/ _` | '_ \\ / _` / __|
| |_) | | | (_| | | | | (_| \\__ \\
|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
	end

start # call start method to trigger report generation