local params = std.extVar("__ksonnet/params").components["example-configmap"];
{
  "kind": "ConfigMap",
  "apiVersion": "v1",
  "metadata": {
    "name": "game-config"
  },
  "data": {
    "game.properties": |||
        enemies=%s
        lives=%s
        enemies.cheat=%s
        enemies.cheat.level=%s
        secret.code.passphrase=%s
        secret.code.allowed=%s
        secret.code.lives=%s
    ||| % [params.enemies, params.lives, params.enemiesCheat, params.enemiesCheatLevel, 
           params.secretCodePassphrase, params.secretCodeAllowed, params.secretCodeLives],
  },
}