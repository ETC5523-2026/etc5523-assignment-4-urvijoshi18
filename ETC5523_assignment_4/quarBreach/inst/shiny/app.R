library(shiny)
library(bslib)
library(ggplot2)
library(dplyr)
library(quarBreach)

ui <- page_sidebar(
  title = "quarBreach: Exploring COVID-19 Quarantine Breach Risk",
  sidebar = sidebar(
    p(strong("Intended user:"), "Public-health students exploring the Zachreson et al. (2022) model."),
    p(strong("Question:"), "At what combination of vaccine efficacy and community coverage does the outbreak horizon shift dramatically?"),
    hr(),
    radioButtons(
      "r0",
      "Basic reproduction number (R\u2080)",
      choices = c("Delta \u2248 6" = 6, "Stress-test = 10" = 10),
      selected = 6
    ),
    p(em("How many people one infectious person infects in a fully susceptible population.")),
    hr(),
    sliderInput(
      "efficacy",
      "Vaccine efficacy against infection (%)",
      min = 40, max = 90, value = 60, step = 10
    ),
    p(em("How much the vaccine reduces the chance of being infected.")),
    sliderInput(
      "coverage",
      "Community vaccination coverage (%)",
      min = 10, max = 100, value = 50, step = 10
    ),
    p(em("Share of the community behind the quarantine facility that is vaccinated."))
  ),
  card(
    card_header("Days until a community outbreak (t\u2085) — across coverage and efficacy"),
    plotOutput("heatmap_plot", height = "350px"),
    card_footer(
      em("Each cell shows days until an outbreak of 5+ cases is 95% likely after a breach.
         Red = high risk, green = safer. The cross marks your selected inputs.
         A jump from red to green is the cliff the app helps you find.
         Values approximated from Zachreson et al. (2022) Figure 4.")
    )
  ),
  card(
    card_header("Relative breach risk — four scenarios (Zachreson et al. Table 1)"),
    plotOutput("bar_plot", height = "250px"),
    card_footer(
      em("Bars show breach risk relative to the 2020 benchmark (= 1).
         A fully vaccinated Delta pathway returns to 1 — the headroom vaccines
         were expected to buy is gone.")
    )
  )
)

server <- function(input, output, session) {
  
  timing_filtered <- reactive({
    outbreak_timing |>
      filter(r0 == as.integer(input$r0))
  })
  
  output$heatmap_plot <- renderPlot({
    df <- timing_filtered()
    
    if (nrow(df) == 0) {
      plot(0, type = "n", axes = FALSE, xlab = "", ylab = "")
      text(0, 0, "No data available for this R\u2080 value.", cex = 1.2)
      return()
    }
    
    sel_eff <- as.integer(input$efficacy)
    sel_cov <- as.integer(input$coverage)
    
    eff_levels <- sort(unique(df$efficacy_pct))
    cov_levels <- sort(unique(df$coverage_pct))
    
    sel_eff_idx <- which(eff_levels == sel_eff)
    sel_cov_idx <- which(cov_levels == sel_cov)
    
    ggplot(df, aes(
      x    = factor(efficacy_pct),
      y    = factor(coverage_pct),
      fill = pmin(t95_days, 1500)
    )) +
      geom_tile(colour = "white", linewidth = 0.8) +
      geom_text(
        aes(label = ifelse(t95_days >= 365,
                           paste0(round(t95_days / 365, 1), "y"),
                           paste0(t95_days, "d"))),
        size = 4, colour = "white", fontface = "bold"
      ) +
      annotate("point",
               x = sel_eff_idx, y = sel_cov_idx,
               size = 12, shape = 3,
               colour = "black", stroke = 2) +
      scale_fill_gradientn(
        colours = c("#c0392b", "#e67e22", "#f1c40f", "#1a6e4a"),
        name = "t\u2085 (days)",
        limits = c(0, 1500)
      ) +
      labs(
        x = "Vaccine efficacy against infection (%)",
        y = "Community vaccination coverage (%)"
      ) +
      theme_minimal(base_size = 13) +
      theme(panel.grid = element_blank())
  })
  
  output$bar_plot <- renderPlot({
    df <- summarise_breach_risk()
    
    ggplot(df, aes(
      x    = reorder(label, breach_risk_vs_benchmark),
      y    = breach_risk_vs_benchmark,
      fill = breach_risk_vs_benchmark <= 1
    )) +
      geom_col(width = 0.6) +
      geom_hline(yintercept = 1, linetype = "dashed", linewidth = 0.8) +
      geom_text(
        aes(label = paste0(breach_risk_vs_benchmark, "\u00d7")),
        hjust = -0.2, size = 4, fontface = "bold"
      ) +
      annotate("text", x = 0.6, y = 1.05,
               label = "2020 benchmark", hjust = 0, size = 3.5) +
      scale_fill_manual(
        values = c("TRUE" = "#1a6e4a", "FALSE" = "#c0392b"),
        guide = "none"
      ) +
      scale_y_continuous(
        expand = expansion(mult = c(0, 0.2)),
        name = "Breach risk vs. 2020 baseline"
      ) +
      coord_flip() +
      labs(x = NULL) +
      theme_minimal(base_size = 12) +
      theme(panel.grid.major.y = element_blank())
  })
}

shinyApp(ui, server)