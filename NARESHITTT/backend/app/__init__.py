from flask import Flask
from flask_cors import CORS

def create_app():
    app = Flask(__name__)
    CORS(app)

    from app.routes.chat import chat_bp
    from app.routes.trainer import trainer_bp
    from app.routes.roadmap import roadmap_bp
    from app.routes.auth import auth_bp

    from app.services.rag_service import build_knowledge_base

    app.register_blueprint(chat_bp)
    app.register_blueprint(trainer_bp)
    app.register_blueprint(roadmap_bp)
    app.register_blueprint(auth_bp)

    with app.app_context():
        build_knowledge_base([
            "https://nareshit.com/",
            "https://nareshit.com/trainers-profile",
            "https://nareshit.com/about-us"
        ])

    return app