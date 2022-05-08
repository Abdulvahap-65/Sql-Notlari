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

--1-Bir sorgu i�erisinde,alanlardaki de�erleri matematik i�lemlerine tabi tutabilir ve i�lem sonu�lar�n� ayr� bir st�n halinde g�r�nt�leyebiliriz.
--2-Tarih alanlar� matematik i�lemlerine tabi tutulabilir.(Veritaban� Mant��� Sayfa:113)

--�RNEK KOD:
--SELECT ID,Name,Surname, DATEDIFF(day, BirthDate,'1990/12/12') AS DateDiff from  Personnel;

--Select DATEDIFF(day, BirthDate, convert(date, '1990-12-12', 120)) AS DateDiff from  Personnel;

--Her departmanda toplam ka� ki�i �al���yor?-Sayfa 115
--�RNEK KOD:
--SELECT FkDepartmentID, COUNT(*) AS Total 
--FROM Personnel

--GROUP BY FkDepartmentID;

--�irketimizde �al��anlar�n ka�� Alman,ka�� T�rk, ka�� �ngiliz?

--SELECT FkCountryID, COUNT(*) AS Total
--FROM Personnel
--GROUP BY FkCountryID;
--�n�m�zdeki ay �al��anlara toplam ka� tl maa� vermem gerekir?_SAYFA-117
--SELECT SUM(Salary) AS Total
--FROM Personnel
--�smi Mehmet olan elemanlar toplam ka� TL maa� al�yor?_SAYFA-118
  --SELECT SUM(Salary) AS Total
  --FROM Personnel
  --WHERE Name='Mehmet';
 
 --IT departman�na bu ay ka� TL maa� �demesi yap�lacak?_SAYFA-119
 --1.Ad�m
 --SELECT ID
 --FROM Department
 --WHERE Name='IT'
  --2.Ad�m
 --SELECT SUM(Salary) AS Total
 --FROM Personnel
 --WHERE FkDepartmentID=4;

  --Herbir departmana ayda  ka� TL maa� �demesi yap�lacak?_SAYFA-119
--SELECT FkDepartmentID,SUM(Salary) AS Total
--FROM Personnel
--GROUP BY FkDepartmentID;

--  --Herbir departmana ortalama ayda  ka� TL maa� �demesi yap�l�yor?_SAYFA-120
--SELECT FkDepartmentID,AVG(Salary) AS Average
--FROM Personnel
--GROUP BY FkDepartmentID

--  --Herbir departmana ortalama ayda  ka� TL maa� �demesi yap�ld���n� yuvarlatarak hesapla?_SAYFA-121
--SELECT FkDepartmentID,ROUND(AVG(Salary),0) AS Average
--FROM Personnel
--GROUP BY FkDepartmentID


--�irkette en fazla maa�� alan ka� TL al�yor?
--SELECT MAX(Salary) AS MaxSalary
--FROM Personnel;

--�irkette en az maa�� alan ka� TL al�yor?

--SELECT MIN(Salary) AS MinSalary
--FROM Personnel;

--�irkette en az maa�� alan ile en �ok maa�� alan aras�nda ka� TL fark var?
--SELECT MAX(Salary)- MIN(Salary) AS Differance
--FROM Personnel;

----�irketimize ilk sipari�i veren m��terimizin ID'sini bulur musunuz?

--SELECT TOP 1 FkCustomerID AS Customer FROM OrderTitle;

----�irketimize ilk sipari�i veren m��terimizin �zl�k verilerini alabilir miyiz?

--SELECT*FROM Customer WHERE ID= (SELECT TOP 1 FkCustomerID AS Customer FROM OrderTitle);

----�irketimize son sipari�i veren m��terimizin �zl�k verilerini alabilir miyiz?_SAYFA-127

--SELECT*FROM Customer WHERE ID=(SELECT TOP 1 FkCustomerID AS Customer FROM OrderTitle ORDER BY ID DESC);

