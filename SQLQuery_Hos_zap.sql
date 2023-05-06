/*Create database [Hospital_3];
go

Use [Hospital_3];
go

Create table [Departments] /*Отделения*/
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(100) not null unique check ([Name] <> N''), /*Название отделения*/
	[Building] nvarchar(100) not null unique check ([Building] <> N'') /*Название отделения*/
);
go

Insert into [Departments] (Name, Building)
VALUES 
('Реанимация', 'А22'),
('Анастезиологическое', 'И23'),
('Хирургическое', 'В24'),
('Офтальмологическое', 'В21'),
('Гематологическое', 'Е25'),
('Нефрологическое', 'Г32'),
('Неврологическое', 'К26'),
('Психологическое', 'Д12'),
('Эндокринологическое', 'Д13'),
('Онкологическое', 'Л14')

Create table [Inspections] /*Обследования*/
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(100) not null unique check ([Name] <> N''), /*Название обследования*/
	[DaysOfWeeks] nvarchar(100) not null check ([DaysOfWeeks] <> N''), /*День обследования*/
	[DepartmentId] int not null FOREIGN KEY REFERENCES Departments(Id), /*Идентификатор отделения*/
	[StartDate] date not null,/*Дата начала обследования*/
	[EndDate] date not null, check(EndDate>StartDate) /*Дата завершения обследования*/
);
go

Insert into [Inspections] (Name, DaysOfWeeks, DepartmentId, StartDate, EndDate)     
VALUES 
('Реанимационное обследование', 'Monday', 1, '2023-01-01', '2023-01-07'),
('Анастезиологическое обследование', 'Tuesday', 2, '2023-01-01', '2023-02-01'),
('Хирургическое обследование', 'Wednesday', 3, '2023-03-01', '2023-04-01'),
('Офтальмологическое обследование', 'Thursday', 4, '2023-01-01', '2023-07-01'),
('Гематологическое обследование', 'Friday', 5, '2023-01-01', '2023-07-01'),
('Нефрологическое обследование', 'Saturday', 6, '2023-02-01', '2023-05-01'),
('Неврологическое обследование', 'Sunday', 7, '2023-01-01', '2023-04-09'),
('Психологическое обследование', 'Monday', 8, '2023-03-03', '2023-07-01'),
('Эндокринологическое обследование', 'Wednesday', 9, '2023-07-01', '2023-07-30'),
('Онкологическое обследование', 'Sunday', 10, '2023-06-01', '2023-07-01')

Create table [Doctors] /*Врачи*/
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(max) not null check (Name <> N''), /*Имя врача*/
	[Surname] nvarchar(max) not null check (Surname <> N''), /*Фамилия врача*/
	[Premium] money not null check ([Premium] >= 0) default 0,  /*Надбавка врача*/
	[Salary] money not null check ([Salary] > 0)  /*Ставка врача*/
);
go

Insert into [Doctors] (Name, Surname, Premium, Salary) 
VALUES
('Иван Иванович', 'Иванов', 4000, 10000), 
('Пётр Петрович', 'Петров', 5000, 9000), 
('Денис Евгеньевич', 'Сидоров', 6000, 11000), 
('Элла Григорьевна', 'Калаборова', 3000, 7000), 
('Татьяна Александровна', 'Казанкина', 7000, 8000),
('Евгений Григорьевич', 'Царук', 5000, 10000),
('Юрий Валентинович', 'Нечипоренко', 4000, 11000),
('Василий Васильевич',  'Храпач', 3000, 12000),
('Юрий Игоревич', 'Заседа', 2000, 13000),
('Алла Олеговна', 'Вергуленко', 3000, 14000)

Create table [Specializations] /*Специализации*/
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(100) not null unique check (Name <> N'') /*Название специализации*/
);
go

Insert into [Specializations] (Name) 
VALUES
('Реаниматолог'),
('Анастезиолог'),
('Хирург'),
('Офтальмолог'),
('Гематолог'),
('Нефролог'),
('Невролог'),
('Психолог'),
('Эндокринолог'),
('Онколог')

Create table [Diseases] /*Специализации*/
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(100) not null check (Name <> N''), /*Название заболеваний*/
	[Severity] int not null, /*Степень тяжести*/
	[SpecializationId] int not null FOREIGN KEY REFERENCES Specializations(Id) /*Идентификатор отделения*/
);
go

