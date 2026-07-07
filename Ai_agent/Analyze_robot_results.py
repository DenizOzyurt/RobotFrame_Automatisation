from robot.api import ExecutionResult, ResultVisitor


class RobotSummary(ResultVisitor):
    def __init__(self):
        self.tests = []

    def visit_test(self, test):
        self.tests.append({
            "name": test.name,
            "status": test.status,
            "message": test.message,
            "elapsed": test.elapsedtime,
        })


result = ExecutionResult("ResultCI/output.xml")
summary = RobotSummary()
result.visit(summary)

with open("ResultCI/ai-summary.md", "w", encoding="utf-8") as f:
    f.write("# AI Agent - Analyse Robot Framework\n\n")

    for test in summary.tests:
        f.write(f"## {test['name']}\n")
        f.write(f"- Status: {test['status']}\n")
        f.write(f"- Durée: {test['elapsed']} ms\n")

        if test["message"]:
            f.write(f"- Message: {test['message']}\n")

        if test["status"] == "FAIL":
            f.write("\n### Suggestion\n")
            f.write("- Vérifier le locator\n")
            f.write("- Ajouter un `Wait Until Element Is Visible`\n")
            f.write("- Ajouter un `Scroll Element Into View`\n")
            f.write("- Vérifier le mode headless en CI\n")

        f.write("\n")