----�irketimizin en y�ksek maa� alan personelin �zl�k verilerini alabilir miyiz?_SAYFA-128
--1.Ad�m:Personnel tablosunda Salary alan�nda de�eri en y�ksek x'i  tespit et.
--SELECT MAX(Salary) AS Maximum FROM Personnel;//Bu sonu� x gibi bir de�erdir.

--2.Ad�m:Personnel tablosunda Salary alan�nda x de�erini bar�nd�ran ki�iyi tespit et.
--SELECT*FROM Personnel 
--WHERE Salary=x;
--3.Ad�m:En sade hali;
--SELECT*FROM Personnel 
--WHERE Salary=(SELECT MAX(Salary)  FROM Personnel);

----�imdiye kadar en az bir sipari� vermi� olan m��terilerin ID'lerinin listesini istiyorum?_SAYFA-129
--SELECT FkCustomerID
--FROM OrderTitle;//Bu sorguya g�re baz� m��terilerin  ID'leri birden fazla listelenmi�.Bunun sebebi, baz� m��terilerin birden fazla kez sipari� vermi� olmas�d�r.��nk� her m��teri bir sipari� verdi�inde,
--OrderTitle tablosuna yeni bir kay�t eklenir.Dolays�yla m��teri ka� defa sipari� verdiyse sorgu sonucunda o kadar listelenecektir.
--Peki bu m��teri birden fazla sipari� vermi� olsa bile sadece bir kez  nas�l listeleyebiliriz?-_SAYFA-130
--SELECT DISTINCT FkCustomerID FROM OrderTitle;//DISTINCT birden fazla listelenen de�erleri sadece bir kez gelmesini sa�lar.


----�imdiye kadar en az bir sipari� vermi� olan m��terilerin �zl�k bilgilerini istiyorum?_SAYFA-130
--1.YOL
--1.Ad�m:OrderTitle tablosundan �imdiye kadar sipari� vermi� b�t�n m��terilerin ID'LER�N� tespit ederiz.
--SELECT DISTINCT FkCustomerID FROM OrderTitle
--2.Ad�m:Tespit etti�imiz ID'ler ile MUSTER� tablosuna giderek bu ID'LERE ait kay�tlar� listeleyece�iz.

--SELECT*FROM Customer WHERE ID IN(SELECT DISTINCT FkCustomerID FROM OrderTitle)

