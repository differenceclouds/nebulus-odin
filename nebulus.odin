package nebulus

import rl "vendor:raylib"
import "core:time"
import "core:math"



Window :: struct { 
    name:	cstring,
    width:	i32, 
    height:	i32,
}

Tower :: struct {
	radius: f32,
	levels: int,
	sections: f32,
}

PI_RADIANS:f32 = math.PI / 180.0


main :: proc() {
	rl.SetConfigFlags({ .WINDOW_RESIZABLE, .VSYNC_HINT, .WINDOW_HIGHDPI })
	window := Window{"nebulus", 1024, 768}
	rl.InitWindow(window.width, window.height, window.name)
	// rl.ToggleFullscreen()
	rl.SetTargetFPS(30)
	defer rl.CloseWindow()


	tower := Tower{radius=328, levels = 30, sections = 32}

	section_angle:f32 = 360.0 / (f32)(tower.sections)





	for !rl.WindowShouldClose() {
		if rl.IsWindowResized() {
			window.width = rl.GetScreenWidth()
			window.height = rl.GetScreenHeight()
		}

		centerh:f32 = (f32)(window.width / 2)
		centerv:f32 = (f32)(window.height / 2)

		m_pos := (rl.GetMousePosition()[0] / f32(window.width)) * 150

		rl.BeginDrawing()
		rl.ClearBackground(rl.BLACK)
		{

			using tower
			for i:f32 = 0; i < (f32)(sections); i+=1 {
				x:f32 = math.sin_f32((i * section_angle + m_pos) * PI_RADIANS) * (radius)
				y:f32 = math.cos_f32((i * section_angle + m_pos) * PI_RADIANS) * (radius * 0.25)
				rl.DrawLineV({x + centerh, y + centerv - 200}, {x + centerh, y + centerv + 200}, rl.RED)
			}
		}
		rl.EndDrawing()
	}
}

Vector2 :: rl.Vector2 