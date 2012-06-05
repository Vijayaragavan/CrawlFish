#! /usr/bin/gawk -f

BEGIN {
	FS = "\"";
}

{
	if (NR == 1 && NF == 12)
	{
		i=2
		if (i==2 && $i=="Mobile Name")
		{
			i=i+1
			if (i==3 && $i=="Mobile Image URL")
			{
				i=i+1
				if (i==4 && $i=="Mobile Brand")
				{
					i=i+1
					if (i==5 && $i=="Mobile Colour")
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
	
	if (NR == 1 && NF == 11)
	{
		i=2
		if (i==2 && $i=="Mobile Name")
		{
			i=i+1
			if (i==3 && $i=="Mobile Image URL")
			{
				i=i+1
				if (i==4 && $i=="Mobile Brand")
				{
					i=i+1
					if (i==5 && $i=="Mobile Colour")
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
										if (i==10 && $i=="Special Offers")
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

