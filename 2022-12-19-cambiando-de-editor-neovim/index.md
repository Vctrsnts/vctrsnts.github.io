# Cambiando de editor. Neovim

Cansado un poco de tener que siempre usar editores faciles (estilo `mousepad`) o que dejaban de tener soporte (`Atom`) y que además no me hacian la vida facil para integrarse con GitHub, intente buscar un nuevo editor que lo tuviera todo y mirando los videos de [Atareao](https://atareao.es) me fije en que tenia una guia de instalación y de uso de `Neovim`, clonico de Vim, y me puse con ello.

<!--more-->

Porque una de mis ilusiones, era saber utilizar y poder sacarle todo el partido a Vim, pero por falta de tiempo o ganas, nunca me habia puesto, pero gracias a los videos de `Atareao` me entro el gusanillo y ...

Para empezar, [Lorenzo](https://atareao.es) tiene una excelente guia para iniciarse y usarlo donde todo esta muy bien explicado (aunque aun tengo algunas dudas para aclarar), pero para un uso sencillo y sin muchas complicaciones tienes más que suficiente, si quieres más, ahi es donde tu, tienes que ponerte a investigar con más intensidad.

Para que te hagas una idea, todo lo podeis leer a partir del articulo de [Publicar feed en Mastodon](2022-11-14-publicar-feed-mastodon.md) todo lo estoy escribiendo con `Neovim` y me parece que me voy a quedar en el, porque tal como lo tengo, y eso, que aun tengo algunas cosas que pulir, me parece perfecto la funcionalidad que tiene.

Yo no voy a explicar todos los pasos que tienes que hacer para instalarlo y su posterior configuración, porque eso mirando los videos de `atareao.es` lo puede hacer tu solo, pero lo que si que voy a poner, son mis ficheros de configuración que estoy utilizando actualmente (aunque tambien los podeis encontrar en mis dot_files), que a lo mejor te pueden servir de ayuda.

La estructura de ficheros para la configuración de `Neovim` es de la siguiente manera:
- **nvim**
  - *lua*
    - `plugins`: Donde tenemos las configuraciones de todos los plugins que usamos
      - `packer.lua`: Fichero donde se definen los plugins que se van a cargar (de donde los tiene que conseguir) asi como la configuración que van a tener
    - `settings.lua`: Opciones de configuración general de neovim
    - `keymaps.lua`: Configuración de las opciones de teclado de neovim
  - *spell*: Donde tenemos todos los archivos de idiomas que usamos
  - *templates*: Los templates / plantillas que usamos
  - *init.lua*: Fichero de inicio de neovim junto con los plugins que se van a utilizar:w

#### init.lua
```yaml
--[[
██╗███╗   ██╗██╗████████╗██╗     ██╗   ██╗ █████╗
██║████╗  ██║██║╚══██╔══╝██║     ██║   ██║██╔══██╗
██║██╔██╗ ██║██║   ██║   ██║     ██║   ██║███████║
██║██║╚██╗██║██║   ██║   ██║     ██║   ██║██╔══██║
██║██║ ╚████║██║   ██║██╗███████╗╚██████╔╝██║  ██║
╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝
Neovim init file
Version: 0.8.1 - 2022/11/14
Maintainer: Vctrsnts
Website: https://vctrsnts.github.io
Referencia: https://github.com/brainfucksec/neovim-lua
--]]

----------------------------------------------------------------------------------------------------
-- Import Lua Modules
----------------------------------------------------------------------------------------------------
require('settings')                                   -- Fitxer dels Settings
require('keymaps')			                              -- Fitxer de la configuració del teclat

----------------------------------------------------------------------------------------------------
-- Comença la carrega de plugins
----------------------------------------------------------------------------------------------------
require('plugins/packer')		                          -- Gestor de Plugins
require('plugins/autosave')                           -- Plugin per a realitzar el AutoSave
require('plugins/ayu')			                          -- Color Theme
require('plugins/neo-tree')                           -- filebrowser
require('plugins/feline')                             -- statusline
```

#### settings.lua
```yaml
----------------------------------------------------------------------------------------------------
-- Neovim API Aliases
----------------------------------------------------------------------------------------------------
local cmd = vim.cmd
local exec = vim.api.nvim_exec
local fn = vim.fn
local g = vim.g
local opt = vim.opt

----------------------------------------------------------------------------------------------------
-- Configuració General
----------------------------------------------------------------------------------------------------
g.mapleader = ';'					                            -- Canviar leader a coma
opt.swapfile = false					                        -- No fe servir swapfile

----------------------------------------------------------------------------------------------------
-- Neovim UI
----------------------------------------------------------------------------------------------------
opt.number = true					                            -- Es visualitzar els numeros de les linias
opt.relativenumber = true				                      -- Es visualitzar el numero relatiu de la linia
opt.foldmethod = 'marker'				                      -- Activada folding (default 'foldmarker')
opt.splitright = true					                        -- vertical split to the right
opt.splitbelow = true					                        -- horizontal split to the bottom
opt.linebreak = true					                        -- wrap on word boundary
opt.colorcolumn = '80'					                      -- Es visualitzar la linia que marca els 80 caracters
opt.termguicolors = true 
opt.guifont = "Fira Code"
g.neovide_cursor_vfx_mode = "railgun"

opt.list = true
opt.listchars = 'tab:▸ ,space:·,nbsp:␣,trail:•,precedes:«,extends:»'

---------------------------------------------------------------------------------------------------
-- Corrector ortografic per llenguatge
---------------------------------------------------------------------------------------------------
exec ([[
augroup markdownSpell
  autocmd!
  autocmd FileType mardown setlocal spell Spelllang=es
  autocmd BufRead,BufNewFile *.md setlocal spell spelllang=es
augroup END
]], false)

---------------------------------------------------------------------------------------------------
-- Tabs, indent
---------------------------------------------------------------------------------------------------
opt.expandtab = true					                        -- use spaces instead of tabs
opt.shiftwidth = 2					                          -- shift 2 spaces when tab
opt.tabstop = 2						                            -- 1 tab == 2 spaces
opt.smartindent = true					                      -- autoindent new lines

---------------------------------------------------------------------------------------------------
-- Memory, CPU
---------------------------------------------------------------------------------------------------
opt.hidden = true                                     -- enable background buffers
opt.lazyredraw = true                                 -- faster scrolling
opt.synmaxcol = 1000                                  -- max column for syntax highlight
```
 
#### keymaps.lua
```yaml
----------------------------------------------------------------------------------------------------
-- VARIABLES / ALIASES
----------------------------------------------------------------------------------------------------
local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}
local cmd = vim.cmd

----------------------------------------------------------------------------------------------------
-- Applications & Plugins shortcuts:
----------------------------------------------------------------------------------------------------

--
-- nvim-tree
--
map('n', '<C-n>', ':Neotree toggle<CR>', default_opts)       -- open/close
```
 
#### packer.lua
```yaml
--[[
S'ENCARREGA DE TOTA LA CONFIGURACIÓ / CARREGA DE PLUGINS

Plugin manager: packer.nvim
https://github.com/wbthomason/packer.nvim

For information about installed plugins see the README
neovim-lua/README.md
https://github.com/brainfucksec/neovim-lua#readme
--]]

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
 packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
return require('packer').startup(function(use)
 -- My plugins here
 -- use 'foo1/bar1.nvim'
 -- use 'foo2/bar2.nvim'

 -- Automatically set up your configuration after cloning packer.nvim
 -- Put this at the end after all plugins
 use 'wbthomason/packer.nvim'

 -------------------------------------------------------------------------------------------------
 -- colorschemes
 -------------------------------------------------------------------------------------------------
 use 'Shatur/neovim-ayu'

 -------------------------------------------------------------------------------------------------
 -- Activem Icones
 -------------------------------------------------------------------------------------------------
 use 'kyazdani42/nvim-web-devicons'
 use 'adelarsq/vim-devicons-emoji'

 -------------------------------------------------------------------------------------------------
 -- Activem Explorer / Navegador de directoris
 -------------------------------------------------------------------------------------------------
 use {
   'nvim-neo-tree/neo-tree.nvim',
   branch = "v2.x",
   requires = {
     "nvim-lua/plenary.nvim",
     "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
     "MunifTanjim/nui.nvim"
   }
 }
 
 -------------------------------------------------------------------------------------------------
 -- Activem Status Line
 -------------------------------------------------------------------------------------------------
 use ('Iron-E/nvim-highlite')
 use {
   'feline-nvim/feline.nvim',
   requires = {
    'nvim-web-devicons'
   },
 }

 -------------------------------------------------------------------------------------------------
 -- Activem el AutoSave
 -------------------------------------------------------------------------------------------------
 use "Pocco81/auto-save.nvim"

 -------------------------------------------------------------------------------------------------
 -- Final del fitxer de configuració de plugins
 -------------------------------------------------------------------------------------------------
 if packer_bootstrap then
   require('packer').sync()
 end
end)
```
 
Pues, ya has podido comprobar como lo tengo yo configurado y a pleno rendimiento, pero tal como he dicho al principio, aun falta por pulir algunas cosas.
#### Referencia
- [Guia sobre Neovim - Atareao.es](https://www.youtube.com/watch?v=SoDjVPr5_Go&list=PL3lTiK2rXrUEL52KOZcTBsoLMndfFBV2Q)

