gvTitleMessage <- [
	"Also try OG SuperTux!",
	"Also try SuperTuxKart!",
	"Also try Tuxemon!",
	"Also try Hexoshi!",
	"Made with SDL!",
	"Kyrodian Legends is in development!",
	"Don't go into the dark!",
	"Haywire remembers...",
	"That's not how momentum works!",
	"Everything changed when Windows updated.",
	"Eat the rich!",
	"It's gonna be alright.",
	"Have you fed your otter today?",
	"No digging!",
	""
];
gvTitleMessageNumber <- 0;

startMain <- function () {
	stopMusic();
	songPlay(musTheme);
	game = createNewGameObject();
	drawBG = dbgOceanMoving;
	gvGameMode = gmMain;
	actor = {};
	menu = meMain;
	autocon = deepClone(defAutocon);
	gvLight = 0xffffffff;
	gvLightTarget = 0xffffffff;
	levelEndRunner = 0;
	gvTitleMessageNumber = randInt(gvTitleMessage.len());
};

gmMain <- function () {
	drawBG = dbgOceanMoving;
	setDrawTarget(gvScreen);
	drawBG();
	drawSprite(
		sprTuxTitle,
		0,
		wrap(getFrames() * 2, 0, screenW() + 160),
		screenH() + 160.0 - 128.0 * max(0, sin(float(getFrames()) / 20.0))
	);
	drawSprite(
		sprStar,
		getFrames() / 16,
		wrap(getFrames() * 2, 0, screenW() + 160) - 8,
		80 + 24 * sin(getFrames() / 30.0)
	);
	drawSprite(sprTitle, 0, screenW() / 2, 16);
	drawDebug();

	drawText(
		font,
		0,
		screenH() - 8,
		"~tBrux GDK " + bruxVersion() + " - STA " + gvVersion + " - " + getOS()
	);
	textMenu();
};
