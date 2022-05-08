/****** Scriptfor SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ID]
      ,[FkDepartmentID]
      ,[FkCountryID]
      ,[Name]
      ,[Surname]
      ,[Email]
      ,[BirthDate]
      ,[Salary]
  FROM [Test].[dbo].[Personnel]

--1-Bir sorgu içerisinde,alanlardaki deðerleri matematik iþlemlerine tabi tutabilir ve iþlem sonuçlarýný ayrý bir stün halinde görüntüleyebiliriz.
--2-Tarih alanlarý matematik iþlemlerine tabi tutulabilir.(Veritabaný Mantýðý Sayfa:113)

--ÖRNEK KOD:
--SELECT ID,Name,Surname, DATEDIFF(day, BirthDate,'1990/12/12') AS DateDiff from  Personnel;

--Select DATEDIFF(day, BirthDate, convert(date, '1990-12-12', 120)) AS DateDiff from  Personnel;

--Her departmanda toplam kaç kiþi çalýþýyor?-Sayfa 115
--ÖRNEK KOD:
--SELECT FkDepartmentID, COUNT(*) AS Total 
--FROM Personnel

--GROUP BY FkDepartmentID;

--Þirketimizde çalýþanlarýn kaçý Alman,kaçý Türk, kaçý Ýngiliz?

--SELECT FkCountryID, COUNT(*) AS Total
--FROM Personnel
--GROUP BY FkCountryID;
--Önümüzdeki ay çalýþanlara toplam kaç tl maaþ vermem gerekir?_SAYFA-117
--SELECT SUM(Salary) AS Total
--FROM Personnel
--Ýsmi Mehmet olan elemanlar toplam kaç TL maaþ alýyor?_SAYFA-118
  --SELECT SUM(Salary) AS Total
  --FROM Personnel
  --WHERE Name='Mehmet';
 
 --IT departmanýna bu ay kaç TL maaþ ödemesi yapýlacak?_SAYFA-119
 --1.Adým
 --SELECT ID
 --FROM Department
 --WHERE Name='IT'
  --2.Adým
 --SELECT SUM(Salary) AS Total
 --FROM Personnel
 --WHERE FkDepartmentID=4;

  --Herbir departmana ayda  kaç TL maaþ ödemesi yapýlacak?_SAYFA-119
--SELECT FkDepartmentID,SUM(Salary) AS Total
--FROM Personnel
--GROUP BY FkDepartmentID;

--  --Herbir departmana ortalama ayda  kaç TL maaþ ödemesi yapýlýyor?_SAYFA-120
--SELECT FkDepartmentID,AVG(Salary) AS Average
--FROM Personnel
--GROUP BY FkDepartmentID

--  --Herbir departmana ortalama ayda  kaç TL maaþ ödemesi yapýldýðýný yuvarlatarak hesapla?_SAYFA-121
--SELECT FkDepartmentID,ROUND(AVG(Salary),0) AS Average
--FROM Personnel
--GROUP BY FkDepartmentID


--Þirkette en fazla maaþý alan kaç TL alýyor?
--SELECT MAX(Salary) AS MaxSalary
--FROM Personnel;

--Þirkette en az maaþý alan kaç TL alýyor?

--SELECT MIN(Salary) AS MinSalary
--FROM Personnel;

--Þirkette en az maaþý alan ile en çok maaþý alan arasýnda kaç TL fark var?
--SELECT MAX(Salary)- MIN(Salary) AS Differance
--FROM Personnel;

----Þirketimize ilk sipariþi veren müþterimizin ID'sini bulur musunuz?

--SELECT TOP 1 FkCustomerID AS Customer FROM OrderTitle;

----Þirketimize ilk sipariþi veren müþterimizin özlük verilerini alabilir miyiz?

--SELECT*FROM Customer WHERE ID= (SELECT TOP 1 FkCustomerID AS Customer FROM OrderTitle);

----Þirketimize son sipariþi veren müþterimizin özlük verilerini alabilir miyiz?_SAYFA-127

--SELECT*FROM Customer WHERE ID=(SELECT TOP 1 FkCustomerID AS Customer FROM OrderTitle ORDER BY ID DESC);

----Þirketimizin en yüksek maaþ alan personelin özlük verilerini alabilir miyiz?_SAYFA-128
--1.Adým:Personnel tablosunda Salary alanýnda deðeri en yüksek x'i  tespit et.
--SELECT MAX(Salary) AS Maximum FROM Personnel;//Bu sonuç x gibi bir deðerdir.

--2.Adým:Personnel tablosunda Salary alanýnda x deðerini barýndýran kiþiyi tespit et.
--SELECT*FROM Personnel 
--WHERE Salary=x;
--3.Adým:En sade hali;
--SELECT*FROM Personnel 
--WHERE Salary=(SELECT MAX(Salary)  FROM Personnel);

----Þimdiye kadar en az bir sipariþ vermiþ olan müþterilerin ID'lerinin listesini istiyorum?_SAYFA-129
--SELECT FkCustomerID
--FROM OrderTitle;//Bu sorguya göre bazý müþterilerin  ID'leri birden fazla listelenmiþ.Bunun sebebi, bazý müþterilerin birden fazla kez sipariþ vermiþ olmasýdýr.Çünkü her müþteri bir sipariþ verdiðinde,
--OrderTitle tablosuna yeni bir kayýt eklenir.Dolaysýyla müþteri kaç defa sipariþ verdiyse sorgu sonucunda o kadar listelenecektir.
--Peki bu müþteri birden fazla sipariþ vermiþ olsa bile sadece bir kez  nasýl listeleyebiliriz?-_SAYFA-130
--SELECT DISTINCT FkCustomerID FROM OrderTitle;//DISTINCT birden fazla listelenen deðerleri sadece bir kez gelmesini saðlar.


----Þimdiye kadar en az bir sipariþ vermiþ olan müþterilerin özlük bilgilerini istiyorum?_SAYFA-130
--1.YOL
--1.Adým:OrderTitle tablosundan þimdiye kadar sipariþ vermiþ bütün müþterilerin ID'LERÝNÝ tespit ederiz.
--SELECT DISTINCT FkCustomerID FROM OrderTitle
--2.Adým:Tespit ettiðimiz ID'ler ile MUSTERÝ tablosuna giderek bu ID'LERE ait kayýtlarý listeleyeceðiz.

--SELECT*FROM Customer WHERE ID IN(SELECT DISTINCT FkCustomerID FROM OrderTitle)

--2.YOL-->IN yerine EXISTS komutu kullanmak
	--SELECT*FROM Customer
	--WHERE EXISTS(SELECT*FROM OrderTitle WHERE FkCustomerID=Customer.ID);

	----Þimdiye kadar hiç bir sipariþ vermemiþ olan müþterilerin özlük bilgilerini istiyorum?_SAYFA-133
	--SELECT*FROM Customer
	--WHERE NOT EXISTS(SELECT*FROM OrderTitle
	--WHERE FkCustomerID=Customer.ID);

	
	----Þirketimizdeki bütün personelin ve þirketimizi bütün müþterilerin ad,soyad,doðum ve email  bilgilerini istiyorum?_SAYFA-136
	--SELECT Name,Surname,BirthDate, Email 
	--FROM Personnel
	--UNION
	--SELECT Name,Surname,BirthDate,Email 
	--FROM Customer

	--NOT:UNION komutu farklý tablolarýn benzer alanlarýnda bulunan verileri birleþtirerek bir arada listelememizi saðlar.Her tablo için listelenmesini istediðimiz alanlar eþleþmeþse hata alýrýz.

	--Yukarýdaki sorguda kimin personel, kimin müþteri olduðunu anlayamýyorum.Kiþi personel ise yanýna 'Bizim personel'; müþteri ise yanýna 'Bizim Müþteri' yazsýn._SAYFA-139
	--SELECT 'Bizim personel' AS Location, Name,Surname,BirthDate, Email 
	--FROM Personnel
	--UNION
	--SELECT 'Bizim müþteri' AS Location,Name,Surname,BirthDate,Email 
	--FROM Customer

	--Bana her bir personelin ID'sini, adýný ve soyadýný; bunun yaný sýra çalýþtýðý  departmanýn ID'sini ve adýný bir arada listeleyip getirin--_SAYFA-140
	--NOT: Farklý tablolarýn benzer alanlarýnda bulunan verileri birleþtirerek bir arada listelemek için UNION komutu kullanýrken;farklý alanlarýnda bulunan verileri birleþtirerek bir arada listelemek için ise 'INNER JOIN' komutu kullanýlýr.Syntax'ý  FROM TabloAdý1 INNER JOIN TabloAdý2 þeklindedir.
	--NOT: Birden fazla tablodan veri çekmek durumunda kaldýðýmýz durumlarda; alan isimlerinin birbirilerine karýþmamasý adýna, her bir alaný TABLO.ALAN formatýnda ifade etmek lehimize olur.
	--INNER JOIN: Hangi iki tablo arasýnda baðlantý yapýlacaðýný belirtmek için kullanýlýr.Baðlantý iki yönlüdür( Baðlantý Personnel ve Department tablolarý arasýnda þeklinde olabilirdi.).Örnekte Personnel ve Department tablolarý arasýnda baðlantý kurmak için kullanýlmýþtýr.
	--ON:Ýki tablo arasýndaki baðlantýnýn hangi alanlarý eþleþtirerek saðlanabileceðini ifade eder.Bu örnekte  Personnel tablosundaki FkDepartmentID alaný ile Department tablosundaki ID alaný  eþleþtirilerek saðlanmýþtýr.

	--SELECT Personnel.ID,Personnel.Name,Personnel.Surname,Personnel.FkDepartmentID,Department.Name AS DeptName FROM Department INNER JOIN Personnel ON  Personnel.FkDepartmentID=Department.ID;
	--SELECT Personnel.ID,Personnel.Name,Personnel.Surname,Personnel.FkDepartmentID,Department.Name AS DeptName FROM Personnel INNER JOIN Department ON  Personnel.FkDepartmentID=Department.ID;


	--Herbir personelin adýný,soyadýný ve ülkesinin ismini listeleyin.Liste; ülke adý, personel adý ve personel soyadýna göre sýralanmýþ olsun.
	--SELECT 
	--Personnel.Name,
	--Personnel.Surname,
	--Country.Name AS CountryName
	--FROM Personnel INNER JOIN Country ON Personnel.FkCountryID=Country.ID 
	--ORDER BY Country.Name,Personnel.Name,
	--Personnel.Surname;

	--Bana öyle bir liste hazýrlayýn ki, içinde her bir ülkenin ID'si, ismi ve o ülkeden gelen personelin sayýsý olsun._SAYFA-148
	--SELECT
	--Country.ID,
	--Country.Name,
	--COUNT(Personnel.ID) AS TotPersonnel
	--FROM Country
	--INNER JOIN Personnel ON Country.ID=Personnel.FkCountryID
	--GROUP BY Country.ID,Country.Name;

	--LÝstedeki ülkeler nüfus sayýsýna göre büyükten küçüðe doðru sýralanmýþ olsun._SAYFA-151
	--SELECT
	--Country.ID,
	--Country.Name,
	--COUNT(Personnel.ID) AS TotPersonnel
	--FROM Country
	--INNER JOIN Personnel ON Country.ID=Personnel.FkCountryID
	--GROUP BY Country.ID,Country.Name 
	--ORDER BY COUNT(Personnel.ID) DESC;


	--Her bir departmanýn ID'sini, adýný ve o departmana ödenen toplam maaþý artan sýrada tek bir liste içinde görmek istiyorum._SAYFA-151 ve 153

	--SELECT
	--Department.ID,
	--Department.Name,
	--SUM(Personnel.Salary) AS TotSalary
	--FROM Department 
	--INNER JOIN Personnel 
	--ON Department.ID=Personnel.FkDepartmentID
	--GROUP BY Department.ID,Department.Name
	--ORDER BY SUM(Personnel.Salary) ASC;

	--Personele ödenenen maaþlarý ülke bazýnda listelemenizi istiyorum. Çýktýlar, ülke ismine göre sýralanmýþ olsun._SAYFA-154
	--SELECT 
	--Country.ID,
	--Country.Name,
	--SUM(Personnel.Salary) AS TotSalary
	--FROM Personnel 
	--INNER JOIN Country 
	--ON Country.ID=Personnel.FkCountryID
	--GROUP BY Country.ID,Country.Name
	--ORDER BY Country.Name;
	
	--Aylýk maaþý 2000 TL'den fazla kiþilerin maaþlarýnýn toplamýný ülke bazýnda görmek istiyorum. Çýktý listesinde ülkenin ID'si, adý ve maaþ toplamý yer alsýn._SAYFA-155
	--SELECT
	--Country.ID,
	--Country.Name,
	--SUM(Personnel.Salary) AS TotalSalary

	--FROM Personnel
	--INNER JOIN Country ON Country.ID=Personnel.FkCountryID
	--WHERE Personnel.Salary>2000
	--GROUP BY Country.ID,Country.Name;

	--Departmanlara ödenecek toplam maaþlarý departman ID'si ve adý bazýnda listelemenizi istiyorum.Ancak bu listede sadece, toplam ödenecek maaþ tutarý 10000 TL'nin üzerinde olan departmanlar yer alsýn._SAYFA-157
	--NOT:WHERE komutu,sadece hazýr tablolarýn hazýr alanlarýnda bulunan deðerleri filtrelemek için kullanýlýr.Fakat; SUM(Personnel.Salary) alaný hazýr bir alan deðil, bu sorguda hesapanarak üretilen bir stundur.
	--Hesaplanarak üretilen bir stüna koþul koymak istediimizde kullanmamýz gereken  komut WHERE deðil, HAVING komutudur.
	--Diðer bir deyiþle; WHERE komutu hazýr tablo alanlarý üzerinde filtreleme yapmak için kullanýlýrken; HAVING komutu, sorgu içerisinde üretilen stünlar üzerinde filtreleme yapmak için kullanýlýr.
	--HAVING komutu, herzaman GROUP BY'dan sonra yazýlýr.
	--SELECT
	--Department.ID,
	--Department.Name,
	--SUM(Personnel.Salary) AS TotalSalary
	--FROM Department
	--INNER JOIN Personnel
	--ON	Department.ID=Personnel.FkDepartmentID
	--GROUP BY Department.ID,Department.Name
	--HAVING SUM(Personnel.Salary)>5000;

	--Bana web sitemizdeki içeriðe ait açýklamalarý ve Ýngilizce metinleri listeler misiniz?_SAYFA-159
	--1.YOL
	--SELECT
	--WConDefination.Defination,
	--WebContText.Text

	--FROM WebContText
	--INNER JOIN WConDefination
	
	--ON WebContText.FkDefinationID=WConDefination.ID
	--WHERE WebContText.FkCountryID='UK'

	--2.YOL
	--SELECT
	--WConDefination.Defination,
	--WebContText.Text

	--FROM WebContText,WConDefination
	--WHERE WebContText.FkDefinationID=WConDefination.ID AND WebContText.FkCountryID='UK'


	--Bana herbir departmanýn ID'sini,adýný ve o departmana ödenen en yüksek maaþý bir liste halinde getirin. _SAYFA-162

	--SELECT 
	--Department.ID,
	--Department.Name,
	--MAX(Personnel.Salary) AS MaxDeptSalary
	--FROM Department,Personnel
	--WHERE Department.ID=Personnel.FkDepartmentID 
	--GROUP BY Department.ID,Department.Name;

	--Bana her bir müþterinin ID'sini,adýný,soyadýný ve bugüne kadar verdiði sipariþ sayýsýný içeren bir liste gerekiyor.Haydi göreyim sizi!_SAYFA-164

	--SELECT
	--Customer.ID,
	--Customer.Name,
	--Customer.Surname,
	--COUNT(OrderTitle.FkCustomerID) AS TotalOrder
	--FROM Customer,OrderTitle
	--WHERE Customer.ID=OrderTitle.FkCustomerID
	--GROUP BY Customer.ID,Customer.Name,Customer.Surname;

	
--Bana sattýðýmýz ürünlerin ID'lerini,isimlerini ve þimdiye kadar kaç adet sipariþ edilmiþ olduðu bilgisini bir liste haline getirir misiniz?_SAYFA-165

--SELECT
--Product.ID,
--Product.Name,
--SUM(OrderItem.Quantity) AS TotalProduct
--FROM Product,OrderItem
--WHERE Product.ID=OrderItem.FkProductID
--GROUP BY Product.ID,Product.Name;


	
--Web sitemizdeki ankette 'Ürünlerimizden memnun musunuz?' diye bir soru sormuþtuk.Bu soruya; 'Memnun deðilim' (CEVAP_ID:4) VE 'Hiç memnun deðilim' (CEVAP_ID:5) cevaplarýný veren müþterilerimizin ID,ad,soyad ve E-posta adreslerini çýkarýr mýsnýz?_SAYFA-166
--SELECT
--Customer.ID,
--Customer.Name,
--Customer.Surname,
--Customer.Email

--FROM Customer,QuesCustAnswer
--WHERE Customer.ID=QuesCustAnswer.FkCustomerID AND QuesCustAnswer.FkAnswerID IN(4,5)

--Bana sistemdeki her bir ülkenin ID'sini, adýný ve o ülkeden verilmiþ sipariþ sayýsýný içerecek bir liste gerekiyor._SAYFA-169

--SELECT
--  Country.ID,
--  Country.Name AS CountryName,
--  COUNT(OrderTitle.ID) AS TotalOrder

--FROM Country,Customer,OrderTitle
--WHERE
--	Country.ID=Customer.FkCountryID AND
--	Customer.ID=OrderTitle.FkCustomerID

--GROUP BY
--	 Country.ID,
--	 Country.Name




--Web sitemizdeki anketlere ait her bir sorunun ID'sini, soru metnini, potansiyel cevaplarý ve söz konusu cevabýn kaç kez verilmiþ olduðu bilgisini bir arada bulunduran bir liste istiyorum_SAYFA-173

--SELECT
--QueQuestion.ID,
--CAST(QueQuestion.Question AS NVARCHAR) AS Question,
--CAST(QueAnswer.Answer AS NVARCHAR) AS Answer,
--COUNT(QuesCustAnswer.FkAnswerID) AS TotalAnswer

--FROM QueQuestion,QueAnswer,QuesCustAnswer

--WHERE 
--	QueQuestion.ID=QueAnswer.FkQuestionID 
--	AND
--      QueAnswer.ID=QuesCustAnswer.FkAnswerID
	

--GROUP BY
--	QueQuestion.ID,
--	CAST(QueQuestion.Question AS NVARCHAR),
--	CAST(QueAnswer.Answer AS NVARCHAR)




--1 Nisan 2005 tarihinde her bir ürün grubuna ait ürünlerini ortalama fiyatlarý kaç TL imiþ merak ediyorum. Bana bu bilgiyi ürün grubu ID'si ve ismi bazýnda getirin._SAYFA-175

--SELECT
--ProductGroup.ID,
--ProductGroup.Name,

--AVG(ProductPrice.Price)AS AvgPrice
--FROM ProductGroup,Product,ProductPrice
--WHERE ProductGroup.ID=Product.FkGroupID AND 
--	  Product.ID=ProductPrice.FkProductID AND
--	  (ProductPrice.StartDate<='2005-04-01' AND
--	  ProductPrice.EndDate>='2005-04-01')

--GROUP BY ProductGroup.ID,
--ProductGroup.Name;

--Þimdiye kadar teslim edilebilmiþ bütün sipariþ kalemlerine ait sipariþ ve sipariþkalem ID'lerini listeleyin._SAYFA-178

--SELECT 
--OrderTitle.ID AS OrTitleID,
--OrderItem.ID AS OrItemID
--FROM OrderTitle,OrderItem,DeliveryItem
--WHERE OrderTitle.ID=OrderItem.FkOrderID AND
--	  OrderItem.ID IN 
--	  (
--	  SELECT FkDelyItemID FROM DeliveryItem
--	  )
	  	  
--	  GROUP BY OrderTitle.ID,OrderItem.ID ;

--Þimdiye kadar teslim edilmemiþ bütün sipariþ kalemlerine ait sipariþ ve sipariþkalem ID'lerini listeleyin._SAYFA-181
--	  SELECT 
--OrderTitle.ID AS OrTitleID,
--OrderItem.ID AS OrItemID
--FROM OrderTitle,OrderItem,DeliveryItem
--WHERE OrderTitle.ID=OrderItem.FkOrderID AND
--	  OrderItem.ID NOT IN 
--	  (
--	  SELECT FkDelyItemID FROM DeliveryItem
--	  )
	    
--	  GROUP BY OrderTitle.ID,OrderItem.ID ;


--Þimdiye kadar kaç adet ürün siparilmiþ edilmiþ merak ediyorum. Bana bu bilgiyi ürün grubu bazýnda getirbilir misiniz.
--Örneðin; Sarf Malzemeleleri, grubundaki ürünlerden toplam kaç adet, Bilgisayarlar grubundaki ürünlerden toplam kaç adet,
--Kitaplar grubundaki ürünlerden toplam kaç adet sipariþ edilmiþ görmek istiyorum._SAYFA-181

--SELECT
--ProductGroup.ID,
--ProductGroup.Name AS ProductGroup,
--SUM(OrderItem.Quantity) AS TotalOrder
--FROM ProductGroup,Product,OrderItem
--WHERE ProductGroup.ID=Product.FkGroupID AND
--	 Product.ID=OrderItem.FkProductID
--	  GROUP BY ProductGroup.ID,
--ProductGroup.Name;

--Þimdiye kadar açýlmýþ herbir  sipariþin ID'sini ve  kalemlerine ait toplam tutarý listeleyebilir misiniz._SAYFA-186

--SELECT
--OrderTitle.ID AS ID,

--SUM(OrderItem.Quantity*ProductPrice.Price) AS TotalPrice

--FROM OrderTitle,OrderItem,ProductPrice

--WHERE 
--	OrderTitle.ID=OrderItem.FkOrderID AND
--	OrderItem.FkProductID=ProductPrice.FkProductID AND
--	OrderTitle.Date>=ProductPrice.StartDate AND
--	OrderTitle.Date<=ProductPrice.EndDate
--GROUP BY OrderTitle.ID;


--Herbir ürünün ID'sini,adýný ve þimdiye kadar kaç TL'lik sipariþ verildiði bilgisni içeren bir liste hazýrlayýn._SAYFA-189

--SELECT
--Product.ID,
--Product.Name AS ProdName,
--SUM(OrderItem.Quantity*ProductPrice.Price) AS TotalPrice

--FROM OrderTitle,OrderItem,Product,ProductPrice
--WHERE OrderTitle.ID=OrderItem.FkOrderID AND
--	OrderItem.FkProductID=Product.ID AND
--	Product.ID=ProductPrice.FkProductID AND
--	OrderTitle.Date>=ProductPrice.StartDate AND
--	OrderTitle.Date<=ProductPrice.EndDate

--GROUP BY  Product.ID,
--Product.Name;




--2 numaralý anket sorusuna hangi cevabýn kaç kez verildiðine ait sayýyý ülke bazýnda listeleyin. 
--Çýktýda ülkenin adý,cevabýn metni ve cevabýn ülke bazýnda verilme sayýsý bulunsun._SAYFA-192
--SELECT
--CAST(Country.Name AS NVARCHAR) AS CountryName,
--CAST(QueAnswer.Answer AS NVARCHAR) AS Answer,
--COUNT(QuesCustAnswer.ID) AS TotalAnswer

--FROM QueQuestion,QueAnswer,QuesCustAnswer,Customer,Country

--WHERE
--QueQuestion.ID=QueAnswer.FkQuestionID AND
--QueAnswer.ID=QuesCustAnswer.FkAnswerID AND
--QuesCustAnswer.FkCustomerID=Customer.ID AND
--Customer.FkCountryID=Country.ID AND
--QueQuestion.ID=2

--GROUP BY 

--CAST(Country.Name AS NVARCHAR) ,
--CAST(QueAnswer.Answer AS NVARCHAR) ;




--Müþterilerimizin ID'sini,adýný,soyadýný ve bugüne kadar kaç TL'lik sipariþ vermiþ olduðunu hesaplayýn._SAYFA-197

--SELECT
--Customer.ID,
--Customer.Name,
--Customer.Surname,
--SUM(OrderItem.Quantity*ProductPrice.Price) AS  TotalPrice

--FROM OrderTitle,Customer,OrderItem,Product,ProductPrice

--WHERE OrderTitle.FkCustomerID=Customer.ID AND
--	  OrderTitle.ID=OrderItem.FkOrderID AND
--	  OrderItem.FkProductID=Product.ID AND
--	  Product.ID=ProductPrice.FkProductID AND
--	  OrderTitle.Date>=ProductPrice.StartDate AND
--	  OrderTitle.Date<=ProductPrice.EndDate

--GROUP BY Customer.ID,
--		Customer.Name,
--		Customer.Surname;


--Þimdiye kadar her üründen toplam kaç TL'lik teslimat yaptýðýmýzý öðrenmek istiyorum. Ürünlerin ID'lerini adlarýný ve toplam teslimat tutarlarýný içeren bir liste oluþturun._SAYFA-200

--SELECT Product.ID,
--	   Product.Name,
--	   SUM(OrderItem.Quantity*ProductPrice.Price) AS  TotalPrice

--FROM OrderTitle,OrderItem,DeliveryItem,Product,ProductPrice

--WHERE   OrderTitle.ID=OrderItem.FkOrderID AND
--		OrderItem.FkProductID=Product.ID   AND
--		Product.ID=ProductPrice.FkProductID AND
--		OrderTitle.Date>=ProductPrice.StartDate AND
--		OrderTitle.Date<=ProductPrice.EndDate AND
--		OrderItem.ID IN
--		(
--		  SELECT FkOrderItemID FROM DeliveryItem
--		)
--GROUP BY Product.ID,
--	   Product.Name;

--Þimdiye kadar her üründen toplam kaç TL'lik teslimat yaptýðýmýzý öðrenmek istiyorum. Ürün grubu bazýnda ID'lerini adlarýný ve toplam teslimat tutarlarýný içeren bir liste oluþturun._SAYFA-204

--SELECT ProductGroup.ID,
--	   ProductGroup.Name,
--	   SUM(OrderItem.Quantity*ProductPrice.Price) AS  TotalPrice

--FROM ProductGroup,
--	 OrderTitle,
--	 OrderItem,
--	 DeliveryItem,
--	 Product,
--	 ProductPrice

--WHERE   OrderTitle.ID=OrderItem.FkOrderID AND
--		ProductGroup.ID=Product.FkGroupID AND
--		OrderItem.FkProductID=Product.ID   AND
--		Product.ID=ProductPrice.FkProductID AND
--		OrderTitle.Date>=ProductPrice.StartDate AND
--		OrderTitle.Date<=ProductPrice.EndDate AND
--		OrderItem.ID IN
--		(
--		  SELECT FkOrderItemID FROM DeliveryItem
--		)
--GROUP BY ProductGroup.ID,
--	     ProductGroup.Name;


--2005 ciromuz yani 2005 yýlýnda açýlmýþ bütün sipariþlere(sipariþ kalemlerine) ait toplam ürün tutarý kaç TL?_SAYFA-205

--SELECT SUM(OrderItem.Quantity*ProductPrice.Price)

--FROM OrderTitle,
--	 OrderItem,
--	 Product,
--	 ProductPrice

--WHERE OrderTitle.ID=OrderItem.FkProductID AND
--	  OrderItem.FkProductID=Product.ID AND
--	  Product.ID=ProductPrice.FkProductID AND
--	  OrderTitle.Date>='2005-01-01'	AND
--	  OrderTitle.Date<='2005-12-31' AND
--	  OrderTitle.Date>=ProductPrice.StartDate AND
--	  OrderTitle.Date<=ProductPrice.EndDate;


--Bana herbir çalýþanýn ID'sini,adýný,soyadýný ve çalýþtýðý departmanýn ID'sini ve adýný içeren bir liste getirin.Bu listede hiçbir departmana ait olmayan kiþiler de bulunsun?_SAYFA-206
--1.YOL
--SELECT
--	Personnel.ID AS PersID,
--	Personnel.Name AS PersName,
--	Personnel.Surname AS PersSurname,
--	Department.ID AS DeptID,
--	Department.Name AS DeptName

--FROM Personnel,Department

--WHERE Department.ID=Personnel.FkDepartmentID;

------2.YOL
--SELECT
--	Personnel.ID AS PersID,
--	Personnel.Name AS PersName,
--	Personnel.Surname AS PersSurname,
--	Department.ID AS DeptID,
--	Department.Name AS DeptName

--FROM Personnel

--INNER JOIN Department ON Department.ID=Personnel.FkDepartmentID;


--NOT:INNER JOIN sorgularý ; sadece tablolar arasýnda birebir eþleþen verileri döndürür.Oysa patronumuz; listede hiçbir departmana  ait olmayan verileri de görmek istiyor.
--SQL dilinde, bu gibi duurmlarda OUTER JOIN adý verilen bir komut vardýr.Mantýk olarak INNER JOIN ile birebir aynýdýr.Birleþtirilen tablolarda baðlantýsý olmayan nesnelerin de listelenmesini saðlar.


--SELECT
--	 Department.ID AS DeptID,
--	 Department.Name AS DeptName,
--	 Personnel.ID AS PersID,
--	 Personnel.Name AS PersName,
--	 Personnel.Surname AS PersSurname
--FROM Personnel

--LEFT OUTER JOIN Department ON Department.ID=Personnel.FkDepartmentID;

--NOT:LEFT OUTER JOIN komut dizisiyle solundaki Personnel tablosunda bulunup, saðdaki Department tablosunda karþýlýðý olmayan kayýtlarý da listele demiþ olduk.


--SELECT
--	 Department.ID AS DeptID,
--	 Department.Name AS DeptName,
--	 Personnel.ID AS PersID,
--	 Personnel.Name AS PersName,
--	 Personnel.Surname AS PersSurname
--FROM Department

--RIGHT OUTER JOIN Personnel ON Department.ID=Personnel.FkDepartmentID;

--NOT:RIGHT OUTER JOIN komut dizisiyle saðdaki  Department tablosunda bulunup, soldaki Personnel  tablosunda karþýlýðý olmayan kayýtlarý da listele demiþ olduk.Bu sorguda FROM'dan sonra Department tablosu geldiðine dikkat edelim.
--NOT:RIGHT OUTER JOIN ile LEFTT OUTER JOIN arasýnda, kullaným anlamýnda büyük bir fark yoktur.FROM'dan sonra HANGÝ TABLOYU SAÐA YAZDIÐIMIZA DÝKKAT edelim yeter.


--Bana herbir müþterinin ülkesinin adýný,kendi adýný ve soyadýný içeren bir liste istiyorum.Bu listede hiçbir ülkeye baðlý olmayan müþteriler de bulunsun. _SAYFA-210
--1.YOL:LEFT OUTER JOIN KULLANIMI
--SELECT
--	    Country.Name AS Nation,
--		Customer.Name,
--		Customer.Surname

--FROM Customer
--LEFT OUTER JOIN Country ON Country.ID=Customer.FkCountryID

--ORDER BY  Country.Name,
--		Customer.Name,
--		Customer.Surname

----2.YOL:RIGHT OUTER JOIN KULLANIMI
--SELECT
--	    Country.Name AS Nation,
--		Customer.Name,
--		Customer.Surname

--FROM Country
--RIGHT OUTER JOIN Customer ON Country.ID=Customer.FkCountryID

--ORDER BY  Country.Name,
--		Customer.Name,
--		Customer.Surname

--Bana herbir personelin ülkesinin adýný,kendi adýný ve soyadýný içeren bir liste istiyorum.Bu listede hiçbir ülkeye baðlý olmayan müþteriler de bulunsun. _SAYFA-210

--1.YOL:LEFT OUTER JOIN KULLANIMI
--SELECT
--	    Country.Name AS Nation,
--		Personnel.Name,
--		Personnel.Surname

--FROM Personnel

--LEFT OUTER JOIN Country ON Country.ID=Personnel.FkCountryID

--ORDER BY  Country.Name,
--		Personnel.Name,
--		Personnel.Surname

----2.YOL:RIGHT OUTER JOIN KULLANIMI
--SELECT
--	    Country.Name AS Nation,
--		Personnel.Name,
--		Personnel.Surname

--FROM Country
--RIGHT OUTER JOIN Personnel ON Country.ID=Personnel.FkCountryID

--ORDER BY  Country.Name,
--		Personnel.Name,
--		Personnel.Surname


--TABLO MODÝFÝKASYON ÖRNEKLERÝ_SAYFA-211

--1.Veritabanýndan var olan bir tabloyu silmek için DROP TABLE komutu kullanýlýr.
--Örneðin X tablosunu silmek istiyorsak;
--DROP TABLE X; þeklinde yazmamýz yeterli olacaktýr.

--DROP TABLE X

--2.Veritabanýnda olmayan bir tabloyu eklemek  için CREATE TABLE komutu kullanýlýr.
--Örneðin News tablosunu eklemek istiyorsak;
   --a)CREATE TABLE komutundan sonra oluþturmak istediðimiz tablonun ismini yazýyoruz.
   --CREATE TABLE News gibi.
   --b)Ardýndan; parantez içinde, tabloda yer alacak herbir alanýn adýný ve veri tipini tanýmlýyoruz.
   --c)ID alanýný oluþtruduktan sonra NUMBER ifadesinden sonra PRIMARY KEY ifadesini de ekleriz.
   --d)Metin tipindeki alanlarý tanýmladýktan sonra parantez içinde alan uzunluðunu da tanýmlamak gerekir(CHAR(50) gibi).
 --   CREATE TABLE News
	--(
	--ID INT PRIMARY KEY,
	--Date DATE,
	--Title CHAR(50),
	--Text nvarchar(100),
	--Image nvarchar(50)
	--
--);

--3.Bir tabloya yeni bir alan eklemek için 2 yöntem kullanýlýr.
--	a)Var olan tabloyu silip; yerine yeni alaný da kapsayacak ayný tabloyu yeniden oluþturmak.Ancak bu pek kullanýþlý deðildir.Örneðin News tablosuna Summary alanýný eklemek istiyoruz.
--	DROP TABLE News;
--	CREATE TABLE News
--	(
--	ID INT PRIMARY KEY,
--	Date DATE,
--	Title CHAR(50),
--	Text NVARCHAR(100),
--	Image NVARCHAR(50),
--	Summary NVARCHAR(150)
	
--);

--	b)Oluþturmak istediðimiz alaný ALTER komutu kullanarak tabloya eklemek.Örneðin News tablosuna Note alanýný eklemek istiyoruz.

--	ALTER TABLE News ADD Note NVARCHAR(50);

--4.Diyelim ki Summary 150 karakterlik alan özetleri girmek için yetersiz.Bu alanýn uzunluðunu  250 karaktere çýkarýnýz.

--ALTER TABLE News ALTER COLUMN Summary NVARCHAR(250)

--5.Diyelim ki Summary 150 karakterlik alan özetleri girmek için fazla.Bu alanýn uzunluðunu  100 karaktere indiriniz.

--ALTER TABLE News ALTER COLUMN Summary NVARCHAR(100)

--6.Diyelim ki Summary alanýn tipini int yapmak istiyoruz.Bunu nasýl yaparýz?

--ALTER TABLE News ALTER COLUMN Summary int


--7.Diyelim ki tablodan Note alanýný silmek istiyoruz.Bunu nasýl yaparýz?

--ALTER TABLE News DROP COLUMN Note;


--VERÝ MODÝFÝKASYON ÖRNEKLERÝ_SAYFA-215

--1.INSERT INTO

--1.Veritabanýmýza yeni web sitemizin açýlmýþ olduðuna dair bir haber ekler misiniz?_SAYFA-215

--INSERT INTO News
--(
--	Date,
--	Title,
--	Text,
--	Summary
--)

--VALUES
--(
--	'2022-03-13',
--	'Web Sitemiz Açýldý',
--	'Yeni web sitemiz sonunda açýldý.Ziyaretiniz için teþekkür ederiz',
--	'Yeni web sitemiz açýldý.'

--);


--2.Abdulvahap SELÇUK adýnda birini iþe aldým.Bu kiþiye ait kaydý veritabanýna yapýn._SAYFA-215


--INSERT INTO Personnel

--	(
--      FkDepartmentID,
--      FkCountryID,
--      Name,
--      Surname,
--      Email,
--      BirthDate,
--      Salary
--	  )

--VALUES
--	(
--	4,
--	'TR',
--	'Abdulvahap',
--	'SELÇUK',
--	'abdulvahapselcuk@gmail.com',
--	'2002-05-27',
--	30000
--	)

--2.UPDATE

--1. 59 ID'li personeli Almanya'ya gönderip, maaþýna 1000 TL zam yaptým.Veri tabanýnda gerekli modifikasyonu yapýn._SAYFA-217

--UPDATE Personnel
--SET
--	Salary=Salary+1000,
--	FkCountryID='DE'
--WHERE ID=59;


--3.DELETE

--1. 59 ID'li personeli mesai saatlerinde kitap yazarken yakaladým.Bu yüzden, kendisini iþten çýkarýyorum.Veri tabanýndaki  kaydýný silin._SAYFA-218

--DELETE FROM  Personnel WHERE ID=59;