--2.YOL-->IN yerine EXISTS komutu kullanmak
	--SELECT*FROM Customer
	--WHERE EXISTS(SELECT*FROM OrderTitle WHERE FkCustomerID=Customer.ID);

	----�imdiye kadar hi� bir sipari� vermemi� olan m��terilerin �zl�k bilgilerini istiyorum?_SAYFA-133
	--SELECT*FROM Customer
	--WHERE NOT EXISTS(SELECT*FROM OrderTitle
	--WHERE FkCustomerID=Customer.ID);

	
	----�irketimizdeki b�t�n personelin ve �irketimizi b�t�n m��terilerin ad,soyad,do�um ve email  bilgilerini istiyorum?_SAYFA-136
	--SELECT Name,Surname,BirthDate, Email 
	--FROM Personnel
	--UNION
	--SELECT Name,Surname,BirthDate,Email 
	--FROM Customer

	--NOT:UNION komutu farkl� tablolar�n benzer alanlar�nda bulunan verileri birle�tirerek bir arada listelememizi sa�lar.Her tablo i�in listelenmesini istedi�imiz alanlar e�le�me�se hata al�r�z.

	--Yukar�daki sorguda kimin personel, kimin m��teri oldu�unu anlayam�yorum.Ki�i personel ise yan�na 'Bizim personel'; m��teri ise yan�na 'Bizim M��teri' yazs�n._SAYFA-139
	--SELECT 'Bizim personel' AS Location, Name,Surname,BirthDate, Email 
	--FROM Personnel
	--UNION
	--SELECT 'Bizim m��teri' AS Location,Name,Surname,BirthDate,Email 
	--FROM Customer

	--Bana her bir personelin ID'sini, ad�n� ve soyad�n�; bunun yan� s�ra �al��t���  departman�n ID'sini ve ad�n� bir arada listeleyip getirin--_SAYFA-140
	--NOT: Farkl� tablolar�n benzer alanlar�nda bulunan verileri birle�tirerek bir arada listelemek i�in UNION komutu kullan�rken;farkl� alanlar�nda bulunan verileri birle�tirerek bir arada listelemek i�in ise 'INNER JOIN' komutu kullan�l�r.Syntax'�  FROM TabloAd�1 INNER JOIN TabloAd�2 �eklindedir.
	--NOT: Birden fazla tablodan veri �ekmek durumunda kald���m�z durumlarda; alan isimlerinin birbirilerine kar��mamas� ad�na, her bir alan� TABLO.ALAN format�nda ifade etmek lehimize olur.
	--INNER JOIN: Hangi iki tablo aras�nda ba�lant� yap�laca��n� belirtmek i�in kullan�l�r.Ba�lant� iki y�nl�d�r( Ba�lant� Personnel ve Department tablolar� aras�nda �eklinde olabilirdi.).�rnekte Personnel ve Department tablolar� aras�nda ba�lant� kurmak i�in kullan�lm��t�r.
	--ON:�ki tablo aras�ndaki ba�lant�n�n hangi alanlar� e�le�tirerek sa�lanabilece�ini ifade eder.Bu �rnekte  Personnel tablosundaki FkDepartmentID alan� ile Department tablosundaki ID alan�  e�le�tirilerek sa�lanm��t�r.

	--SELECT Personnel.ID,Personnel.Name,Personnel.Surname,Personnel.FkDepartmentID,Department.Name AS DeptName FROM Department INNER JOIN Personnel ON  Personnel.FkDepartmentID=Department.ID;
	--SELECT Personnel.ID,Personnel.Name,Personnel.Surname,Personnel.FkDepartmentID,Department.Name AS DeptName FROM Personnel INNER JOIN Department ON  Personnel.FkDepartmentID=Department.ID;


	--Herbir personelin ad�n�,soyad�n� ve �lkesinin ismini listeleyin.Liste; �lke ad�, personel ad� ve personel soyad�na g�re s�ralanm�� olsun.
	--SELECT 
	--Personnel.Name,
	--Personnel.Surname,
	--Country.Name AS CountryName
	--FROM Personnel INNER JOIN Country ON Personnel.FkCountryID=Country.ID 
	--ORDER BY Country.Name,Personnel.Name,
	--Personnel.Surname;

	--Bana �yle bir liste haz�rlay�n ki, i�inde her bir �lkenin ID'si, ismi ve o �lkeden gelen personelin say�s� olsun._SAYFA-148
	--SELECT
	--Country.ID,
	--Country.Name,
	--COUNT(Personnel.ID) AS TotPersonnel
	--FROM Country
	--INNER JOIN Personnel ON Country.ID=Personnel.FkCountryID
	--GROUP BY Country.ID,Country.Name;

	--L�stedeki �lkeler n�fus say�s�na g�re b�y�kten k����e do�ru s�ralanm�� olsun._SAYFA-151
	--SELECT
	--Country.ID,
	--Country.Name,
	--COUNT(Personnel.ID) AS TotPersonnel
	--FROM Country
	--INNER JOIN Personnel ON Country.ID=Personnel.FkCountryID
	--GROUP BY Country.ID,Country.Name 
	--ORDER BY COUNT(Personnel.ID) DESC;


	--Her bir departman�n ID'sini, ad�n� ve o departmana �denen toplam maa�� artan s�rada tek bir liste i�inde g�rmek istiyorum._SAYFA-151 ve 153

	--SELECT
	--Department.ID,
	--Department.Name,
	--SUM(Personnel.Salary) AS TotSalary
	--FROM Department 
	--INNER JOIN Personnel 
	--ON Department.ID=Personnel.FkDepartmentID
	--GROUP BY Department.ID,Department.Name
	--ORDER BY SUM(Personnel.Salary) ASC;

	--Personele �denenen maa�lar� �lke baz�nda listelemenizi istiyorum. ��kt�lar, �lke ismine g�re s�ralanm�� olsun._SAYFA-154
	--SELECT 
	--Country.ID,
	--Country.Name,
	--SUM(Personnel.Salary) AS TotSalary
	--FROM Personnel 
	--INNER JOIN Country 
	--ON Country.ID=Personnel.FkCountryID
	--GROUP BY Country.ID,Country.Name
	--ORDER BY Country.Name;
	
	--Ayl�k maa�� 2000 TL'den fazla ki�ilerin maa�lar�n�n toplam�n� �lke baz�nda g�rmek istiyorum. ��kt� listesinde �lkenin ID'si, ad� ve maa� toplam� yer als�n._SAYFA-155
	--SELECT
	--Country.ID,
	--Country.Name,
	--SUM(Personnel.Salary) AS TotalSalary

	--FROM Personnel
	--INNER JOIN Country ON Country.ID=Personnel.FkCountryID
	--WHERE Personnel.Salary>2000
	--GROUP BY Country.ID,Country.Name;

	--Departmanlara �denecek toplam maa�lar� departman ID'si ve ad� baz�nda listelemenizi istiyorum.Ancak bu listede sadece, toplam �denecek maa� tutar� 10000 TL'nin �zerinde olan departmanlar yer als�n._SAYFA-157
	--NOT:WHERE komutu,sadece haz�r tablolar�n haz�r alanlar�nda bulunan de�erleri filtrelemek i�in kullan�l�r.Fakat; SUM(Personnel.Salary) alan� haz�r bir alan de�il, bu sorguda hesapanarak �retilen bir stundur.
	--Hesaplanarak �retilen bir st�na ko�ul koymak istediimizde kullanmam�z gereken  komut WHERE de�il, HAVING komutudur.
	--Di�er bir deyi�le; WHERE komutu haz�r tablo alanlar� �zerinde filtreleme yapmak i�in kullan�l�rken; HAVING komutu, sorgu i�erisinde �retilen st�nlar �zerinde filtreleme yapmak i�in kullan�l�r.
	--HAVING komutu, herzaman GROUP BY'dan sonra yaz�l�r.
	--SELECT
	--Department.ID,
	--Department.Name,
	--SUM(Personnel.Salary) AS TotalSalary
	--FROM Department
	--INNER JOIN Personnel
	--ON	Department.ID=Personnel.FkDepartmentID
	--GROUP BY Department.ID,Department.Name
	--HAVING SUM(Personnel.Salary)>5000;

	--Bana web sitemizdeki i�eri�e ait a��klamalar� ve �ngilizce metinleri listeler misiniz?_SAYFA-159
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


	--Bana herbir departman�n ID'sini,ad�n� ve o departmana �denen en y�ksek maa�� bir liste halinde getirin. _SAYFA-162

	--SELECT 
	--Department.ID,
	--Department.Name,
	--MAX(Personnel.Salary) AS MaxDeptSalary
	--FROM Department,Personnel
	--WHERE Department.ID=Personnel.FkDepartmentID 
	--GROUP BY Department.ID,Department.Name;

	--Bana her bir m��terinin ID'sini,ad�n�,soyad�n� ve bug�ne kadar verdi�i sipari� say�s�n� i�eren bir liste gerekiyor.Haydi g�reyim sizi!_SAYFA-164

	--SELECT
	--Customer.ID,
	--Customer.Name,
	--Customer.Surname,
	--COUNT(OrderTitle.FkCustomerID) AS TotalOrder
	--FROM Customer,OrderTitle
	--WHERE Customer.ID=OrderTitle.FkCustomerID
	--GROUP BY Customer.ID,Customer.Name,Customer.Surname;

	
