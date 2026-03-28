import smtplib
import random
import string
import time
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

# Shared store
otp_store = {}

OTP_EXPIRY_SECONDS = 600

GMAIL_USER = "cloudgcp08@gmail.com"
GMAIL_APP_PASSWORD = "xdlg zxnv atqh qczw"
SENDER_NAME = "NareshIT"


def generate_otp(length=6):
    return ''.join(random.choices(string.digits, k=length))


def send_otp_email(to_email: str, otp: str) -> dict:
    try:
        msg = MIMEMultipart("alternative")
        msg["Subject"] = f"Your NareshIT Verification Code: {otp}"
        msg["From"] = f"{SENDER_NAME} <{GMAIL_USER}>"
        msg["To"] = to_email

        msg.attach(MIMEText(f"Your OTP is {otp}", "plain"))

        with smtplib.SMTP("smtp.gmail.com", 587, timeout=15) as server:
            server.starttls()
            server.login(GMAIL_USER, GMAIL_APP_PASSWORD)
            server.sendmail(GMAIL_USER, to_email, msg.as_string())

        return {"success": True}
    except Exception as e:
        return {"success": False, "error": str(e)}