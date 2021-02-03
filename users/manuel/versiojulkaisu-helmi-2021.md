![](https://endeavouros.com/wp-content/uploads/2021/02/eos-i3-fresh.png)

# Vuoden 2021 ensimmäinen ISO-julkaisu on saapunut!

Edellinen ISO-tiedostomme on syyskuulta, ja tiedostamme, että oli jo aikakin julkaista uusi versio. Tämä voidaan myös ajatella, että julkaisu tapahtuu muodikkaaasti myöhässä. Emme tosiaankaan ole levänneet laakereillamme, päinvastoin. Olemme vakuuttuneita, että ne jotka vielä eivät käytä EndeavousOS:ää saavat kutinan kokeilla tätä.

## Yhteisön kanssa tulosta

Tämä julkaisu ei olisi ollut mahdollista ilman loistavaa yhteisöämme. Useat yhteisön jäsenet ovat avustaneet meitä ei vain raportoimalla virheitä, mutta myös olleet mukana niitä selvittämässä ja korjaamassa. Olemme erittäin kiitollisia avustanne, ja tämä osoittaa, että tiedon jakamisella voimme siivittää EndeavourOS:ia aina vain pidemälle. Ovemme ovat auki teille, kävelkää vain sisään jos haluatte auttaa jossain ongelmassa, tai uuden ominaisuuden aikaansaamisessa - ilman kummempia velvollisuuksia.

Tällä hetkellä käynnissä on kaksi yhteisöprojektia ikkunamanagerien käyttöönottoa varten. Nämä tulevat olemaan mukana myöhemmissä julkaisuissamme. Kehitämme myös tapoja joilla yhteisöprojektit sujuvat aiempaa helpommin, jolloin useampikin yhteisön jäsen voi osallistua.

Kaiken lisäksi saimme uuden peilipalvelimen Intiaan - kiitos yhteisömme jäsenelle Overload9:lle, jonka palvelimelta tämän tilan saimme.

## Helmikuun julkaisu

![](https://endeavouros.com/wp-content/uploads/2021/02/endeavouros-wallpaper1-1024x576.jpg)

Tarpeetonta ehkä sanoakin, mutta verrattuna syyskuun julkaisuun tässä julkaisussa paketit saivat ison versioharppauksen eteenpäin.

Muutamia poimintoja:
- Linux ydin 5.10.11.arch1-1
- Mesa 20.3.4-1
- Nvidia 460.39-2
- Firefox 85.0-1
- Calamares 3.2.34-10
- Live-ympäristö ja offline-asentaja päivitetty Xfce 4.16:een

## Parannukset

Olemme parantaneet Live-ympäristöä (eli asentajaympäristöä) ja asennusprosessia tavoitteena tehdä asennuksesta entistäkin sujuvampaa. Esimerkiksi käyttäjä voi nyt itse vaikuttaa mitä haluamiasi lisäpaketteja asennetaan!

Lista olennaisista muutoksista ja parannuksista sekalaisessa järjestyksessä:
- Paketti reflector-auto on poistettu, koska paketissa reflector on samat ominaisuudet.
- Welcome-sovellus on saanut uuden käännöksen: Brasilian Portugali
- Pääteohjelmat `alacritty`, `terminology` ja `sakura` ovat nyt lisätty tuetuiksi sovelluksissamme
- Asennuksessa voi valita swap-tiedoston perinteisen swap-osion sijaan, kun käytetään automaattista osiointia
- Uusi paketti `reflector-bash-completion` on lisätty helpottamaan sovelluksen reflector käyttöä
- Online-asennuksessa peilipalvelimien lista päivitetään automaattisesti (ellei käyttäjä ole sitä jo tehnyt). Tämä voi huomattavasti nopeuttaa asennusta ja vähentää virheitä.
- Uusi palvelimemme Intiassa on sikäläisille käyttäjillemme tervetullut lisäys
- Asennuksen aikana uusi käyttäjä lisätään ryhmiin: `sys` `rfkill` `wheel` `users`. Olemme samalla poistaneet joitakin aiemmin käytettyjä ryhmiä jotka aiheuttivat ongelmia joidenkin ajureiden ja cups:n kanssa
- Asennettavia paketteja järjestettiin uudelleen, tämä paransi tiedostojärjestelmien tukea GTK- ja Qt-ympäristöissä
- GVFS-paketteja asennetaan vain GTK-ympäristössä
- Qt-ympäristössä asennetaan paketit `kio-fuse` `kio-gdrive` `audiocd-kio` oletuksena
- Pakettien sddm ja lightdm konfiguraatiotiedostot asennetaan vain tarpeen mukaan, ei enää molempia
- Voit lisätä suosikkipakettejasi asennettaviksi! Tähän on kaksi tapaa:
  - tiedosto `/home/liveuser/user_pkglist.txt`, johon yksinkertaisesti lisäät pakettien nimet (rivinvaihdoin tai välilyönnein eroteltuina) ennen asennuksen alkua
  - Welcome:n uusi valitsin: `--pkglist=URL`. Tässä URL on internet-osoite haluamaasi tiedostoon, joka sisältää listan lisäpaketteja (kuten edellä)
- Useita virhekorjauksia

## Uudet ominaisuudet

![](https://endeavouros.com/wp-content/uploads/2021/02/eos-rofi-menu-1024x576.png)

Olemme lisänneet seuraavia ominaisuuksia:
- Uusi teema ja konfiguraatio i3:lle
- Kehityksen helpottamiseksi ja korostaaksemme minimalistista ajatteluamme, tarjoamme nyt vain yhden "jokapaikan" taustakuvan kaikille työpöydille ja ikkunamanagereille. Tämä näkyy kaikissa tuetuissa arkkitehtuureissamme (`x86_64`, `ARM`).
- Welcome sisältää painikkeen `Pacdiff` jolla voi käsitellä pacman:n mahdollisesti tuottamia .pacnew (yms.) tiedostoja valitsemallasi tiedostojen vertailusovelluksella.
- Eos-log-tool (työkalu lokitiedostojen tuomiseen esim. foorumille) voi tehdä lokin myös tiedostoista /etc/fstab ja /boot/grub/grub.cfg
- Eos-update-notifier on saanut uuden konfiguraattorisovelluksen, ja sen voi käynnästää esim. Welcomesta
- Uusi työkalu `UpdateInTerminal` (yhteisön toivoma) jolla voi tarkistaa ja päivittää kaikki järjestelmän paketit ilman eos-update-notifier -sovellusta
- Uusi työkalu `eos-sendlog` jolla voi lähettää nettiin minkä tahansa tekstitiedoston esim. muiden tarkasteltavaksi. Korvaa aiemmin ohjeistetun apukomennon `curl -F 'f:1=<-' ix.io`
- Uusi työkalu `eos-pkginfo` jolla voi tutkia lisätietoja paketista (tyypillisesti kehittäjätietoja ja muuta hyödyllistä käyttöinformaatiota)

## Mistä saa

Uuden ISO-tiedoston voi, kuten ennenkin, ladata [täältä](https://endeavouros.com/latest-release/).
