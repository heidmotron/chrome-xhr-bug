package main

import (
  "net/http"
  "time"
  "encoding/json"
  "html/template"
)

var tmpl, _ = template.ParseFiles("index.html")

func loadIndex(res http.ResponseWriter, req *http.Request) {
  tmpl.Execute(res, nil)
}

func loadJSON(res http.ResponseWriter, req *http.Request) {
  time.Sleep(1000 * time.Millisecond)
  enc := json.NewEncoder(res)
  var j map[string]string
  j = make(map[string]string)
  j["hello"] = "world"
  res.Header().Add("Content-Type", "application/json")
  enc.Encode(&j)
}

func main() {
  http.HandleFunc("/", loadIndex)
  http.HandleFunc("/a.json", loadJSON)
  http.ListenAndServe(":8002", nil)
}