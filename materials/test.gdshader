shader_type spatial;
render_mode blend_mix, depth_draw_never, cull_disabled, unshaded;

uniform vec4 ring_color : source_color = vec4(0.0, 0.8, 1.0, 1.0); // エフェクトの色
uniform float ring_radius : hint_range(0.0, 1.0) = 0.4;            // リングの太さの基準
uniform float ring_thickness : hint_range(0.0, 0.5) = 0.05;        // リングの線の太さ
uniform float vertical_lines_speed = 1.5;                           // 縦線が上昇する速度
uniform float vertical_lines_density = 20.0;                       // 縦線の細かさ（密度）

float hash(float n) {
    return fract(sin(n) * 43758.5453123);
}

void fragment() {
    // UVの中心を (0.0, 0.0) に補正
    vec2 uv_centered = UV - vec2(0.5);
    float dist_from_center = length(uv_centered);
    
    // 角度（ラジアン）を割り出し、[0.0, 1.0] に正規化（縦線の生成用）
    float angle = (atan(uv_centered.y, uv_centered.x) + 3.14159) / 6.28318;

    // 1. 床面のクッキリとしたメインリングの計算
    // step関数を組み合わせて、指定した半径と太さの部分だけ 1.0 にする
    float inner_edge = ring_radius - ring_thickness;
    float outer_edge = ring_radius + ring_thickness;
    float floor_ring = step(inner_edge, dist_from_center) * step(dist_from_center, outer_edge);

    // 2. 立ち上る「縦の光のライン（魔法の壁）」の計算
    // 時間経過（TIME）で上方向（中心方向へのUVアニメーション）へスクロール
    float time_scroll = TIME * vertical_lines_speed;
    float line_pattern = hash(floor(angle * vertical_lines_density)); // 角度ごとにランダムな太さ
    float vertical_lines = step(0.6, sin(line_pattern * 10.0 + (dist_from_center * 15.0) - time_scroll));
    
    // 縦線はリングの幅（床面）から外側に向かって、なだらかに消えるようにマスクをかける
    float vertical_mask = smoothstep(inner_edge, ring_radius + 0.1, dist_from_center) * (1.0 - smoothstep(ring_radius + 0.1, 0.5, dist_from_center));
    float final_vertical_effect = vertical_lines * vertical_mask * 0.8; // 縦線の強さを微調整

    // 3. 全体のアウトプットの合成
    float final_alpha = clamp(floor_ring + final_vertical_effect, 0.0, 1.0);
    
    // アルベロと発光（Emission）、不透明度を設定
    ALBEDO = ring_color.rgb;
    ALPHA = final_alpha * ring_color.a;
}