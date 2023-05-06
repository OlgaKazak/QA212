/*Create database [Hospital_3];
go

Use [Hospital_3];
go

Create table [Departments] /*���������*/
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(100) not null unique check ([Name] <> N''), /*�������� ���������*/
	[Building] nvarchar(100) not null unique check ([Building] <> N'') /*�������� ���������*/
);
go

Insert into [Departments] (Name, Building)
VALUES 
('����������', '�22'),
('�������������������', '�23'),
('�������������', '�24'),
('������������������', '�21'),
('����������������', '�25'),
('���������������', '�32'),
('���������������', '�26'),
('���������������', '�12'),
('�������������������', '�13'),
('��������������', '�14')

Create table [Inspections] /*������������*/
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(100) not null unique check ([Name] <> N''), /*�������� ������������*/
	[DaysOfWeeks] nvarchar(100) not null check ([DaysOfWeeks] <> N''), /*���� ������������*/
	[DepartmentId] int not null FOREIGN KEY REFERENCES Departments(Id), /*������������� ���������*/
	[StartDate] date not null,/*���� ������ ������������*/
	[EndDate] date not null, check(EndDate>StartDate) /*���� ���������� ������������*/
);
go

Insert into [Inspections] (Name, DaysOfWeeks, DepartmentId, StartDate, EndDate)     
VALUES 
('�������������� ������������', 'Monday', 1, '2023-01-01', '2023-01-07'),
('������������������� ������������', 'Tuesday', 2, '2023-01-01', '2023-02-01'),
('������������� ������������', 'Wednesday', 3, '2023-03-01', '2023-04-01'),
('������������������ ������������', 'Thursday', 4, '2023-01-01', '2023-07-01'),
('���������������� ������������', 'Friday', 5, '2023-01-01', '2023-07-01'),
('��������������� ������������', 'Saturday', 6, '2023-02-01', '2023-05-01'),
('��������������� ������������', 'Sunday', 7, '2023-01-01', '2023-04-09'),
('��������������� ������������', 'Monday', 8, '2023-03-03', '2023-07-01'),
('������������������� ������������', 'Wednesday', 9, '2023-07-01', '2023-07-30'),
('�������������� ������������', 'Sunday', 10, '2023-06-01', '2023-07-01')

Create table [Doctors] /*�����*/
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(max) not null check (Name <> N''), /*��� �����*/
	[Surname] nvarchar(max) not null check (Surname <> N''), /*������� �����*/
	[Premium] money not null check ([Premium] >= 0) default 0,  /*�������� �����*/
	[Salary] money not null check ([Salary] > 0)  /*������ �����*/
);
go

Insert into [Doctors] (Name, Surname, Premium, Salary) 
VALUES
('���� ��������', '������', 4000, 10000), 
('ϸ�� ��������', '������', 5000, 9000), 
('����� ����������', '�������', 6000, 11000), 
('���� �����������', '����������', 3000, 7000), 
('������� �������������', '���������', 7000, 8000),
('������� �����������', '�����', 5000, 10000),
('���� ������������', '�����������', 4000, 11000),
('������� ����������',  '������', 3000, 12000),
('���� ��������', '������', 2000, 13000),
('���� ��������', '����������', 3000, 14000)

Create table [Specializations] /*�������������*/
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(100) not null unique check (Name <> N'') /*�������� �������������*/
);
go

Insert into [Specializations] (Name) 
VALUES
('������������'),
('������������'),
('������'),
('�����������'),
('���������'),
('��������'),
('��������'),
('��������'),
('������������'),
('�������')

Create table [Diseases] /*�������������*/
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(100) not null check (Name <> N''), /*�������� �����������*/
	[Severity] int not null, /*������� �������*/
	[SpecializationId] int not null FOREIGN KEY REFERENCES Specializations(Id) /*������������� ���������*/
);
go

Insert into [Diseases] (Name, Severity, SpecializationId) 
VALUES
('�������', 2, 1),
('���������', 3, 2),
('����� ����', 1, 3),
('���������', 2, 4),
('�����', 1, 5),
('����������� �����', 3, 6),
('������� �������', 1, 7),
('������', 1, 8),
('����������� �������', 2, 9),
('���������� �����������', 3, 10)

Create table [DoctorsSpecializations] /*����� � �������������*/
(
	[Id] int not null identity(1, 1) primary key,
	[DoctorId] int not null FOREIGN KEY REFERENCES Doctors(Id), /*������������� �����*/
	[SpecializationId] int not null FOREIGN KEY REFERENCES Specializations(Id), /*������������� �������������*/
	[DepartmentId] int not null FOREIGN KEY REFERENCES Departments(Id) /*������������� ���������*/
);
go

