# Vérifications de belgium_notebook.qmd
belgium <- parse_rmd("../../belgium_notebook.qmd",
  allow_incomplete = TRUE, parse_yaml = TRUE)

test_that("Le bloc-notes est-il compilé en un fichier final HTML ?", {
  expect_true(is_rendered("belgium_notebook.qmd"))
  # La version compilée HTML du carnet de notes est introuvable
  # Vous devez créer un rendu de votre bloc-notes Quarto (bouton 'Rendu')
  # Vérifiez aussi que ce rendu se réalise sans erreur, sinon, lisez le message
  # qui s'affiche dans l'onglet 'Travaux' et corrigez ce qui ne va pas dans
  # votre document avant de réaliser à nouveau un rendu HTML.
  # IL EST TRES IMPORTANT QUE VOTRE DOCUMENT COMPILE ! C'est tout de même le but
  # de votre analyse que d'obtenir le document final HTML.

  expect_true(is_rendered_current("belgium_notebook.qmd"))
  # La version compilée HTML du document Quarto existe, mais elle est ancienne
  # Vous avez modifié le document Quarto après avoir réalisé le rendu.
  # La version finale HTML n'est sans doute pas à jour. Recompilez la dernière
  # version de votre bloc-notes en cliquant sur le bouton 'Rendu' et vérifiez
  # que la conversion se fait sans erreur. Sinon, corrigez et regénérez le HTML.
})

test_that("La structure du document est-elle conservée ?", {
  expect_true(all(c("Introduction et but", "Matériel et méthodes",
    "Analyses", "Remaniement des données", "Description des données")
    %in% (rmd_node_sections(belgium) |> unlist() |> unique())))
  # Les sections (titres) attendues du bloc-notes ne sont pas toutes présentes
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs titres indispensables par rapport aux exercices ont disparu ou ont
  # été modifié. Vérifiez la structure du document par rapport à la version
  # d'origine dans le dépôt "template" du document (lien au début du fichier
  # README.md).

  expect_true(all(c("setup", "pop92", "pop10", "join", "mutate", "datafinal",
    "plot1", "plot2", "plot2comment", "plot3", "plot3comment")
    %in% rmd_node_label(belgium)))
  # Un ou plusieurs labels de chunks nécessaires à l'évaluation manquent
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs chunks indispensables par rapport aux exercices sont introuvables.
  # Vérifiez la structure du document par rapport à la version d'origine dans
  # le dépôt "template" du document (lien au début du fichier README.md).

  expect_true(any(duplicated(rmd_node_label(belgium))))
  # Un ou plusieurs labels de chunks sont dupliqués
  # Les labels de chunks doivent absolument être uniques. Vous ne pouvez pas
  # avoir deux chunks qui portent le même label. Vérifiez et modifiez le label
  # dupliqué pour respecter cette règle. Comme les chunks et leurs labels sont
  # imposés dans ce document cadré, cette situation ne devrait pas se produire.
  # Vous avez peut-être involontairement dupliqué une partie du document ?
})

test_that("L'entête YAML a-t-il été complété ?", {
  expect_true(belgium[[1]]$author != "___")
  expect_true(!grepl("__", belgium[[1]]$author))
  expect_true(grepl("^[^_]....+", belgium[[1]]$author))
  # Le nom d'auteur n'est pas complété ou de manière incorrecte dans l'entête
  # Vous devez indiquer votre nom dans l'entête YAML à la place de "___" et
  # éliminer les caractères '_' par la même occasion.

  expect_true(grepl("[a-z]", belgium[[1]]$author))
  # Aucune lettre minuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en majuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.

  expect_true(grepl("[A-Z]", belgium[[1]]$author))
  # Aucune lettre majuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en minuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.
})

