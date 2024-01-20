#!/bin/bash

#генерация ip-адресов
generate_ip() {
  echo "$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256))"
}
random_ip=$(generate_ip)

#Генерация кодов ответов
generate_response_codes(){
  response_codes=("200" "201" "400" "401" "403" "404" "500" "501" "502" "503")
  random_index=$((RANDOM % ${#response_codes[@]})) # число делиться на остаток от деления от длины массива делитьс
  random_response_code= echo "${response_codes[$random_index]}"
}
response_code=$(generate_response_codes)

#Генератор методов
generate_methods() {
  methods=("GET" "POST" "PUT" "PATCH" "DELETE")
  random_index=$((RANDOM % ${#methods[@]}))
  method="${methods[$random_index]}"
  echo "$method"  
}


#Генератор URL запроса агента
url_gen() {
protocols=("http" "https")
domains=(
  "google.com"
  "youtube.com"
  "facebook.com"
  "baidu.com"
  "wikipedia.org"
  "yahoo.com"
  "reddit.com"
  "linkedin.com"
  "netflix.com"
  "amazon.com"
  "ebay.com"
  "twitter.com"
  "instagram.com"
  "microsoft.com"
  "stackoverflow.com"
  "github.com"
  "wordpress.org"
  "pinterest.com"
  "adobe.com"
  "craigslist.org"
  "dropbox.com"
  "apple.com"
  "tumblr.com"
  "paypal.com"
  "bbc.com"
  "nytimes.com"
  "cnn.com"
  "spotify.com"
  "nasa.gov"
  "stackoverflow.com"
)

paths=(
  "/home"
  "/products"
  "/blog"
  "/about-us"
  "/contact"
  "/services"
  "/portfolio"
  "/news"
  "/login"
  "/signup"
  "/profile"
  "/downloads"
  "/support"
  "/faq"
  "/events"
  "/gallery"
  "/terms"
  "/privacy"
  "/help"
  "/jobs"
  "/press"
  "/partners"
  "/testimonials"
  "/features"
  "/forum"
  "/videos"
  "/resources"
  "/sitemap"
  "/feedback"
  "/donate"
)

queries=(
  "q=search+term"
  "category=technology"
  "sort=popular"
  "filter=latest"
  "user=username"
  "id=12345"
  "page=1"
  "lang=en"
  "tag=web"
  "limit=10"
  "start_date=2023-01-01"
  "end_date=2023-12-31"
  "location=city"
  "color=blue"
  "size=medium"
  "price_range=50-100"
  "genre=rock"
  "author=author_name"
  "topic=programming"
  "brand=nike"
  "platform=android"
  "format=json"
  "view=grid"
  "source=website"
  "campaign=spring_sale"
  "country=us"
  "device=mobile"
  "event_type=concert"
)
  protocol="${protocols[RANDOM % ${#protocols[@]}]}"
  domain="${domains[RANDOM % ${#domains[@]}]}"
  path="${paths[RANDOM % ${#paths[@]}]}"
  query="${queries[RANDOM % ${#queries[@]}]}"
  echo "$protocol://$domain$path?$query"

}

url=$(url_gen)

# Генератор агентов 
generate_agent() {
  agents=("Mozilla" "Google Chrome" "Opera" "Safari" "Internet Explorer" "Internet Explorer" "Microsoft Edge" "Crawler and bot" "Library and net tool")
  random_index=$((RANDOM % ${#agents[@]}))
  agent="${agents[$random_index]}"
  echo "$agent"  
}
agent=$(generate_agent)


for i in {0..4}
do
  file="log_$((i+1))"
count=$((RANDOM % (1000 - 100 + 1) + 100))

  for ((j=1; j<=$count; j++))
  do
    random_ip=$(generate_ip)
    response_code=$(generate_response_codes)
    method=$(generate_methods)
    log_date="$(date -d "today -${i} days" "+%d/%b/%Y:%H:%M:%S %z")"
    url=$(url_gen)
    agent=$(generate_agent)
    line="$random_ip - - [$log_date] \"$method /path/to/resource HTTP/1.1\" $response_code 0 \"$url\" \"$agent\""
    echo "$line" >> "$file"
  done
done


# 200 - OK:
# Этот код говорит о том, что запрос клиента был успешно обработан сервером, и сервер возвращает запрошенные данные.
# 201 - Created:
# Этот код используется для сообщения о том, что сервер успешно создал новый ресурс в результате успешного выполнения POST-запроса клиента.
# 400 - Bad Request:
# Этот код указывает на то, что сервер не смог понять запрос из-за неверного синтаксиса или другой клиентской ошибки.
# 401 - Unauthorized:
# Этот код означает, что клиент не предоставил достаточных аутентификационных данных или аутентификация не удалась.
# 403 - Forbidden:
# Сервер понял запрос, но он отказывается его выполнить. Этот код часто используется для ограничения доступа к ресурсу.
# 404 - Not Found:
# Этот код сообщает о том, что сервер не может найти запрошенный ресурс. Это может быть вызвано неправильным URL или удалением ресурса.
# 500 - Internal Server Error:
# Этот код указывает на внутреннюю ошибку сервера, которая представляет собой неожиданное состояние, вызванное неправильной конфигурацией сервера или программной ошибкой.
# 501 - Not Implemented:
# Этот код говорит о том, что сервер не может выполнить запрос из-за отсутствия поддержки необходимой функциональности.
# 502 - Bad Gateway:
# Этот код указывает на то, что сервер, в роли шлюза или прокси, получил некорректный ответ от вышестоящего сервера при выполнении запроса.
# 503 - Service Unavailable:
# Этот код сообщает о том, что сервер временно не может обрабатывать запросы. Обычно это связано с перегрузкой сервера или проведением технических работ.
