"""Gestion des "routes" FLASK et des données pour les categorie.
Fichier : gestion_categorie_crud.py
Auteur : OM 2021.03.16
"""

from pathlib import Path

from flask import redirect
from flask import request
from flask import session
from flask import url_for


from APP_FILMS_164 import app
from APP_FILMS_164.database.database_tools import DBconnection
from APP_FILMS_164.erreurs.exceptions import *
from APP_FILMS_164.categorie.gestion_categorie_wtf_forms import FormWTFAjouterCategorie
from APP_FILMS_164.categorie.gestion_categorie_wtf_forms import FormWTFDeleteCategorie
from APP_FILMS_164.categorie.gestion_categorie_wtf_forms import FormWTFUpdateCategorie

"""
    Auteur : OM 2021.03.16
    Définition d'une "route" /categorie_afficher
    
    Test : ex : http://127.0.0.1:5575/categorie_afficher
    
    Paramètres : order_by : ASC : Ascendant, DESC : Descendant
                IDCate_sel = 0 >> tous les categorie.
                IDCate_sel = "n" affiche la categorie dont l'id est "n"
"""


@app.route("/categorie_afficher/<string:order_by>/<int:IDCate_sel>", methods=['GET', 'POST'])
def categorie_afficher(order_by, IDCate_sel):
    if request.method == "GET":
        try:
            with DBconnection() as mc_afficher:
                if order_by == "ASC" and IDCate_sel == 0:
                    strsql_categorie_afficher = """SELECT * FROM t_categorie ORDER BY IDCate ASC"""
                    mc_afficher.execute(strsql_categorie_afficher)

                elif order_by == "ASC":

                    valeur_IDCate_selected_dictionnaire = {"value_IDCate_selected": IDCate_sel}
                    strsql_categorie_afficher = """Select * From t_categorie WHERE IDCate = %(value_IDCate_selected)s"""

                    mc_afficher.execute(strsql_categorie_afficher, valeur_IDCate_selected_dictionnaire)
                else:
                    strsql_categorie_afficher = """SELECT * FROM t_categorie ORDER BY IDCate DESC"""

                    mc_afficher.execute(strsql_categorie_afficher)

                data_categorie = mc_afficher.fetchall()

                print("data_categorie ", data_categorie, " Type : ", type(data_categorie))

                # Différencier les messages si la table est vide.
                if not data_categorie and IDCate_sel == 0:
                    flash("""La table "t_categorie" est vide. !!""", "warning")
                elif not data_categorie and IDCate_sel > 0:
                    # Si l'utilisateur change l'IDCate dans l'URL et que le categorie n'existe pas,
                    flash(f"La categorie demandé n'existe pas !!", "warning")
                else:
                    # Dans tous les autres cas, c'est que la table "t_categorie" est vide.
                    # OM 2020.04.09 La ligne ci-dessous permet de donner un sentiment rassurant aux utilisateurs.
                    flash(f"Voici les categorie!!", "success")

        except Exception as Exception_categorie_afficher:
            raise ExceptionGenresAfficher(f"fichier : {Path(__file__).name}  ;  "
                                          f"{categorie_afficher.__name__} ; "
                                          f"{Exception_categorie_afficher}")

    # Envoie la page "HTML" au serveur.
    return render_template("categorie/categorie_afficher.html", data=data_categorie)


"""
    Auteur : OM 2021.03.22
    Définition d'une "route" /categorie_ajouter
    
    Test : ex : http://127.0.0.1:5575/categorie_ajouter
    
    Paramètres : sans
    
    But : Ajouter un categorie pour un film
    
    Remarque :  Dans le champ "name_categorie_html" du formulaire "categorie/categorie_ajouter.html",
                le contrôle de la saisie s'effectue ici en Python.
                On transforme la saisie en minuscules.
                On ne doit pas accepter des valeurs vides, des valeurs avec des chiffres,
                des valeurs avec des caractères qui ne sont pas des lettres.
                Pour comprendre [A-Za-zÀ-ÖØ-öø-ÿ] il faut se reporter à la table ASCII https://www.ascii-code.com/
                Accepte le trait d'union ou l'apostrophe, et l'espace entre deux mots, mais pas plus d'une occurence.
"""


@app.route("/categorie_ajouter", methods=['GET', 'POST'])
def categorie_ajouter_wtf():
    form = FormWTFAjouterCategorie()
    if request.method == "POST":
        try:
            if form.validate_on_submit():
                CateNom_wtf = form.CateNom_wtf.data
                CateNom = CateNom_wtf.lower()

                valeurs_insertion_dictionnaire = {"value_CateNom": CateNom_wtf}
                print("valeurs_insertion_dictionnaire ", valeurs_insertion_dictionnaire)

                strsql_insert_categorie = """INSERT INTO t_categorie (IDCate,CateNom) VALUES (NULL, %(value_CateNom)s) """
                with DBconnection() as mconn_bd:
                    mconn_bd.execute(strsql_insert_categorie, valeurs_insertion_dictionnaire)


                flash(f"Données insérées !!", "success")
                print(f"Données insérées !!")

                # Pour afficher et constater l'insertion de la valeur, on affiche en ordre inverse. (DESC)
                return redirect(url_for('categorie_afficher', order_by='DESC', IDCate_sel=0))



        except Exception as Exception_categorie_ajouter_wtf:
            raise ExceptionGenresAjouterWtf(f"fichier : {Path(__file__).name}  ;  "
                                            f"{categorie_ajouter_wtf.__name__} ; "
                                            f"{Exception_categorie_ajouter_wtf}")

    return render_template("categorie/categorie_ajouter_wtf.html", form=form)