--Bana satt���m�z �r�nlerin ID'lerini,isimlerini ve �imdiye kadar ka� adet sipari� edilmi� oldu�u bilgisini bir liste haline getirir misiniz?_SAYFA-165

--SELECT
--Product.ID,
--Product.Name,
--SUM(OrderItem.Quantity) AS TotalProduct
--FROM Product,OrderItem
--WHERE Product.ID=OrderItem.FkProductID
--GROUP BY Product.ID,Product.Name;


	
--Web sitemizdeki ankette '�r�nlerimizden memnun musunuz?' diye bir soru sormu�tuk.Bu soruya; 'Memnun de�ilim' (CEVAP_ID:4) VE 'Hi� memnun de�ilim' (CEVAP_ID:5) cevaplar�n� veren m��terilerimizin ID,ad,soyad ve E-posta adreslerini ��kar�r m�sn�z?_SAYFA-166
--SELECT
--Customer.ID,
--Customer.Name,
--Customer.Surname,
--Customer.Email

--FROM Customer,QuesCustAnswer
--WHERE Customer.ID=QuesCustAnswer.FkCustomerID AND QuesCustAnswer.FkAnswerID IN(4,5)

--Bana sistemdeki her bir �lkenin ID'sini, ad�n� ve o �lkeden verilmi� sipari� say�s�n� i�erecek bir liste gerekiyor._SAYFA-169

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




