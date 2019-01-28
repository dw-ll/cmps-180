select customerID, custName, address
from customers
where isvalidcustomer ='t' and custName like '%FAKE %';