# README
## ðãªãã¸ããªã®è¨­å®
- ãã®ãªãã¸ããªãã³ãã¼ãã¦å¥ã®ãªãã¸ããªãä½æããæ¹æ³
  - https://github.com/shotaimai66/readme-develop/blob/main/%E3%83%AA%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%81%AE%E3%82%B3%E3%83%94%E3%83%BC%E6%96%B9%E6%B3%95.md

- mainãã©ã³ãã®ä¿è­·è¨­å®ã¨ã¬ãã¥ã¼å¿é è¨­å®æ¹æ³
  - https://github.com/shotaimai66/readme-develop/blob/main/%E3%83%96%E3%83%A9%E3%83%B3%E3%83%81%E3%81%AE%E4%BF%9D%E8%AD%B7%E8%A8%AD%E5%AE%9A%E3%81%A8%E3%83%AC%E3%83%93%E3%83%A5%E3%83%BC%E5%BF%85%E9%A0%88%E8%A8%AD%E5%AE%9A.md

## ðherokuã¸ã®ããã­ã¤æ¹æ³
- https://github.com/shotaimai66/readme-develop/blob/main/rails7/rails7-heroku-deploy.md
## ç°å¢ã»ãã
- ruby 3.1.1
- rails 7.0.2.2
- docker
- mysql 8.0
## ç°å¢æ§ç¯
- ã¤ã¡ã¼ã¸ã®ãã«ã
```
docker-compose build
```
- ã¢ã»ããã®ã»ããã£ã³ã°
```
docker-compose run --rm app rails assets:precompile
```
- ã³ã³ããèµ·å
```
docker-compose up
```
- db(mysql)ã®ä½æã¨ãã¹ããã¼ã¿æå¥
```
docker-compose run --rm app rails db:setup
```
- ãã©ã¦ã¶ãç¢ºèªãã(ä»¥ä¸ã®ãããªã­ã°ã¤ã³ç»é¢ãè¡¨ç¤ºããããOKï¼)
```
http://localhost:3000
```
![picture 1](images/652398abbeae3f1f0ca51eb31ae217aebdb4f9be9e8dc2de80c205c8954a1ec1.png)


## éçºã³ãã³ã
- railsã§binding.irbãä½¿ãæãªã©ã¯ä»¥ä¸ã®ã³ãã³ãã§èµ·åããã®ãè¯ãï¼ãã¤ãããã§èµ·åã§ãè¯ãããï¼
```
bin/debug
```
- å¨ä½ãã¹ãå®è¡
```
bin/test
```
- appã³ã³ããåã§ã³ãã³ãå®è¡(`docker-compose run --rm app`ã¨åç¾©)
```
bin/docker/bundle/exec
```
- railsã³ãã³ã
```
bin/docker/bundle/exec rails db:migrate
```
- bundle install
```
bin/docker/bundle/exec bundle install
```
- ç¹å®ã®ãã¡ã¤ã«ããã¹ãå®è¡
```
bin/docker/bundle/exec rspec specãã¡ã¤ã«ã®ç¸å¯¾path
```
- æ§æãã§ãã¯
```
bin/docker/bundle/exec rubocop
```
- erdçæ
```
bin/docker/bundle/exec erd
```
