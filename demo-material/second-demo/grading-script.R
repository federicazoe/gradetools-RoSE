library(readr)
library(gradetools)
class_github_name <- "gradetools-test-course"
repo_template_name <- "final-project-team"
repos_local_path <- "final-project-team-repos"

ghclass::local_repo_clone(
  repo = ghclass::org_repos(class_github_name, repo_template_name),
  local_path = repos_local_path
)

roster <- data.frame(
  student_identifier = c("federicazoe", "CatalinaMedina", "mdogucu"),
  team_identifier = c("gamma", "gamma", "poisson")
)
write_csv(roster, "roster.csv")

rubric <- data.frame(
  name = c("README", "Proposal", "Presentation", "all_questions", "all_questions"),
  total_points = c(2, 3, 5, NA, NA), 
  prompt_code = c("1a", "1a", "1a", "0", "99"), 
  prompt_message = c(
    "Summary needs improvements",
    "Missing method motivation",
    "Title not informative",
    "Unfilled",
    "Style needs improvement"
  ), 
  feedback = c(
    "The summary section of the README should introduce the project and its relavance, outline the methods, and summarize important results.",
    "The data analysis plan should provide motivation for the proposed model.",
    "The presentation title should inform the reader of the general contents of the project.",
    "The template for the file was unchanged. Did you miss this part or forget to push?",
    "Something in your code was untidy (e.g. missing spaces around symbols or too long lines)"
  ), 
  points_to_remove = c(1, 1, 0.5, 100, 1)
)
write_csv(rubric, "rubric.csv")


# Load rubric and rosters for visualization -------------------------------
roster <- read_csv("roster.csv", show_col_types = FALSE)
rubric <- read_csv("rubric.csv", show_col_types = FALSE)


# Assist grading ----------------------------------------------------------
assist_team_grading(
  rubric_path = "rubric.csv",
  roster_path = "roster.csv",
  grading_progress_log_path  = "grading_progress_log.csv",
  final_grade_sheet_path = "final-grade-sheet.csv",
  example_assignment_path = c(
    "final-project-team-repos/final-project-team-gamma/README.md",
    "final-project-team-repos/final-project-team-gamma/proposal/proposal.md",
    "final-project-team-repos/final-project-team-gamma/presentation/presentation.Rmd"
  ) ,
  example_feedback_path = "final-project-team-repos/final-project-team-gamma/feedback.md",
  example_team_identifier = "gamma",
  github_issues = TRUE
)


# Push to GitHub ----------------------------------------------------------
push_to_github(
  grading_progress_log_path = "grading_progress_log.csv",
  class_github_name = "gradetools-test-course",
  example_identifier = "gamma",
  example_github_repo = "final-project-team-gamma",
  push_feedback = TRUE,
  create_issues = TRUE,
  team_grading = TRUE
)


# Regrading ---------------------------------------------------------------
assist_regrading(
  rubric_path = "rubric.csv",
  grading_progress_log_path = "grading_progress_log.csv",
  final_grade_sheet_path = "final-grade-sheet.csv",
  questions_to_regrade = c("Proposal"),
  students_to_regrade = NULL,
  teams_to_regrade = c("gamma"),
  github_issues = TRUE
)

