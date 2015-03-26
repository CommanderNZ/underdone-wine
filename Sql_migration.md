# Commiter #
  * Alexandre.sandros

# Details #
## SQL Scheme ##
<table border='1'>
<blockquote><tr>
<blockquote><td><b>Name</b></td><td>Id</td><td>Sid</td><td>Name</td><td>Inventory</td><td>Bank</td><td>Quests</td><td>friends</td><td>Exp</td>
</blockquote></tr>
<tr>
<blockquote><td><b>Type</b></td><td>int</td><td>varchar 30</td><td>varchar 25</td><td>TEXT</td><td>TEXT</td><td>TEXT</td><td>TEXT</td><td>int</td>
</blockquote></tr>
<tr>
<blockquote><td><b>Variable</b></td><td>none(auto increment)</td><td><pre><code>ply:SteamID()</code></pre></td><td><pre><code>ply:Nick()</code></pre></td><td><pre><code>ply.Data.Inventory</code></pre></td><td><pre><code>ply.Data.Bank</code></pre></td><td><pre><code>ply.Data.Quests</code></pre></td><td><pre><code>ply.Data.Friends</code></pre></td><td><pre><code>ply:GetNWInt("exp")</code></pre></td>
</blockquote></tr>
</table></blockquote>

  * File : ```
gamemode/serverfile/core/serverfile/savingloading.lua```
    * Functions to rebuild
      * ```
meta:LoadGame() l.31```
      * ```
meta:SaveGame() l.84```
**All Queries should be valid MySQL Queries**

  * Functions to add
    * ```
DB.send(table)```
    * ```
DB.get(table)```

_There should be DB.send and DB.get functions for all the SQL methods, only one will be loaded depends on whitch type of saving is chosen by the gamemode config file._