Insert into [Diseases] (Name, Severity, SpecializationId) 
VALUES
('Инсульт', 2, 1),
('Пневмония', 3, 2),
('Киста зуба', 1, 3),
('Катаракта', 2, 4),
('Вывих', 1, 5),
('Заболевания почек', 3, 6),
('Нервная система', 1, 7),
('Психоз', 1, 8),
('Эндокринная система', 2, 9),
('Опухолевое заболевание', 3, 10)

Create table [DoctorsSpecializations] /*Врачи и специализации*/
(
	[Id] int not null identity(1, 1) primary key,
	[DoctorId] int not null FOREIGN KEY REFERENCES Doctors(Id), /*Идентификатор врача*/
	[SpecializationId] int not null FOREIGN KEY REFERENCES Specializations(Id), /*Идентификатор специализации*/
	[DepartmentId] int not null FOREIGN KEY REFERENCES Departments(Id) /*Идентификатор отделения*/
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

Create table [Sponsors] /*Спонсоры*/
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(100) not null unique check (Name <> N'') /*Название спонсора*/
);
go

Insert into [Sponsors] (Name) 
VALUES
('Кабанов Лука Ростиславович'),
('Константинов Гордей Богуславович'),
('Захаров Лаврентий Петрович'),
('Борисов Святослав Борисович'),
('Шарапова Эрида Семёновна'),
('Третьякова Инна Геннадиевна'),
('Баранов Гордий Константинович'),
('Доронин Лаврентий Филатович'),
('Горшков Артем Кириллович'),
('Ковалёв Аверьян Григорьевич')

Create table [Donations] /*Пожертвования*/
(
	[Id] int not null identity(1, 1) primary key,
	[Amount] money not null check (Amount > 0.00), /*Сумма пожертвования*/
	[Date] date not null default getdate(),  
	[DepartmentId] int not null FOREIGN KEY REFERENCES Departments(Id), /*Идентификатор отделения*/
	[SponsorId] int not null FOREIGN KEY REFERENCES Sponsors(Id) /*Идентификатор спонсора */
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

Create table [Wards] /*Палаты*/
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(20) not null unique check (Name <> N''), /*Название палаты*/
	[DepartmentId] int not null FOREIGN KEY REFERENCES Departments(Id) /*Идентификатор отделения*/
);
go

Insert into [Wards] (Name, DepartmentId) 
VALUES
('Реанимация', 1),
('Процедурная', 2),
('Хирургическая', 3),
('Перевязочная', 4),
('Гематологическая', 5),
('Сестринская', 6),
('Неврологическая', 7),
('Психиатрическая', 8),
('Эндокринологическая', 9),
('Онкологическая', 10)

