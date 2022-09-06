## Target, Scheme, Build Configuration とかの話

### Target

- ビルド時の設定リスト
- Build Settingは、Build configurationごとに、値を変えられる
- ~Info.plistは1Targetに対して一つ？~

### Scheme

- ビルド（Build/Test/Analyze/Profile/Archive）する際のTargetとBuild　Configを組み合わせたもの
- デフォルトで一つ生成されている
- スキームを選択して、下記のビルド

<img width="270" alt="スクリーンショット 2022-09-06 9 03 54" src="https://user-images.githubusercontent.com/16571394/188522224-68c9a1bb-8e91-4e69-a6da-cae1f8d613d1.png">


### Build Configuration

- 環境設定のコンテキスト
- デフォルトではDebug/Releaseが生成されている

<img width="885" alt="スクリーンショット 2022-09-06 8 55 13" src="https://user-images.githubusercontent.com/16571394/188521777-c82555fe-a8a7-4eb3-878e-3204435360b4.png">

### 環境設定

- Targetを複数作成して、環境設定することもできなくはないが、生成される成果物的にSchemeの管理でよさそう
- 最低限、本番/Stgで分ける場合は下記のような感じか

#### Build Config

- Debug
- Release
- DebugStg
- AdhocStg

#### 本番スキーム

|Target|Build Config|
|---|---|
|A Target|Run: Debug<br>Archive: Release |

※ArchiveのReleaseで、QAの本番確認も兼ねる感じ

#### Stgスキーム

|Target|Build Config|
|---|---|
|A Target|Run: DebugStg<br>Archive: AdhocStg |
