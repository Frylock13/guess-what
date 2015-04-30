package controllers

import (
	"github.com/julienschmidt/httprouter"
	"html/template"
	"net/http"
)

var moviesTmpl = template.Must(template.New("index").ParseFiles("./templates/layouts/layout.tmpl", "./templates/movies/index.tmpl"))

func MoviesIndex(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
	moviesTmpl.ExecuteTemplate(w, "layout", "Movies") // Movies - title {{.}}
}