# Bibloteke
library(readr)
library(tidyverse)
library(ggplot2)

# Učitavanje podataka
library_books_read <- read.csv("library_books_read.csv")

# Provera podataka
glimpse(library_books_read)


# KREIRANJE REGRESIONOG MODELA
# Podela podataka za treniranje i testiranje modela
set.seed(123)
n <- nrow(library_books_read)
train_index <- sample(1:n, size = 0.8 * n)
train_data <- library_books_read[train_index, ]
test_data <- library_books_read[-train_index, ]

# Kreiranje modela
model <- lm(books_read ~  member_age + membership_years, data = train_data)

# Pregled rezimea modela
summary(model)

# Testiranje modela da vidimo kako reaguje na poznate slučajeve
predictions <- predict(model, newdata = test_data)
head(predictions)

# Provera koliko model greši
actuals <- test_data$books_read
mae <- mean(abs(predictions - actuals))
mae

# Kreiramo novi skup podataka - hipotetički članovi i testiramo model sa nepoznatim podacima
# 1. Kreiramo novi data.frame
novi_clanovi <- data.frame(
  member_age = c(18, 25, 40, 60),
  membership_years = c(1, 3, 5, 7)
)

# 2. Kreiramo predikcije na osnovu našeg modela
predikcije <- predict(model, newdata = novi_clanovi)

# 3. Spajamo rezultate u jedan okvir
rezultati <- cbind(novi_clanovi, books_predicted = round(predikcije))

# 4. Eksportujemo rezultate u CSV fajl
write.csv(rezultati, "Marko_Vučković_Task6_predictions.csv", row.names = FALSE)

# Kreiranje grafičkog prikaza regresionog modela
ggplot(library_books_read, aes(x =  member_age, y = books_read)) +
  geom_point(aes(color = membership_years), alpha = 0.8) +
  geom_smooth(method = "lm", se = FALSE, color = "green", linewidth = 1.2) +
  labs(title = "Uticaj godina čitalaca i godina članstva na broj pročitanih knjiga",
       x = "Godine starosti čitalaca",
       y = "Broj pročitanih knjiga",
       color = "Godine članstva") +
  theme_minimal()


# KREIRANJE KLASIFIKACIONOG MODELA - TEŠKI ČITAOCI
# Kreiramo novu binarnu kolonu
library_books_read$read_many_books <- ifelse(library_books_read$books_read > 25, 1, 0)

# Konvertovanje nove kolone u faktor
library_books_read <- library_books_read |>
  mutate(read_many_books = as.factor(read_many_books))

# Treniramo klasifikacioni model 
model_klasifikacije <- glm(read_many_books ~ member_age + membership_years,
                           data = library_books_read,
                           family = binomial)

# Tumačimo rezultate
summary(model_klasifikacije)

# Izračunavanje verovatnoće
verovatnoce <- predict(model_klasifikacije, type = "response")
head(verovatnoce)

# Konvertovanje u 1/0 klasifikaciju
predikcija <- ifelse(verovatnoce > 0.5, 1, 0)

# Kreiranje confusion matrix tabelu
table(Realno = library_books_read$read_many_books, Predikcija = predikcija)

# Proveravamo koliko je model tačan
tacnost <- mean(predikcija == library_books_read$read_many_books)
tacnost

# Kreiranje grafičkog prikaza klasifikacionog modela
ggplot(library_books_read, aes(x = member_age, y = membership_years, color = factor(read_many_books))) +
  geom_jitter(width = 1, height = 0.3, size = 3) +
  scale_color_manual(values = c("0" = "lightblue", "1" = "darkblue")) +
  geom_line(data = library_books_read, aes(x = member_age, y = membership_years), color = "black", linetype = "dashed") +
  labs(
    title = " Da li će neko verovatno čitati mnogo knjiga",
    x = "Godine starosti čitalaca",
    y = "Godine članstva",
    color = "Teški čitalac") +
  theme_minimal()


# ZAKLJUČAK

# 1. Iz priloženog možemo zaključiti da nam više odgovara regresioni model jer će 
# nam on dati bolji prikaz samog stanja analize.
# 2. Poruka koja dobijamo je jasna i preciza, izuzev zanemarljivih odstupanja koja
# nam model prikazuje.
# 3. Prema podacima koje možemo pogledati u modelu možemo zaključiti da veći uticaj
# imaju godine članstva (2.66869), a manji uticaj imaju godine starosti čitalaca (0.45574).
# 4. Što se tiče pouzdanosti modela iz mean vrednosti (3.476376), zaključujemo da
# odstupanja nisu drastično visoka.
