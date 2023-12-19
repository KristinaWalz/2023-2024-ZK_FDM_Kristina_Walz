# Abgabeskript für Aufgabe 2 Shell im Zertifikatskurs FDM 2024-2024
# von Kristina Walz

# Setup: Ich befinde mich in einem Ordner, in dem neben diesem Skript auch die Datei "2023-12-01-Article_list_dirty.tsv" abgelegt ist.

# Löschen von Zeilen ohne ISSN  (1)
grep "[0-9]-[0-9]" 2023-12-01-Article_list_dirty.tsv > noempty.tsv

# Separate Datei für "IMPORTANT"-Zeilen erstellen
grep IMPORTANT 2023-12-01-Article_list_dirty.tsv > important.tsv

# Auswahl der gesuchten Spalten in noempty.tsv und important.tsv in ISSN_date_v0.1.tsv
cut -f5,12 noempty.tsv > ISSN_date_v0.1.tsv
cut -f7,14 important.tsv >> ISSN_date_v0.1.tsv

# Löschen von Zeilen ohne ISSN (2) (aka ehemalige "Important-Zeilen")
grep "[0-9]-[0-9]" ISSN_date_v0.1.tsv > ISSN_date_v0.2.tsv

# Bereinigen von ISSN-Spalte:
grep -i ISSN ISSN_date_v0.2.tsv > issn.tsv
grep ^[0-9] ISSN_date_v0.2.tsv > ISSN_date_v0.3.tsv
cut -d: -f2 issn.tsv >> ISSN_date_v0.3.tsv
sed 's/ //' ISSN_date_v0.3.tsv |sed 's/ //' > ISSN_date_v0.4.tsv

# Löschen von Dubletten und Anlegen der finalen Datei
sort -bn ISSN_date_v0.4.tsv | uniq > $(date "+%Y-%m-%d")_Dates_and_ISSNs.tsv

# Löschen der im Verlauf erzeugten Zwischenschritte
rm noempty.tsv important.tsv ISSN_date* issn.tsv
