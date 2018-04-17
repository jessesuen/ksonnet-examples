## Parameterized ConfigMap
This example builds on the [ConfigMap](../configmap/README.md) example and demonstrates how a
ConfigMap might be parameterized per environment. The configmap values are defined in 
`components/params.libsonnet`, and the `components/example-configmap.jsonnet` imports the parameters
and references the value. Two styles of Jsonnet string formatting are demonstrated. The 
`game.properties` uses printf style of formatting of ordered variables, where `ui.properties` 
references of individual map keys in the params map.

```
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

    "ui.properties": |||
        color.good=%(colorGood)s
        color.bad=%(colorBad)s
        allow.textmode=%(allowTextMode)s
        how.nice.to.look=%(howNiceToLook)s
    ||| % params,
  },
}
```

To run this example, run:
```
ks show default
```
