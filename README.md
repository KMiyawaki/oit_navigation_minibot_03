# Minibot v3

## 必要なソフト

```shell
$ sudo apt install ros-melodic-rplidar-ros 
$ sudo apt install ros-melodic-teleop-twist-keyboard
$ sudo apt install ros-melodic-key-teleop
$ sudo apt install ros-melodic-urg-node
$ sudo apt install xterm
```

### デバイスだけの起動

```shell
$ roscd oit_navigation_minibot_03/launch/real
```

### テレオペの起動

```shell
$ roscd oit_navigation_minibot_03/launch/real
```

デフォルトでジョイスティック（WSLの場合はキーボード）操作が可能になっている。  
キーボード操作時はXtermのコンソールウィンドウが開くので、そのウィンドウをアクティブにし、矢印キーで動かせる。

## SLAMによる地図作成

下記コマンドでRVizが開き、地図作成が始まる。

```shell
$ roscd oit_navigation_minibot_03/launch/real
```

作成が終わったらRVizや`asahi_mapping.sh`を**終了させずに**別ターミナルで以下のコマンドを実行して地図を保存する。

```shell
$ roscd oit_navigation_minibot_03/maps
$ rosrun map_server map_saver -f test # test の部分は任意のマップ名をつける。
[ INFO] [1615598383.151895509]: Waiting for the map
[ INFO] [1615598383.434767477]: Received a 480 X 736 map @ 0.050 m/pix
[ INFO] [1615598383.434929931]: Writing map occupancy data to sample_01.pgm
[ INFO] [1615598383.449962167]: Writing map occupancy data to sample_01.yaml
[ INFO] [1615598383.450234503]: Done
```

保存ができたら、`asahi_mapping.sh`を終了させてよい。その後地図ファイルの有無を確認する。

```shell
$ roscd oit_navigation_minibot_03/maps
$ ls
test.pgm  test.yaml
```

## ナビゲーション

下記コマンドで、保存した地図を使いナビゲーションをする。

```shell
$ roscd oit_navigation_minibot_03/launch/real
```

自己位置推定、ゴール指定方法はこれまで通り。

## 作成したマップをシミュレータで使う

```shell
$ roscd oit_navigation_minibot_03/maps
$ ls test* # マップのファイルを確認
test.pgm  test.yaml
$ ./make_simulation_world.sh test
Add black border into test.pgm... 
Generated test_border.png
$ ls test* # マップとシミュレータのファイルを確認
test.pgm  test.world  test.yaml  test_border.png
$ roscd oit_navigation_minibot_03/launch/simulation
$ ./navigation.sh ../../maps/test.yaml # 任意の自作マップを指定する。
```
