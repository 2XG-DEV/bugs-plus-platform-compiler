import sys
import os

# Add src/ to the Python path so existing imports (api.boardTypes, engine.eval) work
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "src"))

from api.main import app
