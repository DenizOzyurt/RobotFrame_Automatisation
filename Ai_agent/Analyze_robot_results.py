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

            f.write("<h3>💡 AI Suggestions</h3>")

            f.write("""
            <ul>
                <li>Check locator.</li>
                <li>Use Wait Until Element Is Visible.</li>
                <li>Use Scroll Element Into View.</li>
                <li>Check Headless mode.</li>
                <li>Verify timing and synchronization.</li>
            </ul>
            """)

        f.write("</div>")

    f.write("</body></html>")