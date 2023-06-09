"""
    Fichier : gestion_genres_wtf_forms.py
    Auteur : OM 2021.03.22
    Gestion des formulaires avec WTF
"""
from flask_wtf import FlaskForm
from wtforms import StringField, DateField
from wtforms import SubmitField
from wtforms.validators import Length, InputRequired, DataRequired
from wtforms.validators import Regexp


class FormWTFAjouterEntrepot(FlaskForm):
    """
        Dans le formulaire "genres_ajouter_wtf.html" on impose que le champ soit rempli.
        Définition d'un "bouton" submit avec un libellé personnalisé.
    """
    IDLo_regexp = "^([0-9][A-Z]|[a-zÀ-ÖØ-öø-ÿ])[A-Za-zÀ-ÖØ-öø-ÿ]*['\- ]?[A-Za-zÀ-ÖØ-öø-ÿ]+$"
    IDLo_wtf = StringField("Clavioter l'ID de la localité ", validators=[Length(min=0, max=20, message="min 0 max 20"),
                                                                     Regexp(IDLo_regexp,
                                                                            message="Pas de chiffres, de caractères "
                                                                                    "spéciaux, "
                                                                                    "d'espace à double, de double "
                                                                                    "apostrophe, de double trait union")
                                                                     ])

    EntrepotNom_regexp = "^([A-Z]|[a-zÀ-ÖØ-öø-ÿ])[A-Za-zÀ-ÖØ-öø-ÿ]*['\- ]?[A-Za-zÀ-ÖØ-öø-ÿ]+$"
    EntrepotNom_wtf = StringField("Clavioter l'Entrepôt' ", validators=[Length(min=2, max=20, message="min 2 max 20"),
                                                                   Regexp(EntrepotNom_regexp,
                                                                          message="Pas de chiffres, de caractères "
                                                                                  "spéciaux, "
                                                                                  "d'espace à double, de double "
                                                                                  "apostrophe, de double trait union")
                                                                   ])
    EntrepotAdresse_regexp = "^([A-Z]|[a-zÀ-ÖØ-öø-ÿ])[A-Za-zÀ-ÖØ-öø-ÿ]*['\- ]?[A-Za-zÀ-ÖØ-öø-ÿ]+$"
    EntrepotAdresse_wtf = StringField("Clavioter l'adresse de l'Entrepôt ", validators=[Length(min=2, max=20, message="min 2 max 20"),
                                                                     Regexp(EntrepotAdresse_regexp,
                                                                            message="Pas de chiffres, de caractères "
                                                                                    "spéciaux, "
                                                                                    "d'espace à double, de double "
                                                                                    "apostrophe, de double trait union")
                                                                     ])
    submit = SubmitField("Enregistrer genre")


class FormWTFUpdateEntrepot(FlaskForm):
    """
        Dans le formulaire "genre_update_wtf.html" on impose que le champ soit rempli.
        Définition d'un "bouton" submit avec un libellé personnalisé.
    """
    nom_Entrepot_update_regexp = "^([A-Z]|[a-zÀ-ÖØ-öø-ÿ])[A-Za-zÀ-ÖØ-öø-ÿ]*['\- ]?[A-Za-zÀ-ÖØ-öø-ÿ]+$"
    nom_Entrepot_update_wtf = StringField("Clavioter l'Entrepôt ", validators=[Length(min=2, max=20, message="min 2 max 20"),
                                                                          Regexp(nom_Entrepot_update_regexp,
                                                                                 message="Pas de chiffres, de "
                                                                                         "caractères "
                                                                                         "spéciaux, "
                                                                                         "d'espace à double, de double "
                                                                                         "apostrophe, de double trait "
                                                                                         "union")
                                                                          ])
    nom_Adresse_update_regexp = "^([A-Z]|[a-zÀ-ÖØ-öø-ÿ])[A-Za-zÀ-ÖØ-öø-ÿ]*['\- ]?[A-Za-zÀ-ÖØ-öø-ÿ]+$"
    nom_Adresse_update_wtf = StringField("Clavioter l'Entrepôt ", validators=[Length(min=2, max=20, message="min 2 max 20"),
                                                                          Regexp(nom_Adresse_update_regexp,
                                                                                 message="Pas de chiffres, de "
                                                                                         "caractères "
                                                                                         "spéciaux, "
                                                                                         "d'espace à double, de double "
                                                                                         "apostrophe, de double trait "
                                                                                         "union")
                                                                          ])
    # date_genre_wtf_essai = DateField("Essai date", validators=[InputRequired("Date obligatoire"),...
    #                                                            DataRequired("Date non valide")])
    submit = SubmitField("Update genre")


class FormWTFDeleteEntrepot(FlaskForm):
    """
        Dans le formulaire "genre_delete_wtf.html"

        nom_genre_delete_wtf : Champ qui reçoit la valeur du genre, lecture seule. (readonly=true)
        submit_btn_del : Bouton d'effacement "DEFINITIF".
        submit_btn_conf_del : Bouton de confirmation pour effacer un "genre".
        submit_btn_annuler : Bouton qui permet d'afficher la table "t_entrepot".
    """
    nom_genre_delete_wtf = StringField("Effacer ce genre")
    submit_btn_del = SubmitField("Effacer genre")
    submit_btn_conf_del = SubmitField("Etes-vous sur d'effacer ?")
    submit_btn_annuler = SubmitField("Annuler")
