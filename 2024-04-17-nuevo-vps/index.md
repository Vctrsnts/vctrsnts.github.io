# Hemos encontrado la solución al desastre el siglo??

Tal como escribi en este [articulo](/2024-04-10-desastre-siglo) donde explicaba que, seguramente por error mio, al detener la instancia, esta se perdio y luego fue imposible remontarla, porque no **habia recursos disponibles**.

<!--more-->

Entonces, recordando que tenia una instancia en Google Cloud, la volvi a activar y hasta hace un par de dias era lo que usaba. Pero claro, con todos los servicions que le habia puesto:
- [Searxng](/2024-01-10-searxng-uno-todo)
- [duckdns y Caddy](/2021-04-08-rpi-caddy-proxy-manager)
- [rss-funnel](/2024-04-13-uno-juntarlos-todos)
- [Sock5]({})
- [Glances]({})

La maquina de Google se me quedaba pequeña, sobre todo en memoria, quedaban libres unos 150Mb, se que muchos direis, que eso es una barbaridad, pero me gusta ir sobre-seguro y que el dia de mañana cuando necesite un poco más no tenga problemas. Si teneis razon, es para uso personal, pero ... y más cuando habia pensado traspasar una sección del contendor de [flexget](/2021-05-30-flexget-podcast) (la sección que se encarga de los podcast), que tengo ahora mismo en mi servidor personal a Google. Ante esto, me veia en la necesidad de disponer de un VPS un poco más completo que el de Google.

Gracias al articulo que escribi explicando que me habia sucedido con la instancia de Oracle, se puso en contacto conmigo, [atareao](https://atareao.es) para aconsejarme (se necesita mucha más gente como el), que el tenia un par de VPS en [contabo](https://www.contabo.com) y que a parte de ser economico, nunca habia tenido ningun problema, asi que me puse a buscar información sobre ese VPS.

Lo que encontre, al principio me asusto un poco, porque, eso si, habia mucha gente que decia que estaba muy contenta con ellos y muy economicos, pero que cuidado si tienes algun problema porque tardaran mucho en solucionartelo, si es que lo hacen.

Aqui es donde pense para mi mismo, como cualquier otra empresa, cuando todo va bien, no tienes ninguna queja, pero como tengas un problema, te las veras y te las desearas para que te lo solucionen, sino, que se lo pregunten a las personas que tienen cualquier empresa de telecomunicación si estan contentos con ellos. Pasara lo mismo, mucha gente diciendo que estan supercontentos, y otros estaran echando pestes sobre esas empresas, porque cada 2x3 tienen problemas.

Asi que me puse de nuevo en contacto con **atareao**, gracias a mastodon, para comentar ese tema y el me comento, que nunca habia tenido ningun problema y que estaba muy contento con ellos, y que además, habia tenido un problema y se lo habian solucionado inmediantamente.

Pues nada, me lance a la piscina y contrate con ellos el siguiente VPS:
- 4 vCPU Cores
- 6 GB RAM
- 100 GB NVMe or 400 GB SSD
  - En mi caso seleccione los 400Gb SSD, porque prefiero tener 400Gb que 100Gb. Si a lo mejor con los 100Gb ire más deprisa, pero cuanto más.
- 1 Snapshot
  - Aun tengo que investigar como sacarle provecho
- 32 TB Traffic
  - Más que de sobras para lo que lo utilizo yo

Como eran unos requisitos que estaban muy bien, pues nada, me di de alta y ya tengo un nuevo VPS para substituir a mis antiguos VPS (Oracle y Google).

De momento, estoy con todo el tema de la configuración de la maquina, [acceso SSH](/2016-04-04-rpi-acceso-traves-ssh), firewall, [fail2ban](/2020-11-08-rpi-usando-fail2ban), etc...

Después lo primero es realizar la instalación (a traves de mi querido docker) de traefik para poder securizar aun más la maquina. 

Espero conseguirlo gracias a los videos de [atareo](https://atareao.es), los que más me han ayudado, pero podeis encontrar muchos más si vais a su pagina web, que cuando habla de traefik, los ojos le brillan :)
#### Referencia
- [Exprimiendo Traefink](https://atareao.es/podcast/exprimiendo-tu-proxy-inverso-traefik)
- [Mil servicios con Traefik](https://atareao.es/tutorial/self-hosted/mil-servicios-con-traefik)

