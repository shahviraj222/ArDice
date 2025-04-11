🎲 ArDice - Augmented Reality Dice Roller
ArDice is an iOS app that uses ARKit and SceneKit to bring an interactive dice-rolling experience into augmented reality. Simply tap on a flat surface or shake your phone to roll 3D dice in your real-world space!

<!-- Optional: Add a demo GIF or image -->

🚀 Features
📱 AR Plane Detection: Detects horizontal planes in your environment.

🎲 3D Dice Placement: Tap on the detected surface to place a 3D dice model.

🎞️ Realistic Rolling Animation: Dice roll randomly when placed or when the phone is shaken.

🔁 Roll All Dice: Roll all existing dice using a button or device shake gesture.

❌ Clear All Dice: Instantly remove all dice from the scene.

📷 Tech Stack
ARKit: For real-world environment tracking and plane detection.

SceneKit: For rendering 3D dice models and animations.

Swift / UIKit: Native iOS development.

🎯 How It Works
The app starts with AR plane detection enabled (ARWorldTrackingConfiguration).

Tapping on a detected plane performs a raycast and places a 3D dice model.

Each dice is given a random rotation using SCNAction.rotateBy(...) for a realistic rolling effect.

Dice can also be rolled using the shake gesture.

All dice are stored in an array for batch actions like rolling again or removing them.

📁 Assets
Dice model: art.scnassets/diceCollada.scn

Grid texture: art.scnassets/grid.png

🛠️ Code Highlights
✅ Modern raycasting API instead of deprecated hitTest.

✅ Feature points enabled for debugging.

✅ Auto-lighting for realistic object appearance.

✅ Smart vertical alignment using boundingSphere.radius.

📸 Screenshots
Add screenshots or a demo video of your app here!

🤝 Contributing
Contributions are welcome! Feel free to open issues or pull requests.

📄 License
This project is licensed under the MIT License - see the LICENSE file for details.