Insert into [DoctorsSpecializations]  (DoctorId, SpecializationId, DepartmentId)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10)

Create table [Sponsors] /*��������*/
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(100) not null unique check (Name <> N'') /*�������� ��������*/
);
go

Insert into [Sponsors] (Name) 
VALUES
('������� ���� �������������'),
('������������ ������ ������������'),
('������� ��������� ��������'),
('������� ��������� ���������'),
('�������� ����� ��������'),
('���������� ���� �����������'),
('������� ������ ��������������'),
('������� ��������� ���������'),
('������� ����� ����������'),
('������ ������� �����������')

Create table [Donations] /*�������������*/
(
	[Id] int not null identity(1, 1) primary key,
	[Amount] money not null check (Amount > 0.00), /*����� �������������*/
	[Date] date not null default getdate(),  
	[DepartmentId] int not null FOREIGN KEY REFERENCES Departments(Id), /*������������� ���������*/
	[SponsorId] int not null FOREIGN KEY REFERENCES Sponsors(Id) /*������������� �������� */
);
go

Insert into [Donations] (Amount, Date, DepartmentId, SponsorId) 
VALUES
(1000, getdate(), 1, 1),
(2000, getdate(), 2, 2),
(3000, getdate(), 3, 3 ),
(4000, getdate(), 4, 4),
(5000, getdate(), 5, 5),
(6000, getdate(), 6, 6),
(7000, getdate(), 7, 7),
(8000, getdate(), 8, 8),
(9000, getdate(), 9, 9),
(10000, getdate(), 10, 10)

Create table [Wards] /*������*/
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(20) not null unique check (Name <> N''), /*�������� ������*/
	[DepartmentId] int not null FOREIGN KEY REFERENCES Departments(Id) /*������������� ���������*/
);
go

Insert into [Wards] (Name, DepartmentId) 
VALUES
('����������', 1),
('�����������', 2),
('�������������', 3),
('������������', 4),
('����������������', 5),
('�����������', 6),
('���������������', 7),
('���������������', 8),
('�������������������', 9),
('��������������', 10)

Create table [Vacations] /*�������*/
(
	[Id] int not null identity(1, 1) primary key,
	[StartDate] date not null,/*���� ������ �������*/
	[EndDate] date not null, check(EndDate>StartDate), /*���� ���������� �������*/
	[DoctorId] int not null FOREIGN KEY REFERENCES Doctors(Id) /*������������� �����*/
);
go

Insert into [Vacations] (StartDate, EndDate, DoctorId) 
VALUES
('2023-01-01', '2023-07-01', 1),
('2023-03-02', '2023-03-14', 2),
('2023-04-01', '2023-04-07', 3),
('2023-05-01', '2023-05-15', 4),
('2023-06-07', '2023-06-16', 5),
('2023-07-01', '2023-07-20', 6),
('2023-08-05', '2023-08-30', 7),
('2023-09-01', '2023-09-07', 8),
('2023-10-01', '2023-10-25', 9),
('2023-12-17', '2023-12-28', 10)*/


--1. ������� ������ ����� ������ � �� �������������
Select Doctors.Name, Doctors.Surname, Specializations.Name
From Specializations Join DoctorsSpecializations ON Specializations.Id=DoctorsSpecializations.SpecializationId
					 Join Doctors ON DoctorsSpecializations.DoctorId=Doctors.Id
Group by Doctors.Name, Doctors.Surname, Specializations.Name;

--2. ������� ������� � �������� (����� ������ � ��������) ������, ������� �� ��������� � �������
Select Doctors.Surname, (Salary + Premium) AS '�������� ������'
From Doctors Join Vacations ON Doctors.Id=Vacations.DoctorId
WHERE EndDate not in ('2023-03-14')
Group by Doctors.Surname, Salary + Premium;

--3. ������� �������� �����, ������� ��������� � ��������� �Intensive Treatment�
Select Wards.Name AS '�������� �����', Departments.Name AS '����������'
From Departments Join Wards ON Wards.DepartmentId=Departments.Id  
WHERE Departments.Name= '���������������';

--4. ������� �������� ��������� ��� ����������, ������� ������������ ��������� �Umbrella Corporation�
Select DISTINCT Departments.Name, Sponsors.Name 
From Departments Join Donations ON Departments.Id=Donations.DepartmentId 
     Join Sponsors ON Donations.SponsorId=Sponsors.Id 
WHERE Sponsors.Name='������� ��������� ���������';

