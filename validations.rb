def valid_email?(email)
	if email.count("@") != 1 then 
		return false
	elsif email == /^.*@.*(.com|.org|.net|.edu|.gov|.mil|.biz|.info|.io)$/ then 
		return true 
	else
		return false 
	end
end

# exp = /^.*@.*(.com|.org|.net|.edu|.gov|.mil|.biz|.info|.io)$/

