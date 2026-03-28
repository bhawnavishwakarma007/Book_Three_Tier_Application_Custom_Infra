import requests
from bs4 import BeautifulSoup

def fetch_all_courses():
    url = "https://nareshit.com/"

    try:
        res = requests.get(url, timeout=10)
        soup = BeautifulSoup(res.text, "html.parser")

        courses = []

        # 🔥 collect lots of text (not just <a>)
        for tag in soup.find_all(["h2", "h3", "h4", "a"]):
            text = tag.get_text(strip=True)

            if text and len(text) > 5:
                courses.append(text)

        # remove duplicates
        courses = list(set(courses))

        return courses[:100]  # limit for AI (important)

    except Exception as e:
        print("SCRAPER ERROR:", e)
        return []