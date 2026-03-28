from flask import Blueprint, request, jsonify
import time

from app.services.auth_service import (
    generate_otp,
    send_otp_email,
    otp_store,
    OTP_EXPIRY_SECONDS
)

auth_bp = Blueprint("auth", __name__, url_prefix="/api")


@auth_bp.route("/send-otp", methods=["POST"])
def api_send_otp():
    data = request.get_json(silent=True) or {}
    email = (data.get("email") or "").strip().lower()

    if not email or "@" not in email:
        return jsonify({"success": False, "error": "Invalid email address."}), 400

    otp = generate_otp()
    result = send_otp_email(email, otp)

    if result["success"]:
        otp_store[email] = {
            "otp": otp,
            "expires_at": time.time() + OTP_EXPIRY_SECONDS
        }
        return jsonify({"success": True})
    else:
        return jsonify({"success": False, "error": result["error"]}), 500


@auth_bp.route("/verify-otp", methods=["POST"])
def api_verify_otp():
    data = request.get_json(silent=True) or {}
    email = (data.get("email") or "").strip().lower()
    otp = (data.get("otp") or "").strip()

    if not email or not otp:
        return jsonify({"success": False, "error": "Email and OTP required"}), 400

    record = otp_store.get(email)

    if not record:
        return jsonify({"success": False, "error": "No OTP found"}), 400

    if time.time() > record["expires_at"]:
        del otp_store[email]
        return jsonify({"success": False, "error": "OTP expired"}), 400

    if record["otp"] != otp:
        return jsonify({"success": False, "error": "Incorrect OTP"}), 400

    del otp_store[email]
    return jsonify({"success": True})


@auth_bp.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "ok"})