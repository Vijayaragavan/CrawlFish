#! /usr/bin/gawk -f

BEGIN {
	FS = "\"";
	v_type = vendorType
}

{
	if (v_type == "Online" )
	{
	if (NR == 1 && NF == 12)
	{
		i=2
		if (i==2 && $i=="Book Name")
		{
			i=i+1
			if (i==3 && $i=="Book Image URL")
			{
				i=i+1
				if (i==4 && $i=="ISBN")
				{
					i=i+1
					if (i==5 && $i=="ISBN 13")
					{
						i=i+1
						if (i==6 && $i=="Price")
						{
							i=i+1
							if (i==7 && $i=="Shipping Cost")
							{
								i=i+1
								if (i==8 && $i=="Shipping Time")
								{
									i=i+1
									if (i==9 && $i=="Availability")
									{
										i=i+1
										if (i==10 && $i=="Redirect URL")
										{
											i=i+1
											if (i==11 && $i=="Special Offers")
											flag=1		
										}	
									}
								}
							}
						}
					}
				}
			}
		}
	}

	}
	
	if (v_type == "Offline" )
	{
	if (NR == 1 && NF == 12)
	{
		i=2
		if (i==2 && $i=="Book Name")
		{
			i=i+1
			if (i==3 && $i=="Book Image URL")
			{
				i=i+1
				if (i==4 && $i=="ISBN")
				{
					i=i+1
					if (i==5 && $i=="ISBN 13")
					{
						i=i+1
						if (i==6 && $i=="Price")
						{
							i=i+1
							if (i==7 && $i=="Availability")
							{
								i=i+1
								if (i==8 && $i=="Door Delivery")
								{
									i=i+1
									if (i==9 && $i=="Delivery Time")
									{
										i=i+1
										if (i==10 && $i=="Delivery Cost")
										{
											i=i+1
											if (i==11 && $i=="Special Offers")
											flag=1		
										}	
									}
								}
							}
						}
					}
				}
			}
		}
	}

	}
	if (flag == 1)
	{
		for (i=2;i<=(NF-1);i++)
		{	
			if (i<(NF-1))
			printf "%s|",$i
			
			if (i==(NF-1))
			printf "%s",$i
		}
		printf "\n"
	}
	
	
}

