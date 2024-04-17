#Trigger ,,Data_Godzina_Zakonczenie" w przypadku gdy Status_Usługi zostanie zaktualizowany na 2 automatycznie przypisuje aktualną datę do atrybutu ,,Data_Godzina_Zakonczenie"
DELIMITER //
CREATE TRIGGER Data_Godzina_Zakonczenie
BEFORE UPDATE ON WYKONANA_USLUGA
FOR EACH ROW 
BEGIN
	IF NEW.Status_Uslugi = '2' THEN
		SET NEW.Data_Godzina_Zakonczenie = NOW();
	END IF;
END;
//
DELIMITER ;
#Trigger ,,Data_Godzina_Odbioru" w przypadku gdy Status_Wizyty zostanie zaktualizowany na 4 automatycznie przypisuje aktualną datę do atrybutu ,,Data_Godzina_Odbioru"
DELIMITER //
CREATE TRIGGER  Data_Godzina_Odbioru
BEFORE UPDATE ON WIZYTA 
FOR EACH ROW 
BEGIN
	IF NEW.Status_Wizyty = '2' THEN
		SET NEW.Data_Godzina_Odbioru = NOW();
	END IF;
END;
//
DELIMITER ;
#Trigger w przypadku gdy wartość atrybutu ,,Ilosc_Wykorzystanych" zostanie zaktualizowana i jest różna od 0 automatycznie odejmuje tą samą wartość w atrybucie ,,Ilosc_Na_Stanie" dla części z tym samym numerem SKU 
DELIMITER //
CREATE TRIGGER  CZESCI
BEFORE UPDATE ON CZESCI_DO_WIZYTY
FOR EACH ROW 
BEGIN
	DECLARE odejmowanie INT;
	IF NEW.Ilosc_Wykorzystanych != 0 THEN
		SELECT Ilosc_Wykorzystanych INTO odejmowanie FROM CZESCI_DO_WIZYTY WHERE SKU = NEW.SKU;
        UPDATE CZESC SET Ilosc_Na_Stanie = Ilosc_Na_Stanie - odejmowanie where SKU=NEW.SKU;
	END IF;
END;

//
DELIMITER ;
DELIMITER //


