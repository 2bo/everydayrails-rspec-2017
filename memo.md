# Memo

[【rails】DEPRECATION WARNING: Leaving `ActiveRecord::ConnectionAdapters::SQLite3Adapter.represent_boolean_as_integer` ... を直す方法 - Qiita](https://qiita.com/hiruhiru/items/b17d11ad57610583171e)


[ルーティングにアクションを追加 - Ruby on Rails入門](https://www.javadrive.jp/rails/routing/index6.html)

[RailsのRoutingネストについて - Qiita](https://qiita.com/keisukegdk/items/beb5a62c17278c25c00d)

[Rails5へのRspec導入から実行確認まで - Qiita](https://qiita.com/ryouzi/items/de7336e6175530723b30)

[railsのnewとbuildの違い - Qiita](https://qiita.com/sukechansan/items/6bae532b4f678fdcf87d)
* 違いはない。newはbuildのエイリアス

[RSpecで「～ではないこと」を検証するときは expect(x).to_not 、または expect(x).not_to のどちらを使うべきか？ - Qiita](https://qiita.com/jnchito/items/1e6f8374e22dbd430e17)
* not_to to_notどちらでもよい。挙動は変わらない

[uniqueness: scope を使ったユニーク制約方法の解説 - Qiita](https://qiita.com/j-sunaga/items/d7f0e944baad6e56206c)

```ruby
class Project < ApplicationRecord
  # プロジェクト名は同一ユーザ内で一意(ユーザは自身の複数プロジェクトに同名をつけられない) 
  validates :name, presence: true, uniqueness: { scope: :user_id }

  belongs_to :owner, class_name: 'User', foreign_key: :user_id
```
uniqueness { scope: xxx } でxxx内で一意という制約をつける


[Railsでよく利用する、Scopeの使い方。 - Qiita](https://qiita.com/ngron/items/14a39ce62c9d30bf3ac3)
* scope :scope_name, ->(arg) { where(name: arg) }

beforeブロックは、describeやcontextブロックによってスコープが限定される
