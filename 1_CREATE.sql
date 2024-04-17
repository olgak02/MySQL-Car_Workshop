CREATE DATABASE IF NOT EXISTS serwis;
USE serwis;

CREATE TABLE USLUGA (
    ID INT,
    Nazwa_Uslugi VARCHAR(255) NOT NULL,
    Opis TEXT NOT NULL,
    Cena_Minimalna DECIMAL(10, 2) NOT NULL,
    Cena_Maksymalna DECIMAL(10, 2) NOT NULL,
    Specjalizacja INT NOT NULL);
    
CREATE TABLE POJAZD (
    VIN CHAR(17),
	Producent VARCHAR(255) NOT NULL,
    Model VARCHAR(255) NOT NULL,
    Numer_Rejestracyjny VARCHAR(10) NOT NULL,
    Data_Zakupu DATE NOT NULL,
    Gwarancja INT NOT NULL,
    Wlasciciel INT NOT NULL);

CREATE TABLE KLIENT (
    ID INT,
    Imie VARCHAR(255) NOT NULL,
    Nazwisko VARCHAR(255) NOT NULL,
    Email VARCHAR(255));

CREATE TABLE WIZYTA (
    ID INT,
    Cena DECIMAL(10, 2),
    Wycena DECIMAL(10, 2) NOT NULL,
    Wywiad_Z_Klientem TEXT NOT NULL,
    Czas_Naprawy TIME,
    Data_Godzina_Przyjecia DATETIME NOT NULL,
    Data_Godzina_Odbioru DATETIME,
    Termin DATETIME,
    Pojazd CHAR(17) NOT NULL,
    Status_Wizyty INT NOT NULL);

CREATE TABLE PRACOWNIK (
    Pesel CHAR(11),
    Imie VARCHAR(255) NOT NULL,
    Nazwisko VARCHAR(255) NOT NULL,
    Telefon VARCHAR(30) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Specjalizacja INT);
    
CREATE TABLE CZESC (
    SKU INT,
    Numer_Katalogowy VARCHAR(255) NOT NULL,
    Nazwa_Czesci VARCHAR(255) NOT NULL,
    Ilosc_Na_Stanie INT NOT NULL,
    Cena DECIMAL(10, 2) NOT NULL,
    Numer_OEM VARCHAR(255) NOT NULL,
    Ile_Zamowionych INT NOT NULL);
    
CREATE TABLE WYKONANA_USLUGA (
    Wizyta INT,
    Usluga INT,
    Pracownik char(11) NOT NULL,
    Data_Godzina_Poczatek DATETIME NOT NULL,
    Data_Godzina_Zakonczenie DATETIME,
    Status_Uslugi INT NOT NULL);
 
CREATE TABLE CZESCI_DO_WIZYTY (
	Wizyta INT,
    SKU INT,
    Ilosc_Wykorzystanych INT NOT NULL);

CREATE TABLE SPECJALIZACJA (
    ID INT,
    Nazwa VARCHAR(255) NOT NULL);

CREATE TABLE CZESCI_DO_USLUGI (
	Usluga INT,
    SKU INT,
    Ilosc_Potrzebnych INT NOT NULL);
    
CREATE TABLE SLOWNIK_STATUSU (
    ID INT,
    Nazwa VARCHAR(255) NOT NULL);
    
CREATE TABLE ZESTAW_USLUGA (
ID INT,
ID_USLUGA INT);
