INSERT INTO [call_center_DB].[dbo].[Customers]
           ([customer_ID]
           ,[customer_Address_Line_1]
           ,[customer_Address_Line_2]
           ,[customer_Address_Line_3]
           ,[town_city]
           ,[state]
           ,[email_Adress]
           ,[phone_Number]
           ,[customer_Other_Details])
  SELECT  [customer_ID]
      ,[customer_Address_Line_1]
      ,[customer_Address_Line_2]
      ,[customer_Address_Line_3]
      ,[town_city]
      ,[state]
      ,[email_Adress]
      ,[phone_Number]
      ,[customer_Other_Details] from dbo.randomdata$