--Web sitemizdeki anketlere ait her bir sorunun ID'sini, soru metnini, potansiyel cevaplar� ve s�z konusu cevab�n ka� kez verilmi� oldu�u bilgisini bir arada bulunduran bir liste istiyorum_SAYFA-173

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




--1 Nisan 2005 tarihinde her bir �r�n grubuna ait �r�nlerini ortalama fiyatlar� ka� TL imi� merak ediyorum. Bana bu bilgiyi �r�n grubu ID'si ve ismi baz�nda getirin._SAYFA-175

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

--�imdiye kadar teslim edilebilmi� b�t�n sipari� kalemlerine ait sipari� ve sipari�kalem ID'lerini listeleyin._SAYFA-178

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

--�imdiye kadar teslim edilmemi� b�t�n sipari� kalemlerine ait sipari� ve sipari�kalem ID'lerini listeleyin._SAYFA-181
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


--�imdiye kadar ka� adet �r�n siparilmi� edilmi� merak ediyorum. Bana bu bilgiyi �r�n grubu baz�nda getirbilir misiniz.
--�rne�in; Sarf Malzemeleleri, grubundaki �r�nlerden toplam ka� adet, Bilgisayarlar grubundaki �r�nlerden toplam ka� adet,
--Kitaplar grubundaki �r�nlerden toplam ka� adet sipari� edilmi� g�rmek istiyorum._SAYFA-181

--SELECT
--ProductGroup.ID,
--ProductGroup.Name AS ProductGroup,
--SUM(OrderItem.Quantity) AS TotalOrder
--FROM ProductGroup,Product,OrderItem
--WHERE ProductGroup.ID=Product.FkGroupID AND
--	 Product.ID=OrderItem.FkProductID
--	  GROUP BY ProductGroup.ID,
--ProductGroup.Name;

--�imdiye kadar a��lm�� herbir  sipari�in ID'sini ve  kalemlerine ait toplam tutar� listeleyebilir misiniz._SAYFA-186

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


--Herbir �r�n�n ID'sini,ad�n� ve �imdiye kadar ka� TL'lik sipari� verildi�i bilgisni i�eren bir liste haz�rlay�n._SAYFA-189

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




--2 numaral� anket sorusuna hangi cevab�n ka� kez verildi�ine ait say�y� �lke baz�nda listeleyin. 
--��kt�da �lkenin ad�,cevab�n metni ve cevab�n �lke baz�nda verilme say�s� bulunsun._SAYFA-192
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




--M��terilerimizin ID'sini,ad�n�,soyad�n� ve bug�ne kadar ka� TL'lik sipari� vermi� oldu�unu hesaplay�n._SAYFA-197

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


