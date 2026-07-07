from robot.api import ExecutionResult, ResultVisitor
import os
from openai import OpenAI

client = OpenAI(
    api_key=os.environ["OPENAI_API_KEY"]
)

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

passed = sum(1 for t in summary.tests if t["status"] == "PASS")
failed = sum(1 for t in summary.tests if t["status"] == "FAIL")
total = len(summary.tests)

with open("ResultCI/ai-summary.html", "w", encoding="utf-8") as f:

    f.write("""
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <title>AI Analysis</title>

        <style>
            body{
                font-family:Arial;
                margin:40px;
                background:#f5f5f5;
            }

            h1{
                color:#1f4e79;
            }

            .card{
                background:white;
                padding:20px;
                margin-bottom:20px;
                border-radius:8px;
                box-shadow:0 2px 5px rgba(0,0,0,.2);
            }

            .PASS{
                color:green;
                font-weight:bold;
            }

            .FAIL{
                color:red;
                font-weight:bold;
            }

            ul{
                color:#555;
            }
        </style>

    </head>

    <body>

    <h1>🤖 AI Agent - Robot Framework Analysis</h1>
    """)

    f.write(f"<h2>Total tests : {total}</h2>")
    f.write(f"<h2 style='color:green'>PASS : {passed}</h2>")
    f.write(f"<h2 style='color:red'>FAIL : {failed}</h2>")

    for test in summary.tests:

        f.write("<div class='card'>")

        f.write(f"<h2>{test['name']}</h2>")

        f.write(f"<p>Status : <span class='{test['status']}'>{test['status']}</span></p>")

        f.write(f"<p>Duration : {test['elapsed']} ms</p>")

        if test["message"]:
            f.write(f"<p>{test['message']}</p>")

        if test["status"] == "FAIL":
            try:
                response = client.responses.create(
                    model="gpt-4.1-mini",
                    input=f"""
                Tu es un expert QA Automation et Robot Framework.

                Analyse cet échec de test.

                Nom du test :
                {test['name']}

                Message d'erreur :
                {test['message']}

                Donne une analyse courte en français avec :
                1. Cause probable
                2. Correction proposée
                3. Bonnes pratiques
                """
                            )

                ai_analysis = response.output_text
            
            except Exception as e :
                 ai_analysis = f"Erreur OpenAI : {e}"
        
            f.write("<h3>💡 AI Suggestions</h3>")
            f.write(f"<pre>{ai_analysis}</pre>")

        f.write("</div>")

    f.write("</body></html>")

    