Create table [Vacations] /*Отпуска*/
(
	[Id] int not null identity(1, 1) primary key,
	[StartDate] date not null,/*Дата начала отпуска*/
	[EndDate] date not null, check(EndDate>StartDate), /*Дата завершения отпуска*/
	[DoctorId] int not null FOREIGN KEY REFERENCES Doctors(Id) /*Идентификатор врача*/
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


--1. Вывести полные имена врачей и их специализации
Select Doctors.Name, Doctors.Surname, Specializations.Name
From Specializations Join DoctorsSpecializations ON Specializations.Id=DoctorsSpecializations.SpecializationId
					 Join Doctors ON DoctorsSpecializations.DoctorId=Doctors.Id
Group by Doctors.Name, Doctors.Surname, Specializations.Name;

--2. Вывести фамилии и зарплаты (сумма ставки и надбавки) врачей, которые не находятся в отпуске
Select Doctors.Surname, (Salary + Premium) AS 'Зарплаты врачей'
From Doctors Join Vacations ON Doctors.Id=Vacations.DoctorId
WHERE EndDate not in ('2023-03-14')
Group by Doctors.Surname, Salary + Premium;

--3. Вывести названия палат, которые находятся в отделении “Intensive Treatment”
Select Wards.Name AS 'Названия палат', Departments.Name AS 'Отделениия'
From Departments Join Wards ON Wards.DepartmentId=Departments.Id  
WHERE Departments.Name= 'Неврологическое';

--4. Вывести названия отделений без повторений, которые спонсируются компанией “Umbrella Corporation”
Select DISTINCT Departments.Name, Sponsors.Name 
From Departments Join Donations ON Departments.Id=Donations.DepartmentId 
     Join Sponsors ON Donations.SponsorId=Sponsors.Id 
WHERE Sponsors.Name='Борисов Святослав Борисович';

--5. Вывести все пожертвования за последний месяц в виде:
--отделение, спонсор, сумма пожертвования, дата пожертвования
Select Departments.Name, Sponsors.Name, Donations.Amount, Donations.Date
From Departments Join Donations ON Departments.Id=Donations.DepartmentId 
     Join Sponsors ON Donations.SponsorId=Sponsors.Id 
WHERE date between '2023-03-01' and '2023-03-31'
Group by Departments.Name, Sponsors.Name, Donations.Amount, Donations.Date;

--6. Вывести фамилии врачей с указанием отделений, в которых они проводят обследования. Необходимо учитывать 
--обследования, проводимые только в будние дни. --- нет связи между таблицами Отделения и Врачи и таблицы Обследования
SELECT Doctors.Surname, Departments.Name 
FROM Doctors Join DoctorsSpecializations ON Doctors.Id=DoctorsSpecializations.DoctorId
       Join Departments ON DoctorsSpecializations.DepartmentId=Departments.Id
       Join Inspections ON Departments.Id=Inspections.DepartmentId
WHERE Inspections.DaysOfWeeks in ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')
Group by Doctors.Surname, Departments.Name;

--7. Вывести названия палат и корпуса отделений, в которых 
--проводит обследования врач “Helen Williams”
/* Нет колонки Корпуса отделений и соединения между Врачи и Отделения*/
Select Wards.Name, Departments.Building
FROM Doctors Join DoctorsSpecializations ON Doctors.Id=DoctorsSpecializations.DoctorId
       Join Departments ON DoctorsSpecializations.DepartmentId=Departments.Id
       Join Wards ON Departments.Id=Wards.DepartmentId
	   Join Inspections ON Departments.Id=Inspections.DepartmentId
WHERE Doctors.Surname='Иванов'; 

--8. Вывести названия отделений, которые получали пожертвование в размере больше 100000, с указанием их врачей
/*Нет соединения таблиц Доктора и Отделения*/
SELECT Departments.Name, Doctors.Name 
FROM Doctors Join DoctorsSpecializations ON Doctors.Id=DoctorsSpecializations.DoctorId
       Join Departments ON DoctorsSpecializations.DepartmentId=Departments.Id
       Join Donations ON Departments.Id=Donations.DepartmentId
WHERE Donations.Amount>100000
Group by Departments.Name, Doctors.Name;

--9. Вывести названия отделений, в которых есть врачи не получающие надбавки /*Нет соединения таблиц Доктора и Отделения*/
SELECT Departments.Name
FROM Doctors Join DoctorsSpecializations ON Doctors.Id=DoctorsSpecializations.DoctorId
       Join Departments ON DoctorsSpecializations.DepartmentId=Departments.Id
WHERE Doctors.Premium=0;

--10. Вывести названия специализаций, которые используются 
--для лечения заболеваний со степенью тяжести выше 3/ /*Нет таблицы заболеваний со степенью тяжести*/
Select Specializations.Name 
From Specializations Join Diseases ON Specializations.Id=Diseases.SpecializationId
WHERE Diseases.Severity>'3'

--11. Вывести названия отделений и заболеваний, обследования 
--по которым они проводили за последние полгода. /*Нет таблиц Заболевания и Обследования*/
Select Departments.Name, Diseases.Name 
FROM Wards Join Departments ON  Departments.Id=Wards.DepartmentId
		   Join Inspections ON Departments.Id=Inspections.DepartmentId
	       Join DoctorsSpecializations ON Departments.Id=DoctorsSpecializations.DepartmentId
		   Join Specializations ON DoctorsSpecializations.SpecializationId=Specializations.Id
		   Join Diseases ON Specializations.Id=Diseases.SpecializationId
WHERE Inspections.StartDate between ('2023-01-01') and ('2023-06-01')
Group by Departments.Name, Diseases.Name;

--12. Вывести названия отделений и палат, в которых проводились обследования по заразительным заболеваниям. /*Нет таблиц Заболевания и Обследования*/
SELECT Departments.Name,  Wards.Name 
FROM Wards Join Departments ON  Departments.Id=Wards.DepartmentId
		   Join Inspections ON Departments.Id=Inspections.DepartmentId
	       Join DoctorsSpecializations ON Departments.Id=DoctorsSpecializations.DepartmentId
		   Join Specializations ON DoctorsSpecializations.SpecializationId=Specializations.Id
		   Join Diseases ON Specializations.Id=Diseases.SpecializationId
WHERE Diseases.Name='Психоз'
Group by Departments.Name,  Wards.Name; 