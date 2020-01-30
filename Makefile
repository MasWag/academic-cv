cv_2020_Spring.pdf: cv_2020_Spring.saty bib.satyh
	satysfi $<

bib.satyh: bib.satyh.head bib.satyh.body
	cat $^ > $@
bib.satyh.body: MasakiWaga.xml makeBib.xsl
	saxon -xsl:makeBib.xsl $< > $@
MasakiWaga.xml: 
	wget 'https://dblp.uni-trier.de/pers/xx/w/Waga:Masaki.xml' -O $@

clean:
	$(RM) bib.satyh bib.satyh.body MasakiWaga.xml

.PHONY: clean