"""
    Auteur : OM 2021.03.29
    Définition d'une "route" /categorie_update
    
    Test : ex cliquer sur le menu "categorie" puis cliquer sur le bouton "EDIT" d'un "categorie"
    
    Paramètres : sans
    
    But : Editer(update) un categorie qui a été sélectionné dans le formulaire "categorie_afficher.html"
    
    Remarque :  Dans le champ "name_categorie_update_wtf" du formulaire "categorie/categorie_update_wtf.html",
                le contrôle de la saisie s'effectue ici en Python.
                On transforme la saisie en minuscules.
                On ne doit pas accepter des valeurs vides, des valeurs avec des chiffres,
                des valeurs avec des caractères qui ne sont pas des lettres.
                Pour comprendre [A-Za-zÀ-ÖØ-öø-ÿ] il faut se reporter à la table ASCII https://www.ascii-code.com/
                Accepte le trait d'union ou l'apostrophe, et l'espace entre deux mots, mais pas plus d'une occurence.
"""


@app.route("/categorie_update", methods=['GET', 'POST'])
def categorie_update_wtf():
    # L'utilisateur vient de cliquer sur le bouton "EDIT". Récupère la valeur de "IDCate"
    IDCate_update = request.values['IDCate_btn_edit_html']

    # Objet formulaire pour l'UPDATE
    form_update = FormWTFUpdateCategorie()
    try:
        # 2023.05.14 OM S'il y a des listes déroulantes dans le formulaire
        # La validation pose quelques problèmes
        if request.method == "POST" and form_update.submit.data:
            # Récupèrer la valeur du champ depuis "categorie_update_wtf.html" après avoir cliqué sur "SUBMIT".
            # Puis la convertir en lettres minuscules.

            CateNom_update = form_update.CateNom_update_wtf.data


            valeur_update_dictionnaire = {"value_IDCate": IDCate_update,
                                          "value_CateNom": CateNom_update,

                                          }
            print("valeur_update_dictionnaire ", valeur_update_dictionnaire)

            str_sql_update_IDCate = """UPDATE t_categorie SET CateNom = %(value_CateNom)s 
                      WHERE IDCate = %(value_IDCate)s """
            with DBconnection() as mconn_bd:
                mconn_bd.execute(str_sql_update_IDCate, valeur_update_dictionnaire)

            flash(f"Donnée mise à jour !!", "success")
            print(f"Donnée mise à jour !!")

            # afficher et constater que la donnée est mise à jour.
            # Affiche seulement la valeur modifiée, "ASC" et l'"IDCate_update"
            return redirect(url_for('categorie_afficher', order_by="ASC", IDCate_sel=IDCate_update))
        elif request.method == "GET":
            # Opération sur la BD pour récupérer "IDCate" et "intitule_categorie" de la "t_categorie"
            str_sql_IDCate = "SELECT IDCate, CateNom FROM t_categorie " \
                               "WHERE IDCate = %(value_IDCate)s"
            valeur_select_dictionnaire = {"value_IDCate": IDCate_update}
            with DBconnection() as mybd_conn:
                mybd_conn.execute(str_sql_IDCate, valeur_select_dictionnaire)
            # Une seule valeur est suffisante "fetchone()", vu qu'il n'y a qu'un seul champ "name categorie" pour l'UPDATE
            date_name_categorie = mybd_conn.fetchone()
            print("date_name_categorie ", date_name_categorie, " type ", type(date_name_categorie), " categorie ",
                  date_name_categorie["CateNom"])

            # Afficher la valeur sélectionnée dans les champs du formulaire "categorie_update_wtf.html"
            form_update.CateNom_update_wtf.data = date_name_categorie["CateNom"]



    except Exception as Exception_categorie_update_wtf:
        raise ExceptionGenreUpdateWtf(f"fichier : {Path(__file__).name}  ;  "
                                      f"{categorie_update_wtf.__name__} ; "
                                      f"{Exception_categorie_update_wtf}")

    return render_template("categorie/categorie_update_wtf.html", form_update=form_update)


"""
    Auteur : OM 2021.04.08
    Définition d'une "route" /categorie_delete
    
    Test : ex. cliquer sur le menu "categorie" puis cliquer sur le bouton "DELETE" d'un "categorie"
    
    Paramètres : sans
    
    But : Effacer(delete) un categorie qui a été sélectionné dans le formulaire "categorie_afficher.html"
    
    Remarque :  Dans le champ "name_categorie_delete_wtf" du formulaire "categorie/categorie_delete_wtf.html",
                le contrôle de la saisie est désactivée. On doit simplement cliquer sur "DELETE"
"""