--�imdiye kadar her �r�nden toplam ka� TL'lik teslimat yapt���m�z� ��renmek istiyorum. �r�nlerin ID'lerini adlar�n� ve toplam teslimat tutarlar�n� i�eren bir liste olu�turun._SAYFA-200

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

--�imdiye kadar her �r�nden toplam ka� TL'lik teslimat yapt���m�z� ��renmek istiyorum. �r�n grubu baz�nda ID'lerini adlar�n� ve toplam teslimat tutarlar�n� i�eren bir liste olu�turun._SAYFA-204

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


--2005 ciromuz yani 2005 y�l�nda a��lm�� b�t�n sipari�lere(sipari� kalemlerine) ait toplam �r�n tutar� ka� TL?_SAYFA-205

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


--Bana herbir �al��an�n ID'sini,ad�n�,soyad�n� ve �al��t��� departman�n ID'sini ve ad�n� i�eren bir liste getirin.Bu listede hi�bir departmana ait olmayan ki�iler de bulunsun?_SAYFA-206
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


--NOT:INNER JOIN sorgular� ; sadece tablolar aras�nda birebir e�le�en verileri d�nd�r�r.Oysa patronumuz; listede hi�bir departmana  ait olmayan verileri de g�rmek istiyor.
--SQL dilinde, bu gibi duurmlarda OUTER JOIN ad� verilen bir komut vard�r.Mant�k olarak INNER JOIN ile birebir ayn�d�r.Birle�tirilen tablolarda ba�lant�s� olmayan nesnelerin de listelenmesini sa�lar.


--SELECT
--	 Department.ID AS DeptID,
--	 Department.Name AS DeptName,
--	 Personnel.ID AS PersID,
--	 Personnel.Name AS PersName,
--	 Personnel.Surname AS PersSurname
--FROM Personnel

--LEFT OUTER JOIN Department ON Department.ID=Personnel.FkDepartmentID;

--NOT:LEFT OUTER JOIN komut dizisiyle solundaki Personnel tablosunda bulunup, sa�daki Department tablosunda kar��l��� olmayan kay�tlar� da listele demi� olduk.


--SELECT
--	 Department.ID AS DeptID,
--	 Department.Name AS DeptName,
--	 Personnel.ID AS PersID,
--	 Personnel.Name AS PersName,
--	 Personnel.Surname AS PersSurname
--FROM Department

--RIGHT OUTER JOIN Personnel ON Department.ID=Personnel.FkDepartmentID;

--NOT:RIGHT OUTER JOIN komut dizisiyle sa�daki  Department tablosunda bulunup, soldaki Personnel  tablosunda kar��l��� olmayan kay�tlar� da listele demi� olduk.Bu sorguda FROM'dan sonra Department tablosu geldi�ine dikkat edelim.
--NOT:RIGHT OUTER JOIN ile LEFTT OUTER JOIN aras�nda, kullan�m anlam�nda b�y�k bir fark yoktur.FROM'dan sonra HANG� TABLOYU SA�A YAZDI�IMIZA D�KKAT edelim yeter.


--Bana herbir m��terinin �lkesinin ad�n�,kendi ad�n� ve soyad�n� i�eren bir liste istiyorum.Bu listede hi�bir �lkeye ba�l� olmayan m��teriler de bulunsun. _SAYFA-210
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

--Bana herbir personelin �lkesinin ad�n�,kendi ad�n� ve soyad�n� i�eren bir liste istiyorum.Bu listede hi�bir �lkeye ba�l� olmayan m��teriler de bulunsun. _SAYFA-210

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


--TABLO MOD�F�KASYON �RNEKLER�_SAYFA-211

--1.Veritaban�ndan var olan bir tabloyu silmek i�in DROP TABLE komutu kullan�l�r.
--�rne�in X tablosunu silmek istiyorsak;
--DROP TABLE X; �eklinde yazmam�z yeterli olacakt�r.

--DROP TABLE X

