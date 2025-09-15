# ndlocr_cli(NDLOCR(ver.2.1))をMacBookで動かすパッチ
使い方は、オリジナルの[README](README.org.md)を参照ください

# 環境構築
brewを使って、コンパイルできる環境を構築してください。
追加で以下のモジュールが必要です。
```
brew install swig
```

## virtual環境を作成する
適当な方法で、python3.11仮想環境を作成します。
ここでは、minicondaを使用します。
```
conda create -n ndlocr python=3.11
conda activate ndlocr
```

## 依存パッケージのインストール
仮想環境内で、以下のコマンドを実行してください。
```
bash prepare.sh
```

# 後はドキュメント通りに実行してください
ただし、MPSで実行できないopが混じっているので、以下のようにfallback有りで実行してください。
```
PYTORCH_ENABLE_MPS_FALLBACK=1 python main.py infer image.png output_dir -s f
```