@app.route("/categorie_delete", methods=['GET', 'POST'])
def categorie_delete_wtf():
    data_films_attribue_categorie_delete = None
    btn_submit_del = None
    # L'utilisateur vient de cliquer sur le bouton "DELETE". Récupère la valeur de "IDCate"
    IDCate_delete = request.values['IDCate_btn_delete_html']

    # Objet formulaire pour effacer le categorie sélectionné.
    form_delete = FormWTFDeleteCategorie()
    try:
        print(" on submit ", form_delete.validate_on_submit())
        if request.method == "POST" and form_delete.validate_on_submit():

            if form_delete.submit_btn_annuler.data:
                return redirect(url_for("categorie_afficher", order_by="ASC", IDCate_sel=0))

            if form_delete.submit_btn_conf_del.data:
                # Récupère les données afin d'afficher à nouveau
                # le formulaire "categorie/categorie_delete_wtf.html" lorsque le bouton "Etes-vous sur d'effacer ?" est cliqué.
                data_films_attribue_categorie_delete = session['data_films_attribue_categorie_delete']
                print("data_films_attribue_categorie_delete ", data_films_attribue_categorie_delete)

                flash(f"Effacer le categorie de façon définitive de la BD !!!", "On s'en fou non?")
                # L'utilisateur vient de cliquer sur le bouton de confirmation pour effacer...
                # On affiche le bouton "Effacer categorie" qui va irrémédiablement EFFACER le categorie
                btn_submit_del = True

            if form_delete.submit_btn_del.data:
                valeur_delete_dictionnaire = {"value_IDCate": IDCate_delete}
                print("valeur_delete_dictionnaire ", valeur_delete_dictionnaire)


                str_sql_delete_idcategorie = """DELETE FROM t_categorie WHERE IDCate = %(value_IDCate)s"""


                # Manière brutale d'effacer d'abord la "fk_categorie", même si elle n'existe pas dans la "t_categorie_film"
                # Ensuite on peut effacer le categorie vu qu'il n'est plus "lié" (INNODB) dans la "t_categorie_film"
                with DBconnection() as mconn_bd:
                    mconn_bd.execute(str_sql_delete_idcategorie, valeur_delete_dictionnaire)
                    mconn_bd.execute(str_sql_delete_idcategorie, valeur_delete_dictionnaire)

                flash(f"categorie définitivement effacé !!", "success")
                print(f"categorie définitivement effacé !!")

                # afficher les données
                return redirect(url_for('categorie_afficher', order_by="ASC", IDCate_sel=0))

        if request.method == "GET":
            valeur_select_dictionnaire = {"value_IDCate": IDCate_delete}
            print(IDCate_delete, type(IDCate_delete))

            # Requête qui affiche tous les films_categorie qui ont le categorie que l'utilisateur veut effacer
            str_sql_categorie_films_delete = """SELECT *FROM t_categorie
                                                        Where IDCate = %(value_IDCate)s"""


            with DBconnection() as mydb_conn:
                mydb_conn.execute(str_sql_categorie_films_delete, valeur_select_dictionnaire)
                data_films_attribue_categorie_delete = mydb_conn.fetchall()
                print("data_films_CateNom_delete...", data_films_attribue_categorie_delete)

                # Nécessaire pour mémoriser les données afin d'afficher à nouveau
                # le formulaire "categorie/categorie_delete_wtf.html" lorsque le bouton "Etes-vous sur d'effacer ?" est cliqué.
                session['data_films_attribue_categorie_delete'] = data_films_attribue_categorie_delete

                # Opération sur la BD pour récupérer "IDCate" et "intitule_categorie" de la "t_categorie"
                str_sql_IDCate = "SELECT IDCate, CateNom FROM t_categorie WHERE IDCate = %(value_IDCate)s"

                mydb_conn.execute(str_sql_IDCate, valeur_select_dictionnaire)
                # Une seule valeur est suffisante "fetchone()",
                # vu qu'il n'y a qu'un seul champ "name categorie" pour l'action DELETE
                data_CateNom = mydb_conn.fetchone()
                print("data_CateNom ", data_CateNom, " type ", type(data_CateNom), " categorie ",
                      data_CateNom["CateNom"])

            # Afficher la valeur sélectionnée dans le champ du formulaire "categorie_delete_wtf.html"
            form_delete.CateNom_delete_wtf.data = data_CateNom["CateNom"]

            # Le bouton pour l'action "DELETE" dans le form. "categorie_delete_wtf.html" est caché.
            btn_submit_del = False

    except Exception as Exception_categorie_delete_wtf:
        raise ExceptionGenreDeleteWtf(f"fichier : {Path(__file__).name}  ;  "
                                      f"{categorie_delete_wtf.__name__} ; "
                                      f"{Exception_categorie_delete_wtf}")

    return render_template("categorie/categorie_delete_wtf.html",
                           form_delete=form_delete,
                           btn_submit_del=btn_submit_del,
                           data_categorie_associes=data_films_attribue_categorie_delete)