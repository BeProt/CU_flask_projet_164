"""Gestion des formulaires avec WTF pour les films
Fichier : gestion_films_wtf_forms.py
Auteur : OM 2022.04.11

"""
from flask_wtf import FlaskForm
from wtforms import StringField, IntegerField, DateField
from wtforms import SubmitField
from wtforms.validators import Length, InputRequired, NumberRange, DataRequired
from wtforms.validators import Regexp
from wtforms.widgets import TextArea


class FormWTFAddFilm(FlaskForm):
    """
        Dans le formulaire "genres_ajouter_wtf.html" on impose que le champ soit rempli.
        Définition d'un "bouton" submit avec un libellé personnalisé.
    """
    ProNom_regexp = ".*"
    ProNom_wtf = StringField("Nom du Produit", validators=[Length(min=2, max=2000, message="min 2 max 20"),
                                                               Regexp(ProNom_regexp,
                                                                      message="Pas de chiffres, de caractères "
                                                                              "spéciaux, "
                                                                              "d'espace à double, de double "
                                                                              "apostrophe, de double trait union")
                                                               ])
    ProPrixFR_regexp = ".*"
    ProPrixFR_wtf = StringField("Prix FR du Produit ", validators=[Length(min=0, max=2000, message="min 2 max 20"),
                                                               Regexp(ProPrixFR_regexp,
                                                                      message="Pas de chiffres, de caractères "
                                                                              "spéciaux, "
                                                                              "d'espace à double, de double "
                                                                              "apostrophe, de double trait union")
                                                               ])
    ProPrixCH_regexp = ".*"
    ProPrixCH_wtf = StringField("Prix CH du Produit ", validators=[Length(min=0, max=2000, message="min 2 max 20"),
                                                            Regexp(ProPrixCH_regexp,
                                                                   message="Pas de chiffres, de caractères "
                                                                           "spéciaux, "
                                                                           "d'espace à double, de double "
                                                                           "apostrophe, de double trait union")
                                                            ])

    submit = SubmitField("Enregistrer film")


class FormWTFUpdateFilm(FlaskForm):
    """
        Dans le formulaire "film_update_wtf.html" on impose que le champ soit rempli.
        Définition d'un "bouton" submit avec un libellé personnalisé.
    """

    ProNom_regxp = ".*"
    ProNom_wtf = StringField("Nom du Produit", validators=[Length(min=2, max=2000, message="min 2 max 20"),
                                                           Regexp(ProNom_regxp,
                                                                  message="Pas de chiffres, de caractères "
                                                                          "spéciaux, "
                                                                          "d'espace à double, de double "
                                                                          "apostrophe, de double trait union")
                                                           ])
    ProPrixFR_regexp = ".*"
    ProPrixFR_wtf = StringField("Prix FR du Produit ", validators=[Length(min=0, max=2000, message="min 2 max 20"),
                                                               Regexp(ProPrixFR_regexp,
                                                                      message="Pas de chiffres, de caractères "
                                                                              "spéciaux, "
                                                                              "d'espace à double, de double "
                                                                              "apostrophe, de double trait union")
                                                               ])
    ProPrixCH_regexp = ".*"
    ProPrixCH_wtf = StringField("Prix CH du Produit ", validators=[Length(min=0, max=2000, message="min 2 max 20"),
                                                                   Regexp(ProPrixCH_regexp,
                                                                          message="Pas de chiffres, de caractères "
                                                                                  "spéciaux, "
                                                                                  "d'espace à double, de double "
                                                                                  "apostrophe, de double trait union")
                                                                   ])

    submit = SubmitField("Update film")


class FormWTFDeleteFilm(FlaskForm):
    """
        Dans le formulaire "film_delete_wtf.html"

        ProNom_delete_wtf : Champ qui reçoit la valeur du film, lecture seule. (readonly=true)
        submit_btn_del : Bouton d'effacement "DEFINITIF".
        submit_btn_conf_del : Bouton de confirmation pour effacer un "film".
        submit_btn_annuler : Bouton qui permet d'afficher la table "t_produit".
    """
    ProNom_delete_wtf = StringField("Effacer ce film")
    submit_btn_del_film = SubmitField("Effacer film")
    submit_btn_conf_del_film = SubmitField("Etes-vous sur d'effacer ?")
    submit_btn_annuler = SubmitField("Annuler")
