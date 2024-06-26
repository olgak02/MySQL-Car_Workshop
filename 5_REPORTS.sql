CREATE OR REPLACE VIEW Raport_wizyty_pojazdu AS
SELECT P.VIN, P.PRODUCENT, P.MODEL, P.NUMER_REJESTRACYJNY, P.DATA_ZAKUPU, P.GWARANCJA,
WIZYTA.DATA_GODZINA_PRZYJECIA, WIZYTA.DATA_GODZINA_ODBIORU, WIZYTA.WYWIAD_Z_KLIENTEM, WIZYTA.CENA,
SLOWNIK_STATUSU.NAZWA, 
WU.USLUGA, WU.PRACOWNIK,
PRACOWNIK.IMIE, PRACOWNIK.NAZWISKO,
CZESCI_DO_WIZYTY.SKU,
CZESC.NAZWA_CZESCI
FROM WIZYTA
JOIN POJAZD P ON P.VIN=WIZYTA.POJAZD
JOIN WYKONANA_USLUGA WU ON WU.WIZYTA = WIZYTA.ID
JOIN SLOWNIK_STATUSU ON SLOWNIK_STATUSU.ID = WIZYTA.STATUS_WIZYTY
JOIN PRACOWNIK ON PRACOWNIK.PESEL=WU.PRACOWNIK
JOIN CZESCI_DO_WIZYTY ON CZESCI_DO_WIZYTY.WIZYTA=WIZYTA.ID
JOIN CZESC ON CZESC.SKU=CZESCI_DO_WIZYTY.SKU;

CREATE OR REPLACE VIEW Raport_uslugi_w_wizytach AS
SELECT WIZYTA.ID AS NUMER_WIZYTY, 
USLUGA.NAZWA_USLUGI,
WU.DATA_GODZINA_POCZATEK, WU.DATA_GODZINA_ZAKONCZENIE, 
P.PESEL, P.IMIE, P.NAZWISKO, P.SPECJALIZACJA,
SPECJALIZACJA.NAZWA
FROM WYKONANA_USLUGA WU
JOIN WIZYTA ON WIZYTA.ID=WU.WIZYTA
JOIN USLUGA ON USLUGA.ID=WU.USLUGA
JOIN PRACOWNIK P ON P.PESEL=WU.PRACOWNIK 
JOIN SPECJALIZACJA ON SPECJALIZACJA.ID = P.SPECJALIZACJA;


CREATE OR REPLACE VIEW Raport_stan_magazynu AS
SELECT M.SKU, M.NUMER_KATALOGOWY, M.NUMER_OEM, M.NAZWA_CZESCI, M.CENA, M.ILOSC_NA_STANIE, M.ILE_ZAMOWIONYCH,
CZESCI_DO_USLUGI.ILOSC_POTRZEBNYCH,
USLUGA.NAZWA_USLUGI
FROM CZESCI_DO_USLUGI
JOIN CZESC M ON M.SKU=CZESCI_DO_USLUGI.SKU
JOIN USLUGA ON USLUGA.ID=CZESCI_DO_USLUGI.USLUGA;

CREATE OR REPLACE VIEW Raport_zakonczone_wizyty AS
SELECT W.ID, U.NAZWA_USLUGI, P.PRODUCENT, P.MODEL,
K.IMIE as IMIE_KLIENTA, K.NAZWISKO as NAZWISKO_KLIENTA, 
PRAC.IMIE as IMIE_PRACOWNIKA, PRAC.NAZWISKO as NAZWISKO_PRACOWNIKA
FROM WIZYTA W
JOIN WYKONANA_USLUGA WY ON W.ID = WY.WIZYTA
JOIN USLUGA U ON WY.USLUGA = U.ID
JOIN POJAZD P ON W.POJAZD = P.VIN
JOIN KLIENT K ON P.WLASCICIEL = K.ID
JOIN PRACOWNIK PRAC ON WY.PRACOWNIK = PRAC.PESEL
WHERE WY.STATUS_USLUGI = 2;
 
CREATE OR REPLACE VIEW Raport_pojazdy_po_gwarancji AS
SELECT p.Producent, p.Model, p.Numer_Rejestracyjny, p.Data_Zakupu, p.Gwarancja, k.Imie, k.Nazwisko
FROM POJAZD p
JOIN KLIENT k ON p.Wlasciciel = k.ID
WHERE
p.Gwarancja > 0
AND DATE_ADD(p.Data_Zakupu, INTERVAL p.Gwarancja YEAR) < NOW();