--2.Veritaban�nda olmayan bir tabloyu eklemek  i�in CREATE TABLE komutu kullan�l�r.
--�rne�in News tablosunu eklemek istiyorsak;
   --a)CREATE TABLE komutundan sonra olu�turmak istedi�imiz tablonun ismini yaz�yoruz.
   --CREATE TABLE News gibi.
   --b)Ard�ndan; parantez i�inde, tabloda yer alacak herbir alan�n ad�n� ve veri tipini tan�ml�yoruz.
   --c)ID alan�n� olu�truduktan sonra NUMBER ifadesinden sonra PRIMARY KEY ifadesini de ekleriz.
   --d)Metin tipindeki alanlar� tan�mlad�ktan sonra parantez i�inde alan uzunlu�unu da tan�mlamak gerekir(CHAR(50) gibi).
 --   CREATE TABLE News
	--(
	--ID INT PRIMARY KEY,
	--Date DATE,
	--Title CHAR(50),
	--Text nvarchar(100),
	--Image nvarchar(50)
	--
--);

--3.Bir tabloya yeni bir alan eklemek i�in 2 y�ntem kullan�l�r.
--	a)Var olan tabloyu silip; yerine yeni alan� da kapsayacak ayn� tabloyu yeniden olu�turmak.Ancak bu pek kullan��l� de�ildir.�rne�in News tablosuna Summary alan�n� eklemek istiyoruz.
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

--	b)Olu�turmak istedi�imiz alan� ALTER komutu kullanarak tabloya eklemek.�rne�in News tablosuna Note alan�n� eklemek istiyoruz.

--	ALTER TABLE News ADD Note NVARCHAR(50);

--4.Diyelim ki Summary 150 karakterlik alan �zetleri girmek i�in yetersiz.Bu alan�n uzunlu�unu  250 karaktere ��kar�n�z.

--ALTER TABLE News ALTER COLUMN Summary NVARCHAR(250)

--5.Diyelim ki Summary 150 karakterlik alan �zetleri girmek i�in fazla.Bu alan�n uzunlu�unu  100 karaktere indiriniz.

--ALTER TABLE News ALTER COLUMN Summary NVARCHAR(100)

--6.Diyelim ki Summary alan�n tipini int yapmak istiyoruz.Bunu nas�l yapar�z?

--ALTER TABLE News ALTER COLUMN Summary int


--7.Diyelim ki tablodan Note alan�n� silmek istiyoruz.Bunu nas�l yapar�z?

--ALTER TABLE News DROP COLUMN Note;


--VER� MOD�F�KASYON �RNEKLER�_SAYFA-215

--1.INSERT INTO

--1.Veritaban�m�za yeni web sitemizin a��lm�� oldu�una dair bir haber ekler misiniz?_SAYFA-215

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
--	'Web Sitemiz A��ld�',
--	'Yeni web sitemiz sonunda a��ld�.Ziyaretiniz i�in te�ekk�r ederiz',
--	'Yeni web sitemiz a��ld�.'

--);


--2.Abdulvahap SEL�UK ad�nda birini i�e ald�m.Bu ki�iye ait kayd� veritaban�na yap�n._SAYFA-215


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
--	'SEL�UK',
--	'abdulvahapselcuk@gmail.com',
--	'2002-05-27',
--	30000
--	)

--2.UPDATE

--1. 59 ID'li personeli Almanya'ya g�nderip, maa��na 1000 TL zam yapt�m.Veri taban�nda gerekli modifikasyonu yap�n._SAYFA-217

--UPDATE Personnel
--SET
--	Salary=Salary+1000,
--	FkCountryID='DE'
--WHERE ID=59;


--3.DELETE

--1. 59 ID'li personeli mesai saatlerinde kitap yazarken yakalad�m.Bu y�zden, kendisini i�ten ��kar�yorum.Veri taban�ndaki  kayd�n� silin._SAYFA-218

--DELETE FROM  Personnel WHERE ID=59;