test_that("Chunks 'pop92' : importation et combinaison des données de 1992 à 2009", {
  expect_true(is_identical_to_ref("pop92", "names"))
  # Le nom des colonnes de l'objet 'pop_10' est incorrect.
  # Posez-vous la question suivante :  Avez-vous ajouté des colonnes 
  # (sbind_cols) ou des lignes (sbind_rows) ?
  # Dans notre cas, vous devriez avoir un tableau plus long que large.

  expect_true(is_identical_to_ref("pop92", "classes"))
  # La nature des variables (classe) dans le tableau `pop_10` est incorrecte
  # Vérifiez le chunk d'importation des données `import`.

  expect_true(is_identical_to_ref("pop92", "nrow"))
  # Le nombre de lignes dans le tableau `pop_10` est incorrect
  # Avez-vous ajouté des colonnes (sbind_cols) ou des lignes (sbind_rows) ?
  # Dans notre cas, vous devriez avoir un tableau de 36 lignes.
})

test_that("Chunks 'pop10' : importation et combinaison des données de 2010 à 2023", {
  expect_true(is_identical_to_ref("pop10", "names"))
  # Le nom des colonnes de l'objet 'pop_10' est incorrect.
  # Posez-vous la question suivante :  Avez-vous ajouté des colonnes 
  # (sbind_cols) ou des lignes (sbind_rows) ?
  # Dans notre cas, vous devriez avoir un tableau plus long que large.
  
  expect_true(is_identical_to_ref("pop10", "classes"))
  # La nature des variables (classe) dans le tableau `pop_10` est incorrecte
  
  expect_true(is_identical_to_ref("pop10", "nrow"))
  # Le nombre de lignes dans le tableau `pop_10` est incorrect
  # Avez-vous ajouté des colonnes (sbind_cols) ou des lignes (sbind_rows) ?
  # Dans notre cas, vous devriez avoir un tableau de 36 lignes.
})

test_that("Chunks 'join' : obtenir un tableau unique des observations de 1992 à 2023", {
  expect_true(is_identical_to_ref("join", "names"))
  # Le nom des colonnes de l'objet 'pop' est incorrect.
  # Avez vous bien combiner le tableau pop_92 avec pop_10 ? Avez-vous de
  # doublons dans votre tableau ?
  
  expect_true(is_identical_to_ref("join", "classes"))
  # La nature des variables (classe) dans le tableau `pop` est incorrecte
  # La combinaidson des deux tableaux est à revoir.
  
  expect_true(is_identical_to_ref("pop10", "nrow"))
  # Le nombre de lignes dans le tableau `pop` est incorrect
  # Dans le cas présent, vous devriez avoir un tableau de 1152 lignes et 6
  # colonnes.
})

test_that("Chunks 'mutate' : Calcul de nouvelles variables", {
  expect_true(is_identical_to_ref("mutate", "names"))
  # Le nom des colonnes de l'objet 'pop' est incorrecte.
  # Ces noms doivent être identique à ceux que vous aviez au chunk précédent
  # 'join'.
  
  expect_true(is_identical_to_ref("join", "classes"))
  # La nature des variables (classe) dans le tableau `pop` est incorrecte.
  # Vérifier la variable 'year' en particulier. Assurez-vous que cette variable 
  # est bien numérique.
})

test_that("Chunks 'plot1' : reproduction à l'identique du premier graphique (nuage de points) ", {
  expect_true(is_identical_to_ref("plot1"))
  # Le nuage de points n'est pas celui attendu.
  # Observez attentivement le graphique à reproduire en partant de l'objet 'pop'
})

test_that("Chunks 'plot2' : reproduction à l'identique du second graphique (nuage de points) et interpétation", {
  expect_true(is_identical_to_ref("plot2"))
  # Le nuage de points n'est pas celui attendu.
  # Observez attentivement le graphique à reproduire en partant de l'objet 'pop'
  
  expect_true(is_identical_to_ref("plot2comment"))
  # L'interprétation du graphique est (partiellement) fausse
  # Vous devez cochez les phrases qui décrivent le modèle d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'plot3' : reproduction à l'identique du troisième graphique (graphique en barres) et interpétation", {
  expect_true(is_identical_to_ref("plot3"))
  # Le graphique en barres n'est pas celui attendu.
  # Observez attentivement le graphique à reproduire en partant de l'objet 'pop'
  
  expect_true(is_identical_to_ref("plot3comment"))
  # L'interprétation du graphique est (partiellement) fausse
  # Vous devez cochez les phrases qui décrivent le modèle d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})
