import os
import json
import re
from groq import Groq

from app.services.course_scraper import fetch_all_courses

client = Groq(api_key=os.getenv("GROQ_API_KEY"))


# =========================
# CLEAN JSON HELPER
# =========================
def extract_json(text):
    if not text:
        raise ValueError("Empty AI response")

    cleaned = text.strip().replace("```json", "").replace("```", "").strip()

    try:
        return json.loads(cleaned)
    except:
        match = re.search(r"\[.*\]", cleaned, re.DOTALL)
        if match:
            return json.loads(match.group(0))

    return []


# =========================
# AI COURSE SELECTION
# =========================
def get_ai_selected_courses(goal):
    all_courses = fetch_all_courses()

    if not all_courses:
        return []

    # limit to avoid token overflow
    course_text = "\n".join(all_courses[:100])

    prompt = f"""
You are an expert career advisor.

User goal: {goal}

From the list below, select ONLY the best 5 relevant courses.

Courses:
{course_text}

Return ONLY JSON array:
[
  {{
    "title": "course name",
    "description": "why this course is useful"
  }}
]
"""

    response = client.chat.completions.create(
        model="llama-3.1-8b-instant",
        messages=[{"role": "user", "content": prompt}],
        temperature=0.3
    )

    content = response.choices[0].message.content
    print("\n===== AI COURSE RESPONSE =====\n", content)

    courses = extract_json(content)

    # add default link
    for c in courses:
        c["source_url"] = "https://nareshit.com/"

    return courses


# =========================
# MAIN FUNCTION
# =========================
def generate_roadmap(user_data):
    try:
        name = user_data.get("name", "Student")
        goal = (user_data.get("goals") or ["Software Developer"])[0]
        timeline = user_data.get("timeline", "6 months")

        # =========================
        # GET COURSES (AI + WEBSITE)
        # =========================
        courses = get_ai_selected_courses(goal)

        # fallback
        if not courses:
            courses = [{
                "title": "Course not found",
                "description": "Check NareshIT website manually",
                "source_url": "https://nareshit.com/"
            }]

        # =========================
        # PHASES (AI BASED)
        # =========================
        phases = [
            {
                "title": "Phase 1: Learning Fundamentals",
                "description": f"Start with basics related to {goal}",
                "duration": "1-2 months"
            },
            {
                "title": "Phase 2: Advanced Concepts",
                "description": "Deep dive into tools & frameworks",
                "duration": "2-4 months"
            },
            {
                "title": "Phase 3: Projects & Practice",
                "description": "Build real-world projects",
                "duration": "1-2 months"
            }
        ]

        # =========================
        # SKILLS (AI STYLE)
        # =========================
        skills = [
            {"title": "Technical Skills", "level": "Advanced"},
            {"title": "Problem Solving", "level": "Intermediate"},
            {"title": "Project Development", "level": "Advanced"}
        ]

        # =========================
        # CAREERS
        # =========================
        careers = [
            {"title": "Software Engineer", "description": "Develop applications"},
            {"title": "Specialist Role", "description": f"Career in {goal}"},
            {"title": "IT Professional", "description": "Work in tech industry"}
        ]

        # =========================
        # FINAL RESPONSE
        # =========================
        return {
            "tagline": f"{name}'s Career Roadmap",
            "summary": f"Personalised roadmap for {goal}",
            "summaryCards": [
                {"title": "Goal", "description": goal},
                {"title": "Timeline", "description": timeline},
                {"title": "Courses", "description": str(len(courses))}
            ],
            "phases": phases,
            "courses": courses[:5],  # ensure max 5
            "skills": skills,
            "careers": careers
        }

    except Exception as e:
        print("❌ ROADMAP ERROR:", e)
        return {
            "tagline": "Error",
            "summary": "Something went wrong",
            "phases": [],
            "courses": [],
            "skills": [],
            "careers": []
        }