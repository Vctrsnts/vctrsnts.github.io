# Cambios en el blog - 1

Se que llevo un par de semanas sin escribir ningun articulo, pero he estado un poco liado dandole un poco chapa y pintura a este blog que se traduce en lo que estais viendo ahora.

<!--more-->

Como ya sabreis, lo explico en este [articulo](/2023-02-13-jekyll-muy-configurable), esta web se hace gracias a [Jekyll](https://github.com/BretFisher/jekyll-serve) y eso me facilita mucho los cambios, aunque no soy muy aficionado a ellos.

Tambien influye que ya me habia cansado del tema que estaba usando hasta el momento, me puse a buscar algo diferente diferente y más actual y que además el proyecto estuviera vivo, no como el que antes usaba que hacia como unos 5 años que no se hacia nada.

Me puse a buscar por las diferentes paginas web que hay con temas de **Jekyll** e iba probando las que más o menos me gustaban, pero sin llegar a encontrar ninguna que me convenciera, asi que como ultimo recurso, no me gusta nada, pero cuando no queda más remedio, le hice la consulta a **chatgpt** para que me echara una mano para escoger un buen tema 😂

A la *IA* le di un par de pautas que tenia que cumplir en nuevo tema, esas pautas eran las siguientes:
- El proyecto tenia que estar vivo.
- Facil configuración de *Mastodon*.
  - Esto viene porque todos los temas que iba revisando o no tenian implementada esta nueva red social o hacer las modificaciones necesarias eran muy complicadas.
- Que fuera facil de usar y de trabajar con el en caso de querer realizar alguna modificación.
- Que trabajase con la fuente [Font Awesome](https://fontawesome.com) lo más actualizada posible.
  - Esto es debido a que todos los temas que me iba encontrando usaban la versión 4.7 que no incluye los iconos de *Mastodon* y para actualizar a una nueva versión, es muy dificil de hacer.

**ChatGpt** me dio algunos temas que eran interesantes, pero no me acababan de convencer (para que luego digan que la *IA* puede sernos de ayuda, pues conmigo no funciono). Asi que segui buscando, hasta que un buen dia, no se si ya lo habia descartado, me volvi a encontrar este [tema](https://github.com/sylhare/Type-on-Strap) y me decidi a probarlo.

Cada vez que lo usaba, lo iba viendo con otros ojos, porque contra más lo usaba más facil me resultaba. Además cumplia casi todos los requisitos de mi lista por no decir todos:
- El proyecto esta vivo.
- Facil de usar y de trabajar con el por si quieres hacer modificaciones en el codigo.
- Facil configuración de la red de **Mastodon**. Uno de los pocos que la incluyen.
- Usa una de las ultimas versiones de **Font Awesome**.
- Un mejor desempeño con las **Categorias** y con los **TAGS**.
  - Este mejor desempeño, me ha llevado a que he tenido que modificar todos los articulos pero creo que ha sido beneficioso, porque me he dado cuenta, que mientras estaba probando otros temas, todos iban en la misma dirección.
- Tambien esta la opción de visualizar el archivo de la web con todos los articulos y el año de su creación que es una cosa que siempre me ha hecho gracia tener, pero que no sabia como se podia implementar.
  - Tendre que ponerme en serio con los temas de jekyll porque se pueden hacer muchas virguerias.

Asi que me puse a trabajar con el. Poco a poco me iba haciendo con el y entendiendo mucho mejor su funcionamiento hasta ahora, que ya lo he integrado completamente en el blog.

Eso si, le he hecho algunas modificaciones que creo que le hacian falta que son:
- En el tema original tienes la posibilidad de compartir *si o si* el articulo, pero en mi caso, esa opción no me interesaba asi que puse un flag para que se pueda desactivar esa funcionalidad.
  - La he compartido con el creador del tema y le ha parecido interesante. Me ha pedido que haga un **Pull Request** o sino tengo mucha prisa, cuando el tenga tiempo añadira dicha modificación. Con respecte al **PR** le he dicho, que mejor que lo haga el 😂, porque no me siento muy seguro, por no decir que nunca he hecho ninguno, con lo que implica. Miedo a que me cargue algo del codigo y no se realmente como se hace.
- Tambien le he añadido el tema de las licencias. En mi caso la **Creative Commons** como podeis ver al final de la web.

Asi nos encontramos. Seguramente le hare un par más de modificaciones, pero tengo que meditarlas mejor para ver si son utiles o no.

Ya os ire explicando como va todo.
#### Referencia
- [Jekyll-serve](https://github.com/BretFisher/jekyll-serve)
- [Type-on-Strap](https://github.com/sylhare/Type-on-Strap)

