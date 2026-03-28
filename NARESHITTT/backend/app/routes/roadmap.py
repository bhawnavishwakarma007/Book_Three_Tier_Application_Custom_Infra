from flask import Blueprint, request, jsonify
from app.services.roadmap_service import generate_roadmap

roadmap_bp = Blueprint("roadmap", __name__)

@roadmap_bp.route("/roadmap", methods=["POST"])
def roadmap():
    try:
        data = request.get_json() or {}

        fname = data.get("fname", "").strip()
        lname = data.get("lname", "").strip()

        if not fname:
            return jsonify({"error": "First name required"}), 400

        user_data = {
            "name": f"{fname} {lname}",
            "qualification": data.get("qual"),
            "experience": data.get("exp"),
            "skills": data.get("bg"),
            "goals": data.get("goals"),
            "timeline": data.get("timeline")
        }

        result = generate_roadmap(user_data)
        return jsonify(result)

    except Exception as e:
        return jsonify({"error": str(e)}), 500