--5. ������� ��� ������������� �� ��������� ����� � ����:
--���������, �������, ����� �������������, ���� �������������
Select Departments.Name, Sponsors.Name, Donations.Amount, Donations.Date
From Departments Join Donations ON Departments.Id=Donations.DepartmentId 
     Join Sponsors ON Donations.SponsorId=Sponsors.Id 
WHERE date between '2023-03-01' and '2023-03-31'
Group by Departments.Name, Sponsors.Name, Donations.Amount, Donations.Date;

--6. ������� ������� ������ � ��������� ���������, � ������� ��� �������� ������������. ���������� ��������� 
--������������, ���������� ������ � ������ ���. --- ��� ����� ����� ��������� ��������� � ����� � ������� ������������
SELECT Doctors.Surname, Departments.Name 
FROM Doctors Join DoctorsSpecializations ON Doctors.Id=DoctorsSpecializations.DoctorId
       Join Departments ON DoctorsSpecializations.DepartmentId=Departments.Id
       Join Inspections ON Departments.Id=Inspections.DepartmentId
WHERE Inspections.DaysOfWeeks in ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')
Group by Doctors.Surname, Departments.Name;

--7. ������� �������� ����� � ������� ���������, � ������� 
--�������� ������������ ���� �Helen Williams�
/* ��� ������� ������� ��������� � ���������� ����� ����� � ���������*/
Select Wards.Name, Departments.Building
FROM Doctors Join DoctorsSpecializations ON Doctors.Id=DoctorsSpecializations.DoctorId
       Join Departments ON DoctorsSpecializations.DepartmentId=Departments.Id
       Join Wards ON Departments.Id=Wards.DepartmentId
	   Join Inspections ON Departments.Id=Inspections.DepartmentId
WHERE Doctors.Surname='������'; 

--8. ������� �������� ���������, ������� �������� ������������� � ������� ������ 100000, � ��������� �� ������
/*��� ���������� ������ ������� � ���������*/
SELECT Departments.Name, Doctors.Name 
FROM Doctors Join DoctorsSpecializations ON Doctors.Id=DoctorsSpecializations.DoctorId
       Join Departments ON DoctorsSpecializations.DepartmentId=Departments.Id
       Join Donations ON Departments.Id=Donations.DepartmentId
WHERE Donations.Amount>100000
Group by Departments.Name, Doctors.Name;

--9. ������� �������� ���������, � ������� ���� ����� �� ���������� �������� /*��� ���������� ������ ������� � ���������*/
SELECT Departments.Name
FROM Doctors Join DoctorsSpecializations ON Doctors.Id=DoctorsSpecializations.DoctorId
       Join Departments ON DoctorsSpecializations.DepartmentId=Departments.Id
WHERE Doctors.Premium=0;

--10. ������� �������� �������������, ������� ������������ 
--��� ������� ����������� �� �������� ������� ���� 3/ /*��� ������� ����������� �� �������� �������*/
Select Specializations.Name 
From Specializations Join Diseases ON Specializations.Id=Diseases.SpecializationId
WHERE Diseases.Severity>'3'

--11. ������� �������� ��������� � �����������, ������������ 
--�� ������� ��� ��������� �� ��������� �������. /*��� ������ ����������� � ������������*/
Select Departments.Name, Diseases.Name 
FROM Wards Join Departments ON  Departments.Id=Wards.DepartmentId
		   Join Inspections ON Departments.Id=Inspections.DepartmentId
	       Join DoctorsSpecializations ON Departments.Id=DoctorsSpecializations.DepartmentId
		   Join Specializations ON DoctorsSpecializations.SpecializationId=Specializations.Id
		   Join Diseases ON Specializations.Id=Diseases.SpecializationId
WHERE Inspections.StartDate between ('2023-01-01') and ('2023-06-01')
Group by Departments.Name, Diseases.Name;

--12. ������� �������� ��������� � �����, � ������� ����������� ������������ �� ������������� ������������. /*��� ������ ����������� � ������������*/
SELECT Departments.Name,  Wards.Name 
FROM Wards Join Departments ON  Departments.Id=Wards.DepartmentId
		   Join Inspections ON Departments.Id=Inspections.DepartmentId
	       Join DoctorsSpecializations ON Departments.Id=DoctorsSpecializations.DepartmentId
		   Join Specializations ON DoctorsSpecializations.SpecializationId=Specializations.Id
		   Join Diseases ON Specializations.Id=Diseases.SpecializationId
WHERE Diseases.Name='������'
Group by Departments.Name,  Wards.Name; 