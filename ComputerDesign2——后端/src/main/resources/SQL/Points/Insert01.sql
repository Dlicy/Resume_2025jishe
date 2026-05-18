-- 穴位数据SQL插入语句
-- 生成时间: 2025-03-30 15:41:02


CREATE TABLE IF NOT EXISTS acupuncture_points (
                                                  id INT AUTO_INCREMENT PRIMARY KEY,
                                                  model_name VARCHAR(50) NOT NULL COMMENT '穴位名称',
    path VARCHAR(100) NOT NULL COMMENT '穴位路径',
    position_x DECIMAL(20,15) NOT NULL,
    position_y DECIMAL(20,15) NOT NULL,
    position_z DECIMAL(20,15) NOT NULL,
    local_position_x DECIMAL(20,15) NOT NULL,
    local_position_y DECIMAL(20,15) NOT NULL,
    local_position_z DECIMAL(20,15) NOT NULL,
    rotation_x DECIMAL(20,15) NOT NULL,
    rotation_y DECIMAL(20,15) NOT NULL,
    rotation_z DECIMAL(20,15) NOT NULL,
    rotation_w DECIMAL(20,15) NOT NULL,
    local_rotation_x DECIMAL(20,15) NOT NULL,
    local_rotation_y DECIMAL(20,15) NOT NULL,
    local_rotation_z DECIMAL(20,15) NOT NULL,
    local_rotation_w DECIMAL(20,15) NOT NULL,
    scale_x DECIMAL(20,15) NOT NULL,
    scale_y DECIMAL(20,15) NOT NULL,
    scale_z DECIMAL(20,15) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='穴位信息表';


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '上脘',
             '人体/任脉/上脘',
             0.011390656232833862, 2.531480312347412, 230.03309631347656,
             0.0005376446060836315, -0.0009752323385328054, -0.00016755536489654332,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '下脘',
             '人体/任脉/下脘',
             -0.02657770924270153, 1.0118225812911987, 229.92787170410156,
             0.000480732909636572, -0.003253085305914283, -0.00032526746508665383,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '中庭',
             '人体/任脉/中庭',
             3.9581206578986894e-07, 3.843824863433838, 230.1621856689453,
             0.0005205714842304587, 0.0009918728610500693, 2.5939047191059217e-05,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '中极',
             '人体/任脉/中极',
             -0.02182142250239849, -2.512584924697876, 229.7393035888672,
             0.00048786221304908395, -0.008535906672477722, -0.0006079241284169257,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '中脘',
             '人体/任脉/中脘',
             3.9581206578986894e-07, 2.1734936237335205, 230.00546264648438,
             0.0005205714842304587, -0.0015118278097361326, -0.0002089633053401485,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '会阴_001',
             '人体/任脉/会阴_001',
             -0.06783462315797806, -3.6366539001464844, 229.15272521972656,
             0.0004188918974250555, -0.010220801457762718, -0.0014871598687022924,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '关元',
             '人体/任脉/关元',
             -0.026578128337860107, -2.184238910675049, 229.78614807128906,
             0.00048073226935230196, -0.008043740876019001, -0.0005377022898755968,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '华盖',
             '人体/任脉/华盖',
             -0.0023907048162072897, 5.823078632354736, 230.15147399902344,
             0.0005169874057173729, 0.003958625718951225, 9.88811098068254e-06,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '天突_001',
             '人体/任脉/天突_001',
             3.9581206578986894e-07, 6.642861843109131, 229.94908142089844,
             0.0005205714842304587, 0.005187418777495623, -0.0002934866934083402,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '巨阙',
             '人体/任脉/巨阙',
             0.001593376393429935, 2.906628131866455, 230.0749053955078,
             0.0005229592206887901, -0.0004129143781028688, -0.00010487005056347698,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '廉泉',
             '人体/任脉/廉泉',
             3.9581206578986894e-07, 8.354496002197266, 230.53448486328125,
             0.0005205714842304587, 0.007753028068691492, 0.0005839922232553363,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '建里',
             '人体/任脉/建里',
             0.005477596540004015, 1.659034252166748, 229.96319580078125,
             0.0005287813837639987, -0.00228296360000968, -0.00027231185231357813,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '承浆',
             '人体/任脉/承浆',
             3.9581206578986894e-07, 9.174871444702148, 230.8086395263672,
             0.0005205714842304587, 0.008982709608972073, 0.0009949266677722335,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '曲骨',
             '人体/任脉/曲骨',
             -0.02182142250239849, -2.9075722694396973, 229.6392364501953,
             0.00048786221304908395, -0.009127963334321976, -0.0007579126977361739,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '气海',
             '人体/任脉/气海',
             0.01536076795309782, -1.0991690158843994, 229.95851135253906,
             0.0005435955245047808, -0.006417302880436182, -0.00027934371610172093,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '水分',
             '人体/任脉/水分',
             3.9581206578986894e-07, 0.462390661239624, 229.90951538085938,
             0.0005205714842304587, -0.004076642449945211, -0.000352775736246258,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '玉堂',
             '人体/任脉/玉堂',
             3.9581206578986894e-07, 5.0107340812683105, 230.27903747558594,
             0.0005205714842304587, 0.002740982687100768, 0.00020110636251047254,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '璇玑',
             '人体/任脉/璇玑',
             3.1664965263189515e-06, 6.156671047210693, 230.09719848632812,
             0.0005205756169743836, 0.0044586556032299995, -7.147148426156491e-05,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '石门',
             '人体/任脉/石门',
             -0.015359999611973763, -1.7720427513122559, 229.8309783935547,
             0.0004975473857484758, -0.00742588983848691, -0.00047050163266249,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '神阙',
             '人体/任脉/神阙',
             0.015360395424067974, -0.08744323253631592, 229.9449920654297,
             0.0005435949424281716, -0.00490080239251256, -0.0002996055700350553,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '紫宫',
             '人体/任脉/紫宫',
             -0.0024022299330681562, 5.475228786468506, 230.21192932128906,
             0.0005169701180420816, 0.0034372257068753242, 0.00010050654236692935,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '膻中',
             '人体/任脉/膻中',
             0.0023918456863611937, 4.6432881355285645, 230.26654052734375,
             0.0005241560866124928, 0.002190208528190851, 0.0001823587663238868,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '阴交_001',
             '人体/任脉/阴交_001',
             -2.3283062589030123e-08, -0.5982524156570435, 229.94381713867188,
             0.0005205708439461887, -0.0056664664298295975, -0.0003013689420185983,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '鸠尾',
             '人体/任脉/鸠尾',
             -2.3283062589030123e-08, 3.3247671127319336, 230.09954833984375,
             0.0005205708439461887, 0.00021384426509030163, -6.793901411583647e-05,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.01134564634412527, 0.01134564634412527, 0.01134564634412527
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '中注',
             '人体/冲脉/中注',
             -0.4112408757209778, -1.0941288471221924, 229.9549560546875,
             -0.06211463734507561, -0.3829125463962555, -0.7878175377845764,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '会阴',
             '人体/冲脉/会阴',
             -0.005641160067170858, -3.7046475410461426, 228.802490234375,
             -0.008529013954102993, -0.23077334463596344, -1.132757544517517,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '商曲',
             '人体/冲脉/商曲',
             -0.42164164781570435, 0.43530142307281494, 230.016845703125,
             -0.06348872929811478, -0.3910175561904907, -0.5857547521591187,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '四满',
             '人体/冲脉/四满',
             -0.3942585587501526, -1.5556082725524902, 229.90113830566406,
             -0.05987102538347244, -0.37582170963287354, -0.8487881422042847,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '大赫',
             '人体/冲脉/大赫',
             -0.3485010862350464, -2.2598681449890137, 229.7923583984375,
             -0.05382579565048218, -0.36148321628570557, -0.9418360590934753,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '幽门',
             '人体/冲脉/幽门',
             -0.412667840719223, 3.6195168495178223, 230.0903778076172,
             -0.06230315938591957, -0.40058863162994385, -0.16507022082805634,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '横骨',
             '人体/冲脉/横骨',
             -0.26670750975608826, -2.570815086364746, 229.71533203125,
             -0.043019674718379974, -0.3513209819793701, -0.982920229434967,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '气',
             '人体/冲脉/气',
             -0.35857468843460083, -1.9749398231506348, 229.87533569335938,
             -0.05515666306018829, -0.37243273854255676, -0.9041890501976013,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '气冲',
             '人体/冲脉/气冲',
             -0.7610508799552917, -2.6192660331726074, 229.6166534423828,
             -0.10832961648702621, -0.3382861018180847, -0.989325761795044,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '石关',
             '人体/冲脉/石关',
             -0.4130256175994873, 1.135165810585022, 229.98187255859375,
             -0.062350425869226456, -0.38636505603790283, -0.4932940602302551,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '肓俞',
             '人体/冲脉/肓俞',
             -0.4300980567932129, -0.813701868057251, 229.9862518310547,
             -0.0646059438586235, -0.38703349232673645, -0.7507675886154175,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '通谷',
             '人体/冲脉/通谷',
             -0.44374242424964905, 2.7735342979431152, 230.0928192138672,
             -0.06640856713056564, -0.4009489417076111, -0.27683669328689575,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '阴交',
             '人体/冲脉/阴交',
             0.3907872438430786, -1.2454493045806885, 229.94937133789062,
             0.04384494572877884, -0.3821810781955719, -0.8078094124794006,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '阴都',
             '人体/冲脉/阴都',
             -0.4483756721019745, 2.0247342586517334, 230.05953979492188,
             -0.06702068448066711, -0.3965868353843689, -0.3757655918598175,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '五枢',
             '人体/带脉/五枢',
             -1.987658143043518, -0.19391846656799316, 229.31800842285156,
             -0.09362609684467316, -0.10553180426359177, -0.008472442626953125,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '带脉_002',
             '人体/带脉/带脉_002',
             -2.3975887298583984, 0.15676099061965942, 228.2080841064453,
             -0.14778389036655426, 0.041120871901512146, 0.03780681639909744,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '维道',
             '人体/带脉/维道',
             -1.5008574724197388, -0.5161581039428711, 229.5377197265625,
             -0.02931266464293003, -0.13457484543323517, -0.05103496462106705,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '养老',
             '人体/手太阳小肠经/养老',
             -11.618844032287598, 5.530185699462891, 227.8998260498047,
             -0.19847382605075836, 0.014526656828820705, -0.04821515828371048,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.19856345653533936, 0.19856345653533936, 0.19856347143650055
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '前谷',
             '人体/手太阳小肠经/前谷',
             -13.081557273864746, 5.549771308898926, 227.67723083496094,
             -0.23684531450271606, 0.020366106182336807, -0.04770338907837868,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.19856345653533936, 0.19856345653533936, 0.19856347143650055
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '后溪',
             '人体/手太阳小肠经/后溪',
             -12.789437294006348, 5.56965446472168, 227.70455932617188,
             -0.22918212413787842, 0.01964935101568699, -0.04718156158924103,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.19856345653533936, 0.19856345653533936, 0.19856347143650055
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '听宫',
             '人体/手太阳小肠经/听宫',
             -1.162377119064331, 10.021713256835938, 229.89378356933594,
             0.07583194226026535, -0.03774024546146393, 0.06962963193655014,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.19856345653533936, 0.19856345653533936, 0.19856347143650055
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '天宗',
             '人体/手太阳小肠经/天宗',
             -1.3062431812286377, 6.70613431930542, 227.06260681152344,
             0.07205788791179657, 0.03650009632110596, -0.01737394370138645,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.19856345653533936, 0.19856345653533936, 0.19856347143650055
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '天容',
             '人体/手太阳小肠经/天容',
             -0.8598319292068481, 8.7724609375, 229.52426147460938,
             0.08376865088939667, -0.02805783413350582, 0.03685451298952103,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.19856345653533936, 0.19856345653533936, 0.19856347143650055
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '天窗',
             '人体/手太阳小肠经/天窗',
             -0.9574434757232666, 8.497964859008789, 229.149658203125,
             0.0812079906463623, -0.01823338493704796, 0.029650229960680008,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.19856345653533936, 0.19856345653533936, 0.19856347143650055
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '小海',
             '人体/手太阳小肠经/小海',
             -6.793570518493652, 5.803483486175537, 227.77838134765625,
             -0.07189183682203293, 0.017715197056531906, -0.04104682058095932,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.19856345653533936, 0.19856345653533936, 0.19856347143650055
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '少泽',
             '人体/手太阳小肠经/少泽',
             -13.455777168273926, 5.490821361541748, 227.6392364501953,
             -0.24666230380535126, 0.021362509578466415, -0.049250174313783646,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.19856345653533936, 0.19856345653533936, 0.19856347143650055
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '支正',
             '人体/手太阳小肠经/支正',
             -10.419690132141113, 5.509036540985107, 227.8927001953125,
             -0.16701625287532806, 0.014713565818965435, -0.04877004399895668,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.19856345653533936, 0.19856345653533936, 0.19856347143650055
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '曲垣',
             '人体/手太阳小肠经/曲垣',
             -1.086768627166748, 7.194352149963379, 227.17645263671875,
             0.07781539112329483, 0.03351789712905884, -0.004565458279103041,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.19856345653533936, 0.19856345653533936, 0.19856347143650055
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '秉风',
             '人体/手太阳小肠经/秉风',
             -1.7914754152297974, 7.196681022644043, 227.47129821777344,
             0.05932873114943504, 0.025783486664295197, -0.0045016766525805,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.19856345653533936, 0.19856345653533936, 0.19856347143650055
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '肩中俞',
             '人体/手太阳小肠经/肩中俞',
             -0.9056832194328308, 7.610208511352539, 227.39865112304688,
             0.08256582915782928, 0.027692990377545357, 0.006345767993479967,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.19856345653533936, 0.19856345653533936, 0.19856347143650055
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '肩外俞',
             '人体/手太阳小肠经/肩外俞',
             -0.9928726553916931, 7.377490997314453, 227.29014587402344,
             0.08027857542037964, 0.030537094920873642, 0.00023988723114598542,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.19856345653533936, 0.19856345653533936, 0.19856347143650055
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '肩贞',
             '人体/手太阳小肠经/肩贞',
             -3.1218719482421875, 6.744766712188721, 227.44773864746094,
             0.02442828193306923, 0.02639748528599739, -0.01635701209306717,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.19856345653533936, 0.19856345653533936, 0.19856347143650055
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '腕骨',
             '人体/手太阳小肠经/腕骨',
             -12.40621566772461, 5.568879127502441, 227.74624633789062,
             -0.21912901103496552, 0.018556032329797745, -0.04720151796936989,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.19856345653533936, 0.19856345653533936, 0.19856347143650055
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '臑俞_001',
             '人体/手太阳小肠经/臑俞_001',
             -2.4678099155426025, 7.091681003570557, 227.5873260498047,
             0.04158636927604675, 0.022738749161362648, -0.007255105767399073,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.19856345653533936, 0.19856345653533936, 0.19856347143650055
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '阳谷',
             '人体/手太阳小肠经/阳谷',
             -12.13275146484375, 5.517126560211182, 227.7671356201172,
             -0.2119552046060562, 0.018007365986704826, -0.04855895787477493,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.19856345653533936, 0.19856345653533936, 0.19856347143650055
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '颧髎',
             '人体/手太阳小肠经/颧髎',
             -0.7017835378646851, 9.309503555297852, 230.54615783691406,
             0.08791474997997284, -0.05486063286662102, 0.05095209181308746,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.19856345653533936, 0.19856345653533936, 0.19856347143650055
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '中府',
             '人体/手太阴肺经/中府',
             -1.313739538192749, 5.938445568084717, 230.2295379638672,
             0.017675025388598442, 0.00014536162780132145, 0.003466491587460041,
             -5.960464477539063e-08, 0.0, 0.0, 1.0,
             -5.979435544113286e-15, 0.0, 0.0, 1.0,
             -0.027851033955812454, -0.027851033955812454, -0.027851033955812454
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '云门',
             '人体/手太阴肺经/云门',
             -1.1395468711853027, 6.363471031188965, 230.14356994628906,
             0.018236009404063225, 0.001514147617854178, 0.0031896503642201424,
             -5.960464477539063e-08, 0.0, 0.0, 1.0,
             -5.979435544113286e-15, 0.0, 0.0, 1.0,
             -0.027851033955812454, -0.027851033955812454, -0.027851033955812454
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '侠白',
             '人体/手太阴肺经/侠白',
             -6.054839611053467, 6.068307399749756, 229.15977478027344,
             0.002406408078968525, 0.0005635798443108797, 2.1375715732574463e-05,
             -5.960464477539063e-08, 0.0, 0.0, 1.0,
             -5.979435544113286e-15, 0.0, 0.0, 1.0,
             -0.027851033955812454, -0.027851033955812454, -0.027851033955812454
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '列缺',
             '人体/手太阴肺经/列缺',
             -11.15392017364502, 5.534897327423096, 228.6480712890625,
             -0.0140150785446167, -0.0011542558204382658, -0.001626577926799655,
             -5.960464477539063e-08, 0.0, 0.0, 1.0,
             -5.979435544113286e-15, 0.0, 0.0, 1.0,
             -0.027851033955812454, -0.027851033955812454, -0.027851033955812454
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '天府',
             '人体/手太阴肺经/天府',
             -5.733609676361084, 6.118074893951416, 229.19000244140625,
             0.003440922126173973, 0.0007238555699586868, 0.00011871769675053656,
             -5.960464477539063e-08, 0.0, 0.0, 1.0,
             -5.979435544113286e-15, 0.0, 0.0, 1.0,
             -0.027851033955812454, -0.027851033955812454, -0.027851033955812454
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '太渊',
             '人体/手太阴肺经/太渊',
             -11.677099227905273, 5.330010890960693, 228.6455841064453,
             -0.01569996401667595, -0.0018140887841582298, -0.0016345607582479715,
             -5.960464477539063e-08, 0.0, 0.0, 1.0,
             -5.979435544113286e-15, 0.0, 0.0, 1.0,
             -0.027851033955812454, -0.027851033955812454, -0.027851033955812454
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '孔最',
             '人体/手太阴肺经/孔最',
             -9.170736312866211, 5.632009506225586, 228.66078186035156,
             -0.0076282755471765995, -0.0008415090851485729, -0.0015856389654800296,
             -0.70698481798172, 0.0, 0.0, 0.7072287201881409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             -0.027851033955812454, -0.027851033955812454, -0.027851033955812454
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '少商',
             '人体/手太阴肺经/少商',
             -12.19295883178711, 5.080400466918945, 229.4196014404297,
             -0.01736128330230713, -0.0026179563719779253, 0.0008581085130572319,
             -5.960464477539063e-08, 0.0, 0.0, 1.0,
             -5.979435544113286e-15, 0.0, 0.0, 1.0,
             -0.027851033955812454, -0.027851033955812454, -0.027851033955812454
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '尺泽',
             '人体/手太阴肺经/尺泽',
             -7.375403881072998, 5.823047637939453, 228.70034790039062,
             -0.0018464422319084406, -0.0002262735361000523, -0.0014581904979422688,
             -5.960464477539063e-08, 0.0, 0.0, 1.0,
             -5.979435544113286e-15, 0.0, 0.0, 1.0,
             -0.027851033955812454, -0.027851033955812454, -0.027851033955812454
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '经渠',
             '人体/手太阴肺经/经渠',
             -11.397854804992676, 5.427585124969482, 228.61517333984375,
             -0.014800664968788624, -0.0014998530969023705, -0.0017325113294646144,
             -5.960464477539063e-08, 0.0, 0.0, 1.0,
             -5.979435544113286e-15, 0.0, 0.0, 1.0,
             -0.027851033955812454, -0.027851033955812454, -0.027851033955812454
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '鱼际',
             '人体/手太阴肺经/鱼际',
             -11.859442710876465, 5.23328971862793, 228.94322204589844,
             -0.016287200152873993, -0.0021255777683109045, -0.0006760532269254327,
             -5.960464477539063e-08, 0.0, 0.0, 1.0,
             -5.979435544113286e-15, 0.0, 0.0, 1.0,
             -0.027851033955812454, -0.027851033955812454, -0.027851033955812454
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '三阳络',
             '人体/手少阳三焦经/三阳络',
             -10.417285919189453, 5.80570650100708, 228.0331268310547,
             -0.7618134021759033, 0.040919821709394455, -0.24910369515419006,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '丝竹空',
             '人体/手少阳三焦经/丝竹空',
             -0.962900698184967, 10.287215232849121, 230.31060791015625,
             0.48724833130836487, -0.2597649395465851, 0.34307265281677246,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '中渚',
             '人体/手少阳三焦经/中渚',
             -12.190043449401855, 5.753172397613525, 228.01914978027344,
             -0.9960203170776367, 0.04276323691010475, -0.256044864654541,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '会宗',
             '人体/手少阳三焦经/会宗',
             -10.879119873046875, 5.757363319396973, 228.01202392578125,
             -0.8228283524513245, 0.04370548576116562, -0.2554915249347687,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '关冲',
             '人体/手少阳三焦经/关冲',
             -13.838284492492676, 5.50615119934082, 227.95318603515625,
             -1.21377694606781, 0.05146604776382446, -0.2886829674243927,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '四渎',
             '人体/手少阳三焦经/四渎',
             -9.483809471130371, 6.023254871368408, 228.00616455078125,
             -0.6384876370429993, 0.044492077082395554, -0.22036364674568176,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '外关',
             '人体/手少阳三焦经/外关',
             -11.322235107421875, 5.761733055114746, 228.084228515625,
             -0.8813703656196594, 0.03416487202048302, -0.254910945892334,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '天井',
             '人体/手少阳三焦经/天井',
             -8.057336807250977, 6.153895854949951, 227.85614013671875,
             -0.45002982020378113, 0.0643170028924942, -0.20311091840267181,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '天牖',
             '人体/手少阳三焦经/天牖',
             -0.8570394515991211, 9.081536293029785, 228.5932159423828,
             0.5012341737747192, -0.032926663756370544, 0.18370665609836578,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '天髎_001',
             '人体/手少阳三焦经/天髎_001',
             -0.6244587898254395, 7.528209686279297, 227.30963134765625,
             0.5319614410400391, 0.13658198714256287, -0.0215689055621624,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '支沟',
             '人体/手少阳三焦经/支沟',
             -10.909388542175293, 5.824418544769287, 228.1651153564453,
             -0.8268272876739502, 0.02348220720887184, -0.24662555754184723,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '消泺',
             '人体/手少阳三焦经/消泺',
             -6.116635322570801, 6.522256374359131, 227.82354736328125,
             -0.19363494217395782, 0.06864036619663239, -0.1544465571641922,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '液门',
             '人体/手少阳三焦经/液门',
             -12.720885276794434, 5.699760913848877, 227.9394989013672,
             -1.0661523342132568, 0.05328480154275894, -0.2631049156188965,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '清冷渊',
             '人体/手少阳三焦经/清冷渊',
             -7.549137115478516, 6.180501937866211, 227.92071533203125,
             -0.3828892409801483, 0.05578671023249626, -0.19959285855293274,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '瘛脉',
             '人体/手少阳三焦经/瘛脉',
             -1.1643550395965576, 9.77379322052002, 229.1481475830078,
             0.4606333076953888, -0.10621087998151779, 0.27518919110298157,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '翳风',
             '人体/手少阳三焦经/翳风',
             -1.0873972177505493, 9.4124116897583, 229.31900024414062,
             0.4708005487918854, -0.1287999451160431, 0.2274530529975891,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '耳和髎',
             '人体/手少阳三焦经/耳和髎',
             -1.1386836767196655, 10.16241455078125, 229.90252685546875,
             0.4640248417854309, -0.20585782825946808, 0.3265659213066101,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '耳门',
             '人体/手少阳三焦经/耳门',
             -1.1627047061920166, 9.952995300292969, 229.6597900390625,
             0.4608513116836548, -0.17379741370677948, 0.2988876402378082,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '肩髎',
             '人体/手少阳三焦经/肩髎',
             -3.6993563175201416, 7.365623474121094, 227.93576049804688,
             0.1257227510213852, 0.05385372415184975, -0.043020475655794144,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '臑会',
             '人体/手少阳三焦经/臑会',
             -5.191936492919922, 6.666873931884766, 227.8988494873047,
             -0.07146880775690079, 0.05869857594370842, -0.13533706963062286,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '角孙',
             '人体/手少阳三焦经/角孙',
             -1.1946862936019897, 10.235681533813477, 229.5896453857422,
             0.4566260874271393, -0.16451682150363922, 0.33623138070106506,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '阳池',
             '人体/手少阳三焦经/阳池',
             -11.673357009887695, 5.7193474769592285, 228.04319763183594,
             -0.9277586340904236, 0.03958410769701004, -0.2605125308036804,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '颅息',
             '人体/手少阳三焦经/颅息',
             -1.2026103734970093, 10.097248077392578, 229.19532775878906,
             0.4555792212486267, -0.11242864280939102, 0.3179244101047516,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '少冲',
             '人体/手少阴心经/少冲',
             -13.432257652282715, 5.555912017822266, 227.7445068359375,
             -0.059888266026973724, 0.006769333966076374, 0.0019855594728142023,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09217317402362823, 0.09217317402362823, 0.09217317402362823
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '少府',
             '人体/手少阴心经/少府',
             -12.432839393615723, 5.390836238861084, 228.0088348388672,
             -0.047717947512865067, 0.003549855202436447, -2.3531913029728457e-05,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09217317402362823, 0.09217317402362823, 0.09217317402362823
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '少海',
             '人体/手少阴心经/少海',
             -7.122854232788086, 5.333075523376465, 228.4259796142578,
             0.01694396138191223, -0.0015302286483347416, -0.0007251501083374023,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09217317402362823, 0.09217317402362823, 0.09217317402362823
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '极泉',
             '人体/手少阴心经/极泉',
             -2.777585506439209, 5.5104169845581055, 228.82412719726562,
             0.0698581114411354, -0.006377771962434053, 0.0014360856730490923,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09217317402362823, 0.09217317402362823, 0.09217317402362823
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '灵道',
             '人体/手少阴心经/灵道',
             -10.18055534362793, 5.329373359680176, 228.09326171875,
             -0.020290937274694443, 0.0025214916095137596, -0.0007716369582340121,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09217317402362823, 0.09217317402362823, 0.09217317402362823
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '神门',
             '人体/手少阴心经/神门',
             -11.321722030639648, 5.339145183563232, 228.05697631835938,
             -0.034187402576208115, 0.0029632877558469772, -0.0006527900695800781,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09217317402362823, 0.09217317402362823, 0.09217317402362823
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '通里',
             '人体/手少阴心经/通里',
             -10.544614791870117, 5.344028472900391, 228.08847045898438,
             -0.024724239483475685, 0.0025798820424824953, -0.0005931901978328824,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09217317402362823, 0.09217317402362823, 0.09217317402362823
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '阴郄',
             '人体/手少阴心经/阴郄',
             -10.968535423278809, 5.334165573120117, 228.0872039794922,
             -0.029886504635214806, 0.002595235127955675, -0.0007133007165975869,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09217317402362823, 0.09217317402362823, 0.09217317402362823
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '青灵',
             '人体/手少阴心经/青灵',
             -5.177867412567139, 5.42344856262207, 228.68771362304688,
             0.04062888026237488, -0.004716954194009304, 0.0003764629364013672,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09217317402362823, 0.09217317402362823, 0.09217317402362823
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '中冲',
             '人体/手阙阴心包经/中冲',
             -13.850923538208008, 5.359402656555176, 228.35284423828125,
             -0.8626584410667419, 0.07516840100288391, -0.04819415882229805,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '内关',
             '人体/手阙阴心包经/内关',
             -10.785531997680664, 5.347249984741211, 228.3186492919922,
             -0.4576755464076996, 0.07968493551015854, -0.049801331013441086,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '劳宫',
             '人体/手阙阴心包经/劳宫',
             -12.678568840026855, 5.426992893218994, 228.265869140625,
             -0.7077732682228088, 0.086662158370018, -0.039268530905246735,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '大陵',
             '人体/手阙阴心包经/大陵',
             -11.30955982208252, 5.329738616943359, 228.27516174316406,
             -0.5269072651863098, 0.0854300707578659, -0.05211681127548218,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '天池',
             '人体/手阙阴心包经/天池',
             -1.5513527393341064, 4.893486499786377, 230.25057983398438,
             0.762293815612793, -0.17557159066200256, -0.10966205596923828,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '天泉',
             '人体/手阙阴心包经/天泉',
             -5.414073467254639, 5.860095024108887, 229.16622924804688,
             0.2519722580909729, -0.03226917237043381, 0.017991600558161736,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '曲泽',
             '人体/手阙阴心包经/曲泽',
             -6.8983259201049805, 5.54174280166626, 228.67227172851562,
             0.05588088929653168, 0.03297511860728264, -0.02408985048532486,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '郄门',
             '人体/手阙阴心包经/郄门',
             -9.265557289123535, 5.25057315826416, 228.39024353027344,
             -0.25686484575271606, 0.0702226459980011, -0.06257053464651108,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '间使',
             '人体/手阙阴心包经/间使',
             -10.355923652648926, 5.332757472991943, 228.3358612060547,
             -0.40091803669929504, 0.07741103321313858, -0.05171523988246918,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '三间',
             '人体/手阳明大肠经/三间',
             -12.46851634979248, 5.7405619621276855, 228.77842712402344,
             0.004352890886366367, 0.0008998413104563951, 0.0002509801124688238,
             -0.7071069478988647, 3.1235731512424536e-07, 2.6154634724662174e-06, 0.7071066498756409,
             -0.7070932984352112, -0.004375869873911142, 0.004375775810331106, 0.7070931792259216,
             -0.0072080534882843494, -0.0072080534882843494, -0.0072080534882843494
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '上廉',
             '人体/手阳明大肠经/上廉',
             -7.680290222167969, 6.304506301879883, 228.49046325683594,
             -0.00019988924032077193, 0.0003064249758608639, 0.0005251853726804256,
             -0.7071069478988647, 3.1235731512424536e-07, 2.6154634724662174e-06, 0.7071066498756409,
             -0.7070932984352112, -0.004375869873911142, 0.004375775810331106, 0.7070931792259216,
             -0.0072080534882843494, -0.0072080534882843494, -0.0072080534882843494
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '下廉',
             '人体/手阳明大肠经/下廉',
             -8.13337230682373, 6.262218475341797, 228.48826599121094,
             0.000231044294196181, 0.00035203099832870066, 0.0005272879498079419,
             -0.7071069478988647, 3.1235731512424536e-07, 2.6154634724662174e-06, 0.7071066498756409,
             -0.7070932984352112, -0.004375869873911142, 0.004375775810331106, 0.7070931792259216,
             -0.0072080534882843494, -0.0072080534882843494, -0.0072080534882843494
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '二间',
             '人体/手阳明大肠经/二间',
             -12.8630952835083, 5.643440246582031, 228.82025146484375,
             0.004727471154183149, 0.0009969706879928708, 0.00021115544950589538,
             -0.7071069478988647, 3.1235731512424536e-07, 2.6154634724662174e-06, 0.7071066498756409,
             -0.7070932984352112, -0.004375869873911142, 0.004375775810331106, 0.7070931792259216,
             -0.0072080534882843494, -0.0072080534882843494, -0.0072080534882843494
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '偏历',
             '人体/手阳明大肠经/偏历',
             -9.9136323928833, 5.8263373374938965, 228.5779266357422,
             0.001921099959872663, 0.000788060249760747, 0.00044191296910867095,
             -0.7071069478988647, 3.1235731512424536e-07, 2.6154634724662174e-06, 0.7071066498756409,
             -0.7070932984352112, -0.004375869873911142, 0.004375775810331106, 0.7070931792259216,
             -0.0072080534882843494, -0.0072080534882843494, -0.0072080534882843494
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '口禾髎',
             '人体/手阳明大肠经/口禾髎',
             0.06690993160009384, 9.115236282348633, 230.89804077148438,
             -0.007543766405433416, -0.0024612790439277887, -0.0017675550188869238,
             -5.960464477539063e-08, 2.135708655259805e-06, -2.411297828075476e-10, 1.0,
             5.139732389691787e-12, -5.608423170322396e-10, 0.0061867195181548595, 0.9999808669090271,
             -0.0072080534882843494, -0.0072080534882843494, -0.0072080534882843494
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '合谷',
             '人体/手阳明大肠经/合谷',
             -12.074713706970215, 5.743849754333496, 228.7691192626953,
             0.0039779446087777615, 0.0008920703548938036, 0.00025984254898503423,
             -0.7071069478988647, 3.1235731512424536e-07, 2.6154634724662174e-06, 0.7071066498756409,
             -0.7070932984352112, -0.004375869873911142, 0.004375775810331106, 0.7070931792259216,
             -0.0072080534882843494, -0.0072080534882843494, -0.0072080534882843494
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '商阳',
             '人体/手阳明大肠经/商阳',
             -13.58314037322998, 5.627671718597412, 228.87855529785156,
             0.005412923637777567, 0.0010204702848568559, 0.0001556320785311982,
             -0.706971287727356, 0.004375426564365625, -0.004373916890472174, 0.7072151899337769,
             -0.7069847583770752, -3.5694597277924345e-10, -3.568227935346613e-10, 0.7072287797927856,
             -0.007208053022623062, -0.0072080534882843494, -0.007208053022623062
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '天鼎',
             '人体/手阳明大肠经/天鼎',
             -1.1489964723587036, 7.460627555847168, 229.39437866210938,
             -0.0064054629765450954, -0.0008714083232916892, -0.0003356261004228145,
             -0.7071069478988647, 3.1235731512424536e-07, 2.6154634724662174e-06, 0.7071066498756409,
             -0.7070932984352112, -0.004375869873911142, 0.004375775810331106, 0.7070931792259216,
             -0.0072080534882843494, -0.0072080534882843494, -0.0072080534882843494
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '巨骨_001',
             '人体/手阳明大肠经/巨骨_001',
             -2.877427101135254, 7.4223809242248535, 228.32998657226562,
             -0.004760080017149448, -0.0008146234322339296, 0.0006779906107112765,
             -0.7071069478988647, 3.1235731512424536e-07, 2.6154634724662174e-06, 0.7071066498756409,
             -0.7070932984352112, -0.004375869873911142, 0.004375775810331106, 0.7070931792259216,
             -0.0072080534882843494, -0.0072080534882843494, -0.0072080534882843494
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '手三里',
             '人体/手阳明大肠经/手三里',
             -7.164808750152588, 6.4154052734375, 228.5287628173828,
             -0.0006894321413710713, 0.0001947516720974818, 0.000488713092636317,
             -0.7071069478988647, 3.1235731512424536e-07, 2.6154634724662174e-06, 0.7071066498756409,
             -0.7070932984352112, -0.004375869873911142, 0.004375775810331106, 0.7070931792259216,
             -0.0072080534882843494, -0.0072080534882843494, -0.0072080534882843494
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '手五里',
             '人体/手阳明大肠经/手五里',
             -5.79446268081665, 6.762911796569824, 228.68930053710938,
             -0.001990201650187373, -0.0001522960519650951, 0.0003358235990162939,
             -0.7071069478988647, 3.1235731512424536e-07, 2.6154634724662174e-06, 0.7071066498756409,
             -0.7070932984352112, -0.004375869873911142, 0.004375775810331106, 0.7070931792259216,
             -0.0072080534882843494, -0.0072080534882843494, -0.0072080534882843494
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '扶突',
             '人体/手阳明大肠经/扶突',
             -0.6677142977714539, 8.268889427185059, 229.4912872314453,
             -0.006854224018752575, -0.0016467188252136111, -0.00042791239684447646,
             -5.960464477539063e-08, 2.135708655259805e-06, -2.411297828075476e-10, 1.0,
             5.139732389691787e-12, -5.608423170322396e-10, 0.0061867195181548595, 0.9999808669090271,
             -0.0072080534882843494, -0.0072080534882843494, -0.0072080534882843494
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '曲池',
             '人体/手阳明大肠经/曲池',
             -6.4821929931640625, 6.411806106567383, 228.94039916992188,
             -0.0013394701527431607, 0.0001901354844449088, 9.671014413470402e-05,
             -0.7071069478988647, 3.1235731512424536e-07, 2.6154634724662174e-06, 0.7071066498756409,
             -0.7070932984352112, -0.004375869873911142, 0.004375775810331106, 0.7070931792259216,
             -0.0072080534882843494, -0.0072080534882843494, -0.0072080534882843494
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '温溜',
             '人体/手阳明大肠经/温溜',
             -9.187788009643555, 6.017096042633057, 228.5164794921875,
             0.0012321867980062962, 0.0005978647386655211, 0.0005004246486350894,
             -0.7071069478988647, 3.1235731512424536e-07, 2.6154634724662174e-06, 0.7071066498756409,
             -0.7070932984352112, -0.004375869873911142, 0.004375775810331106, 0.7070931792259216,
             -0.0072080534882843494, -0.0072080534882843494, -0.0072080534882843494
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '肘髎',
             '人体/手阳明大肠经/肘髎',
             -6.231334209442139, 6.6824445724487305, 228.6929168701172,
             -0.0015751540195196867, -7.052609726088122e-05, 0.0003323879500385374,
             -0.7071069478988647, 3.1235731512424536e-07, 2.6154634724662174e-06, 0.7071066498756409,
             -0.7070932984352112, -0.004375869873911142, 0.004375775810331106, 0.7070931792259216,
             -0.0072080534882843494, -0.0072080534882843494, -0.0072080534882843494
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '肩髃_001',
             '人体/手阳明大肠经/肩髃_001',
             -3.841064929962158, 7.4766364097595215, 228.55043029785156,
             -0.0038418485783040524, -0.0008549325866624713, 0.00046805987949483097,
             -0.7026671767234802, 2.6548777896096e-06, 2.5860754249151796e-07, 0.7115186452865601,
             -0.702653706073761, -0.004346069414168596, 0.00440072501078248, 0.711505115032196,
             -0.0072080534882843494, -0.0072080534882843494, -0.007208053953945637
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '臂臑',
             '人体/手阳明大肠经/臂臑',
             -4.792239189147949, 7.006450653076172, 228.63320922851562,
             -0.0029416652396321297, -0.00039600650779902935, 0.0003892340755555779,
             -5.960464477539063e-08, 2.135708655259805e-06, -2.411297828075476e-10, 1.0,
             5.139732389691787e-12, -5.608423170322396e-10, 0.0061867195181548595, 0.9999808669090271,
             -0.0072080534882843494, -0.0072080534882843494, -0.0072080534882843494
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '迎香',
             '人体/手阳明大肠经/迎香',
             0.2592839002609253, 9.18298625946045, 230.8134002685547,
             -0.007726150564849377, -0.0025280595291405916, -0.0016869478859007359,
             -5.960464477539063e-08, 2.135708655259805e-06, -2.411297828075476e-10, 1.0,
             5.139732389691787e-12, -5.608423170322396e-10, 0.0061867195181548595, 0.9999808669090271,
             -0.0072080534882843494, -0.0072080534882843494, -0.0072080534882843494
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '阳溪',
             '人体/手阳明大肠经/阳溪',
             -11.520537376403809, 5.742618083953857, 228.5874481201172,
             0.0034502344205975533, 0.0008867133874446154, 0.0004328422946855426,
             -0.7071069478988647, 3.1235731512424536e-07, 2.6154634724662174e-06, 0.7071066498756409,
             -0.7070932984352112, -0.004375869873911142, 0.004375775810331106, 0.7070931792259216,
             -0.0072080534882843494, -0.0072080534882843494, -0.0072080534882843494
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '上星穴',
             '人体/督脉/上星穴',
             0.0018845376325771213, 11.264492988586426, 230.6742706298828,
             -7.306635325221578e-06, 0.001788347028195858, -0.0032354455906897783,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '中枢',
             '人体/督脉/中枢',
             -3.7689457599299203e-07, 2.852283000946045, 227.2665557861328,
             -5.634129138343269e-06, -0.0012327826116234064, 0.0042298478074371815,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '兑端',
             '人体/督脉/兑端',
             -3.7689457599299203e-07, 9.135457038879395, 230.86460876464844,
             -5.634129138343269e-06, 0.00195788755081594, -0.0013463866198435426,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '前顶',
             '人体/督脉/前顶',
             -0.01242294441908598, 11.753588676452637, 229.91714477539062,
             5.388557838159613e-06, 0.0011163913877680898, -0.0036691941786557436,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '后顶',
             '人体/督脉/后顶',
             -3.7689457599299203e-07, 10.520584106445312, 227.9036865234375,
             -5.634129138343269e-06, -0.0006697886274196208, -0.002574518322944641,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '命门',
             '人体/督脉/命门',
             -3.7689457599299203e-07, 1.0786679983139038, 227.06785583496094,
             -5.634129138343269e-06, -0.0014085376169532537, 0.005803657695651054,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '哑门',
             '人体/督脉/哑门',
             -3.7689457599299203e-07, 8.858708381652832, 227.95297241210938,
             -5.634129138343269e-06, -0.0006255527259781957, -0.0010999321239069104,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '囟会',
             '人体/督脉/囟会',
             0.0018845376325771213, 11.462355613708496, 230.46778869628906,
             -7.306635325221578e-06, 0.0016050798585638404, -0.0034109491389244795,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '大椎',
             '人体/督脉/大椎',
             -0.05904166027903557, 7.299627304077148, 227.39292907714844,
             4.675388117902912e-05, -0.0011220051674172282, 0.000283629895420745,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '强间',
             '人体/督脉/强间',
             -3.7689457599299203e-07, 10.106426239013672, 227.85061645507812,
             -5.634129138343269e-06, -0.0007167471922002733, -0.002207015175372362,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '悬枢',
             '人体/督脉/悬枢',
             0.009611276909708977, 1.5252785682678223, 227.1527099609375,
             -1.4162659681460354e-05, -0.001333388383500278, 0.005407348740845919,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '水沟',
             '人体/督脉/水沟',
             -3.7689457599299203e-07, 9.1970853805542, 231.01394653320312,
             -5.634129138343269e-06, 0.002090384718030691, -0.0014011162566021085,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '灵台',
             '人体/督脉/灵台',
             0.01840306632220745, 4.888092517852783, 227.11965942382812,
             -2.1963714971207082e-05, -0.0013637383235618472, 0.0024234959855675697,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '百会',
             '人体/督脉/百会',
             -3.7689457599299203e-07, 11.814977645874023, 229.50103759765625,
             -5.634129138343269e-06, 0.0007471658173017204, -0.0037235384806990623,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '神庭',
             '人体/督脉/神庭',
             -3.7689457599299203e-07, 10.33032512664795, 230.94085693359375,
             -5.634129138343269e-06, 0.0020251863170415163, -0.002406629966571927,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '神道',
             '人体/督脉/神道',
             0.01919068582355976, 5.39201545715332, 227.07481384277344,
             -2.2662579794996418e-05, -0.0014036946231499314, 0.001976372441276908,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '筋缩',
             '人体/督脉/筋缩',
             -3.7689457599299203e-07, 3.4042279720306396, 227.27610778808594,
             -5.634129138343269e-06, -0.0012244631070643663, 0.003740097861737013,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '素髎',
             '人体/督脉/素髎',
             -0.002266170224174857, 9.307178497314453, 231.1005859375,
             -3.623664269980509e-06, 0.002167221624404192, -0.0014988291077315807,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '脊中',
             '人体/督脉/脊中',
             -3.7689457599299203e-07, 2.3813724517822266, 227.2238006591797,
             -5.634129138343269e-06, -0.001270565204322338, 0.004647705238312483,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '脑户',
             '人体/督脉/脑户',
             -3.7689457599299203e-07, 9.600828170776367, 227.90475463867188,
             -5.634129138343269e-06, -0.0006685632397420704, -0.0017584084998816252,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '腰俞',
             '人体/督脉/腰俞',
             -3.7689457599299203e-07, -2.0905003547668457, 226.71151733398438,
             -5.634129138343269e-06, -0.0017237584106624126, 0.008615805767476559,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '腰阳关',
             '人体/督脉/腰阳关',
             -7.130437893465569e-07, -0.01552128791809082, 226.78707885742188,
             -5.6338308240810875e-06, -0.0016573382308706641, 0.006774629931896925,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '至阳',
             '人体/督脉/至阳',
             -0.006756781134754419, 4.4179277420043945, 227.2022247314453,
             3.6090611388317484e-07, -0.0012903377646580338, 0.0028406530618667603,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '身柱',
             '人体/督脉/身柱',
             0.008601980283856392, 6.376496315002441, 227.1563720703125,
             -1.326709934801329e-05, -0.0013316210824996233, 0.0011028068838641047,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '长强',
             '人体/督脉/长强',
             -0.019981076940894127, -3.356271266937256, 227.51287841796875,
             1.2094974408682901e-05, -0.0010123137617483735, 0.009738693945109844,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '陶道',
             '人体/督脉/陶道',
             -0.02386409416794777, 6.841480255126953, 227.25604248046875,
             1.55404213728616e-05, -0.001243332400918007, 0.000690190470777452,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '风府_001',
             '人体/督脉/风府_001',
             -3.7689457599299203e-07, 9.297185897827148, 227.94798278808594,
             -5.634129138343269e-06, -0.0006301099783740938, -0.0014889966696500778,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '龈交',
             '人体/督脉/龈交',
             0.0022634011693298817, 9.003049850463867, 230.79444885253906,
             -7.642805030627642e-06, 0.001895676483400166, -0.0012288785073906183,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.0067162285558879375, -0.0067162285558879375, -0.0067162285558879375
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '中封',
             '人体/足厥肝阴经/中封',
             -1.1672106981277466, -2.9168365001678467, 229.59934997558594,
             0.16246259212493896, -0.056567128747701645, 0.5466724038124084,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '中都',
             '人体/足厥肝阴经/中都',
             -1.418090581893921, -6.996306896209717, 228.3474578857422,
             0.12931771576404572, 0.10864132642745972, 0.0076580047607421875,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '大敦',
             '人体/足厥肝阴经/大敦',
             -1.5225739479064941, 3.8291079998016357, 229.8175506591797,
             0.11551393568515778, -0.08508756756782532, 1.4379196166992188,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '太冲',
             '人体/足厥肝阴经/太冲',
             -1.3154780864715576, -2.2506823539733887, 229.64346313476562,
             0.1428743153810501, -0.06236335262656212, 0.6346830129623413,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '急脉',
             '人体/足厥肝阴经/急脉',
             -4.7493462562561035, -18.704700469970703, 229.9808807373047,
             -0.3107895851135254, -0.10769292712211609, -1.539116621017456,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '曲泉',
             '人体/足厥肝阴经/曲泉',
             -2.6657679080963135, -11.33648681640625, 228.4539794921875,
             -0.0355185866355896, 0.09436876326799393, -0.5657380819320679,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '期门_002',
             '人体/足厥肝阴经/期门_002',
             -4.661075115203857, -19.34830665588379, 231.50070190429688,
             -0.2991276979446411, -0.308512419462204, -1.6240769624710083,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '章门',
             '人体/足厥肝阴经/章门',
             -4.61251163482666, -19.109020233154297, 230.95376586914062,
             -0.2927117943763733, -0.23624245822429657, -1.5924888849258423,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '膝关',
             '人体/足厥肝阴经/膝关',
             -2.3329219818115234, -9.764678955078125, 228.78875732421875,
             0.008455180563032627, 0.05021223798394203, -0.35806411504745483,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '蠡沟',
             '人体/足厥肝阴经/蠡沟',
             -1.239420771598816, -3.3384737968444824, 229.6897735595703,
             0.1529226005077362, -0.06853152811527252, 0.49097201228141785,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '行间',
             '人体/足厥肝阴经/行间',
             -1.9554439783096313, 1.449592113494873, 228.082763671875,
             0.05832551792263985, 0.1439955234527588, 1.1234718561172485,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '足五里',
             '人体/足厥肝阴经/足五里',
             -3.829686403274536, -15.698677062988281, 229.3081817626953,
             -0.1892891526222229, -0.018681878224015236, -1.1420080661773682,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '阴包',
             '人体/足厥肝阴经/阴包',
             -3.5586998462677, -14.78304386138916, 229.31858825683594,
             -0.153487890958786, -0.02001502551138401, -1.0210388898849487,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '阴廉',
             '人体/足厥肝阴经/阴廉',
             -4.316277980804443, -18.75752067565918, 229.15426635742188,
             -0.25357499718666077, 0.0015127754304558039, -1.5461326837539673,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '_至阴',
             '人体/足太阳膀胱经/_至阴',
             -5.506965160369873, -19.674659729003906, 231.5364990234375,
             -0.07667787373065948, -0.06594846397638321, -0.37460482120513916,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '三焦俞',
             '人体/足太阳膀胱经/三焦俞',
             -0.2495666742324829, 2.518974781036377, 227.15670776367188,
             0.024679813534021378, 0.018637266010046005, 0.05323838070034981,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '上髎',
             '人体/足太阳膀胱经/上髎',
             -0.14972424507141113, -1.0580062866210938, 226.55355834960938,
             0.026604680344462395, 0.030241627246141434, -0.015726450830698013,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '下髎',
             '人体/足太阳膀胱经/下髎',
             -0.13074585795402527, -1.9161462783813477, 226.5775909423828,
             0.02697056718170643, 0.029772762209177017, -0.032270412892103195,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '中膂俞',
             '人体/足太阳膀胱经/中膂俞',
             -0.5473363995552063, -1.795527458190918, 226.38323974609375,
             0.018939094617962837, 0.033520448952913284, -0.02994629740715027,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '中髎',
             '人体/足太阳膀胱经/中髎',
             -0.08100903779268265, -1.613835334777832, 226.5819091796875,
             0.02792944572865963, 0.029691467061638832, -0.026442117989063263,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '五处',
             '人体/足太阳膀胱经/五处',
             -0.2435292899608612, 11.101947784423828, 230.67263793945312,
             0.02479620836675167, -0.049089327454566956, 0.21873340010643005,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '京骨',
             '人体/足太阳膀胱经/京骨',
             -5.381598472595215, -19.332000732421875, 230.09535217285156,
             -0.07426092773675919, -0.03816239908337593, -0.36800825595855713,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '仆参_001',
             '人体/足太阳膀胱经/仆参_001',
             -5.215799331665039, -19.44356346130371, 228.68841552734375,
             -0.07106447219848633, -0.011038709431886673, -0.37016841769218445,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '会阳',
             '人体/足太阳膀胱经/会阳',
             -0.21262288093566895, -2.264021873474121, 226.5939178466797,
             0.02539205551147461, 0.029455475509166718, -0.03897701948881149,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '关元俞',
             '人体/足太阳膀胱经/关元俞',
             -0.38288941979408264, 0.27517879009246826, 226.8316650390625,
             0.02210947684943676, 0.02488885074853897, 0.009977953508496284,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '厥阴俞',
             '人体/足太阳膀胱经/厥阴俞',
             -0.3047366440296173, 6.1772356033325195, 226.9810791015625,
             0.023616189137101173, 0.022047804668545723, 0.12376502901315689,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '合阳',
             '人体/足太阳膀胱经/合阳',
             -3.351388692855835, -11.491782188415527, 227.63563537597656,
             -0.035120390355587006, 0.009310757741332054, -0.21687258780002594,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '大杼',
             '人体/足太阳膀胱经/大杼',
             -0.11854338645935059, 7.646468639373779, 227.49069213867188,
             0.0272058192640543, 0.012232470326125622, 0.15209385752677917,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '大肠俞',
             '人体/足太阳膀胱经/大肠俞',
             -0.3305959403514862, 0.7130109071731567, 226.9921417236328,
             0.02311764657497406, 0.021798025816679, 0.018420010805130005,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '天柱',
             '人体/足太阳膀胱经/天柱',
             -0.10440078377723694, 8.545665740966797, 227.90052795410156,
             0.027478475123643875, 0.004337206017225981, 0.16943223774433136,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '委中',
             '人体/足太阳膀胱经/委中',
             -3.1419789791107178, -10.497076034545898, 227.9942169189453,
             -0.03108316659927368, 0.002404278377071023, -0.19769322872161865,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '委阳',
             '人体/足太阳膀胱经/委阳',
             -3.6108102798461914, -10.278948783874512, 228.09097290039062,
             -0.04012179374694824, 0.000540368549991399, -0.19348730146884918,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '小肠俞',
             '人体/足太阳膀胱经/小肠俞',
             -0.3843390941619873, -0.3366185426712036, 226.6126708984375,
             0.02208152785897255, 0.02910700812935829, -0.001818380318582058,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '心俞',
             '人体/足太阳膀胱经/心俞',
             -0.3140902817249298, 5.783308506011963, 226.92562866210938,
             0.023435859009623528, 0.023114189505577087, 0.11617011576890945,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '志室',
             '人体/足太阳膀胱经/志室',
             -0.6744890213012695, 1.8088243007659912, 227.10565185546875,
             0.016487712040543556, 0.019616812467575073, 0.039547014981508255,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '意舍',
             '人体/足太阳膀胱经/意舍',
             -0.6926271319389343, 3.396538496017456, 226.98704528808594,
             0.016138024628162384, 0.021914109587669373, 0.07015585154294968,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '承光',
             '人体/足太阳膀胱经/承光',
             -0.3537493348121643, 11.544965744018555, 230.0690155029297,
             0.02267126925289631, -0.03744920715689659, 0.22727034986019135,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '承山',
             '人体/足太阳膀胱经/承山',
             -3.6620140075683594, -13.964644432067871, 227.67906188964844,
             -0.041108954697847366, 0.008457315154373646, -0.26454678177833557,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '承扶',
             '人体/足太阳膀胱经/承扶',
             -1.556270718574524, -3.3222079277038574, 226.91180419921875,
             -0.0005122089060023427, 0.02332008257508278, -0.059375736862421036,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '承筋',
             '人体/足太阳膀胱经/承筋',
             -3.452378988265991, -12.56463623046875, 227.51394653320312,
             -0.037067387253046036, 0.01164978463202715, -0.23755702376365662,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '攒竹',
             '人体/足太阳膀胱经/攒竹',
             -0.07474533468484879, 10.4102783203125, 230.95420837402344,
             0.028050202876329422, -0.05452241003513336, 0.20540055632591248,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '昆仑',
             '人体/足太阳膀胱经/昆仑',
             -4.88338041305542, -18.249746322631836, 228.25775146484375,
             -0.06465575098991394, -0.0027278612833470106, -0.3471556007862091,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '曲差',
             '人体/足太阳膀胱经/曲差',
             -0.2857007682323456, 10.859329223632812, 230.7990264892578,
             0.02398318238556385, -0.05152752250432968, 0.21405678987503052,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '束骨',
             '人体/足太阳膀胱经/束骨',
             -5.456748962402344, -19.44610595703125, 230.4293212890625,
             -0.0757097527384758, -0.044601764529943466, -0.37020590901374817,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '次髎',
             '人体/足太阳膀胱经/次髎',
             -0.08475994318723679, -1.3257761001586914, 226.58233642578125,
             0.027857132256031036, 0.029685040935873985, -0.02088860049843788,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '殷门',
             '人体/足太阳膀胱经/殷门',
             -2.0545156002044678, -4.942361354827881, 227.1509246826172,
             -0.010117902420461178, 0.018699193373322487, -0.09060917049646378,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '气海俞',
             '人体/足太阳膀胱经/气海俞',
             -0.29579687118530273, 1.2625805139541626, 227.11233520507812,
             0.023788537830114365, 0.01948443427681923, 0.02901599183678627,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '浮郄',
             '人体/足太阳膀胱经/浮郄',
             -3.4309098720550537, -9.498129844665527, 228.19656372070312,
             -0.03665348142385483, -0.001489939633756876, -0.1784331351518631,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '玉枕',
             '人体/足太阳膀胱经/玉枕',
             -0.19031976163387299, 9.328190803527832, 227.98260498046875,
             0.02582203783094883, 0.0027600594330579042, 0.18451915681362152,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '申脉_001',
             '人体/足太阳膀胱经/申脉_001',
             -5.177722454071045, -18.88446807861328, 229.32373046875,
             -0.07033038139343262, -0.023283323273062706, -0.3593854010105133,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '白环俞',
             '人体/足太阳膀胱经/白环俞',
             -0.14430861175060272, -0.4411851167678833, 226.65318298339844,
             0.026709089055657387, 0.028325237333774567, -0.0038340543396770954,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '眉冲',
             '人体/足太阳膀胱经/眉冲',
             -0.07132123410701752, 10.864808082580566, 230.86651611328125,
             0.028116216883063316, -0.0528288297355175, 0.21416285634040833,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '睛明_001',
             '人体/足太阳膀胱经/睛明_001',
             -0.12242960929870605, 10.112665176391602, 230.86976623535156,
             0.027130896225571632, -0.05289628356695175, 0.19966228306293488,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '督俞',
             '人体/足太阳膀胱经/督俞',
             -0.317501425743103, 5.537327766418457, 226.91087341308594,
             0.02337009459733963, 0.023396816104650497, 0.11142774671316147,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '神堂',
             '人体/足太阳膀胱经/神堂',
             -0.6573810577392578, 5.712756156921387, 226.80978393554688,
             0.01681753620505333, 0.02534695528447628, 0.11480917036533356,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '秩边',
             '人体/足太阳膀胱经/秩边',
             -1.1654912233352661, -1.8111982345581055, 226.4131317138672,
             0.007021651137620211, 0.032943930476903915, -0.030248211696743965,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '络却',
             '人体/足太阳膀胱经/络却',
             -0.3379803001880646, 11.6414794921875, 228.8784942626953,
             0.02297528274357319, -0.01449635624885559, 0.22912311553955078,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '肓门',
             '人体/足太阳膀胱经/肓门',
             -0.6630476713180542, 2.3876914978027344, 227.07806396484375,
             0.016708288341760635, 0.020152622833848, 0.05070684477686882,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '肝俞',
             '人体/足太阳膀胱经/肝俞',
             -0.3027663230895996, 4.629189968109131, 227.02670288085938,
             0.02365417405962944, 0.021157825365662575, 0.09392046928405762,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '肺俞',
             '人体/足太阳膀胱经/肺俞',
             -0.24345608055591583, 6.602863788604736, 227.10162353515625,
             0.024797620251774788, 0.01972637139260769, 0.1319715529680252,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '肾俞',
             '人体/足太阳膀胱经/肾俞',
             -0.27935120463371277, 1.9661005735397339, 227.1553955078125,
             0.02410559542477131, 0.01865903101861477, 0.04257947951555252,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '胃仓',
             '人体/足太阳膀胱经/胃仓',
             -0.6846231818199158, 2.9746909141540527, 227.07778930664062,
             0.016292333602905273, 0.02016184851527214, 0.06202362850308418,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '胃俞',
             '人体/足太阳膀胱经/胃俞',
             -0.3085687458515167, 3.2098474502563477, 227.12139892578125,
             0.023542309179902077, 0.019322700798511505, 0.06655752658843994,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '胆俞',
             '人体/足太阳膀胱经/胆俞',
             -0.2936861217021942, 4.2204670906066895, 227.07106018066406,
             0.023829231038689613, 0.0202998798340559, 0.08604097366333008,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '胞肓',
             '人体/足太阳膀胱经/胞肓',
             -1.1058871746063232, -0.8259122371673584, 226.4986572265625,
             0.008170762099325657, 0.031301822513341904, -0.011252259835600853,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '脾俞',
             '人体/足太阳膀胱经/脾俞',
             -0.30099979043006897, 3.707306385040283, 227.10667419433594,
             0.02368823066353798, 0.019609715789556503, 0.07614795863628387,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '膀胱俞',
             '人体/足太阳膀胱经/膀胱俞',
             -0.546908974647522, -0.9620323181152344, 226.41281127929688,
             0.018947333097457886, 0.03295571357011795, -0.01387709565460682,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '膈俞',
             '人体/足太阳膀胱经/膈俞',
             -0.3198051452636719, 5.170279026031494, 226.9220428466797,
             0.023325681686401367, 0.02317914180457592, 0.1043514683842659,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '膈关',
             '人体/足太阳膀胱经/膈关',
             -0.700619101524353, 4.719305992126465, 226.88043212890625,
             0.01598394848406315, 0.023978430777788162, 0.0956568494439125,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '膏肓',
             '人体/足太阳膀胱经/膏肓',
             -0.6363658905029297, 6.234206199645996, 226.88218688964844,
             0.0172226894646883, 0.023954471573233604, 0.12486271560192108,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '譩譆',
             '人体/足太阳膀胱经/譩譆',
             -0.6710003614425659, 5.211061954498291, 226.79991149902344,
             0.016554970294237137, 0.02553408034145832, 0.10513690859079361,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '足通骨',
             '人体/足太阳膀胱经/足通骨',
             -5.537668704986572, -19.521068572998047, 230.75558471679688,
             -0.07726981490850449, -0.05089220777153969, -0.3716489374637604,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '跗阳_001',
             '人体/足太阳膀胱经/跗阳_001',
             -4.525116443634033, -16.7369327545166, 228.08871459960938,
             -0.05774874985218048, 0.0005411851452663541, -0.31799113750457764,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '通天',
             '人体/足太阳膀胱经/通天',
             -0.39757663011550903, 11.712493896484375, 229.50286865234375,
             0.02182632125914097, -0.026533393189311028, 0.230496346950531,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '金门_001',
             '人体/足太阳膀胱经/金门_001',
             -5.318445205688477, -19.23741912841797, 229.76229858398438,
             -0.07304339110851288, -0.031740691512823105, -0.3661870062351227,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '阳纲',
             '人体/足太阳膀胱经/阳纲',
             -0.6770055890083313, 3.82791805267334, 227.02542114257812,
             0.016439193859696388, 0.02117708884179592, 0.07847269624471664,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '附分',
             '人体/足太阳膀胱经/附分',
             -0.5403085350990295, 7.294309139251709, 227.2129364013672,
             0.019074585288763046, 0.01758519932627678, 0.1453026980161667,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '风门',
             '人体/足太阳膀胱经/风门',
             -0.208461731672287, 7.116209030151367, 227.244140625,
             0.025472277775406837, 0.016982438042759895, 0.14186930656433105,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '飞扬',
             '人体/足太阳膀胱经/飞扬',
             -4.370913028717041, -14.453226089477539, 227.7040557861328,
             -0.05477585643529892, 0.007972014136612415, -0.273965984582901,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '魂门',
             '人体/足太阳膀胱经/魂门',
             -0.6701652407646179, 4.242534160614014, 226.97166442871094,
             0.01657106913626194, 0.022216398268938065, 0.0864657461643219,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '魄户',
             '人体/足太阳膀胱经/魄户',
             -0.6117022037506104, 6.784217834472656, 227.06874084472656,
             0.01769818179309368, 0.020361732691526413, 0.13546766340732574,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.1459268182516098, 0.1459268182516098, 0.1459268182516098
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '三阴交',
             '人体/足太阴脾经/三阴交',
             -4.051509857177734, -17.264862060546875, 228.72410583496094,
             -0.009688688442111015, 0.006991371512413025, -0.07475761324167252,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.049572233110666275, 0.049572233110666275, 0.049572233110666275
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '公孙',
             '人体/足太阴脾经/公孙',
             -4.3889923095703125, -19.344532012939453, 229.80487060546875,
             -0.011898931115865707, -9.14573683985509e-05, -0.08837536722421646,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.049572233110666275, 0.049572233110666275, 0.049572233110666275
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '冲门',
             '人体/足太阴脾经/冲门',
             -1.2989227771759033, -2.515259265899658, 229.6493682861328,
             0.008338592946529388, 0.0009649634012021124, 0.021842772141098976,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.049572233110666275, 0.049572233110666275, 0.049572233110666275
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '周荣',
             '人体/足太阴脾经/周荣',
             -1.7646057605743408, 6.097523212432861, 230.06443786621094,
             0.005288735497742891, -0.001733928918838501, 0.07825066149234772,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.049572233110666275, 0.049572233110666275, 0.049572233110666275
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '商丘',
             '人体/足太阴脾经/商丘',
             -4.329538345336914, -19.062641143798828, 229.21046447753906,
             -0.011509556323289871, 0.0038020440842956305, -0.08653055131435394,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.049572233110666275, 0.049572233110666275, 0.049572233110666275
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '地机',
             '人体/足太阴脾经/地机',
             -3.2841997146606445, -14.44573974609375, 228.70474243164062,
             -0.004663408733904362, 0.007124593015760183, -0.05629462003707886,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.049572233110666275, 0.049572233110666275, 0.049572233110666275
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '大包',
             '人体/足太阴脾经/大包',
             -2.2502057552337646, 4.104438781738281, 228.76454162597656,
             0.0021084377076476812, 0.006774873472750187, 0.06519458442926407,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.049572233110666275, 0.049572233110666275, 0.049572233110666275
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '大横_002',
             '人体/足太阴脾经/大横_002',
             -1.6200883388519287, 1.3215185403823853, 229.3464813232422,
             0.006235209759324789, 0.0029573545325547457, 0.04696996510028839,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.049572233110666275, 0.049572233110666275, 0.049572233110666275
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '大都',
             '人体/足太阴脾经/大都',
             -4.197723388671875, -19.52838897705078, 231.00759887695312,
             -0.010646272450685501, -0.007968772202730179, -0.08957676589488983,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.049572233110666275, 0.049572233110666275, 0.049572233110666275
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '天溪',
             '人体/足太阴脾经/天溪',
             -1.951491355895996, 5.034363269805908, 229.99705505371094,
             0.004064781591296196, -0.001294987159781158, 0.07128764688968658,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.049572233110666275, 0.049572233110666275, 0.049572233110666275
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '太白',
             '人体/足太阴脾经/太白',
             -4.291520118713379, -19.412961959838867, 230.48422241210938,
             -0.0112605644389987, -0.004540796857327223, -0.08882199972867966,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.049572233110666275, 0.049572233110666275, 0.049572233110666275
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '府舍',
             '人体/足太阴脾经/府舍',
             -1.7233210802078247, -1.7969017028808594, 229.70399475097656,
             0.005559117533266544, 0.0006088929949328303, 0.026547571644186974,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.049572233110666275, 0.049572233110666275, 0.049572233110666275
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '漏谷',
             '人体/足太阴脾经/漏谷',
             -3.635993003845215, -15.706422805786133, 228.73435974121094,
             -0.006967378314584494, 0.006927731446921825, -0.06455104798078537,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.049572233110666275, 0.049572233110666275, 0.049572233110666275
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '箕门',
             '人体/足太阴脾经/箕门',
             -1.6403863430023193, -4.434707164764404, 230.09219360351562,
             0.006102274637669325, -0.0019395166309550405, 0.009272901341319084,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.049572233110666275, 0.049572233110666275, 0.049572233110666275
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '胸乡',
             '人体/足太阴脾经/胸乡',
             -1.8988879919052124, 5.551613807678223, 230.04393005371094,
             0.004409292712807655, -0.0016008340753614902, 0.07467533648014069,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.049572233110666275, 0.049572233110666275, 0.049572233110666275
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '腹哀',
             '人体/足太阴脾经/腹哀',
             -1.6491577625274658, 2.508202075958252, 229.55853271484375,
             0.006044828798621893, 0.0015712802996858954, 0.05474228411912918,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.049572233110666275, 0.049572233110666275, 0.049572233110666275
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '腹结',
             '人体/足太阴脾经/腹结',
             -1.5225090980529785, 0.5313059091567993, 229.42526245117188,
             0.006874278653413057, 0.0024395885411649942, 0.04179487004876137,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.049572233110666275, 0.049572233110666275, 0.049572233110666275
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '血海',
             '人体/足太阴脾经/血海',
             -2.8677191734313965, -8.863249778747559, 230.40728759765625,
             -0.0019357895944267511, -0.004013081081211567, -0.019729861989617348,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.049572233110666275, 0.049572233110666275, 0.049572233110666275
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '阴陵泉',
             '人体/足太阴脾经/阴陵泉',
             -2.8657283782958984, -12.348194122314453, 229.43142700195312,
             -0.0019227516604587436, 0.002370096743106842, -0.04255570471286774,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.049572233110666275, 0.049572233110666275, 0.049572233110666275
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '隐白',
             '人体/足太阴脾经/隐白',
             -4.282913684844971, -19.59220314025879, 231.81106567382812,
             -0.011204199865460396, -0.013231062330305576, -0.08999289572238922,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.049572233110666275, 0.049572233110666275, 0.049572233110666275
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '食窦',
             '人体/足太阴脾经/食窦',
             -1.9008206129074097, 4.538414001464844, 229.90625,
             0.004396635107696056, -0.0007014714647084475, 0.06803936511278152,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.049572233110666275, 0.049572233110666275, 0.049572233110666275
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '上关',
             '人体/足少阳胆经/上关',
             -1.0065727233886719, 9.88399600982666, 230.22775268554688,
             0.13924361765384674, -0.12163234502077103, 0.9717418551445007,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '丘墟',
             '人体/足少阳胆经/丘墟',
             -5.352354526519775, -19.150522232055664, 228.97280883789062,
             -0.4348973333835602, 0.04284175485372543, -2.864197254180908,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '中渎',
             '人体/足少阳胆经/中渎',
             -3.549699306488037, -4.945943355560303, 228.1637725830078,
             -0.19674034416675568, 0.1503739356994629, -0.9876027703285217,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '五枢_001',
             '人体/足少阳胆经/五枢_001',
             -1.1877483129501343, -0.18623077869415283, 229.7390594482422,
             0.11530768871307373, -0.05752812698483467, -0.35870376229286194,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '京门',
             '人体/足少阳胆经/京门',
             -1.4913837909698486, 2.750119686126709, 227.46426391601562,
             0.07519302517175674, 0.24313989281654358, 0.02912706322968006,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '侠溪',
             '人体/足少阳胆经/侠溪',
             -5.343574047088623, -19.39374542236328, 231.3602752685547,
             -0.43373724818229675, -0.2725886106491089, -2.896221876144409,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '光明',
             '人体/足少阳胆经/光明',
             -5.080841064453125, -15.699483871459961, 228.8658905029297,
             -0.39902645349502563, 0.057124264538288116, -2.4082698822021484,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '听会',
             '人体/足少阳胆经/听会',
             -0.9979841709136963, 9.511479377746582, 229.97254943847656,
             0.14037829637527466, -0.08793334662914276, 0.9225154519081116,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '地五会',
             '人体/足少阳胆经/地五会',
             -5.422008991241455, -19.16261863708496, 230.7384033203125,
             -0.4440997540950775, -0.19041922688484192, -2.8657150268554688,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '外丘',
             '人体/足少阳胆经/外丘',
             -4.8616414070129395, -14.440494537353516, 229.11903381347656,
             -0.37006697058677673, 0.02373746782541275, -2.2419273853302,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '天冲',
             '人体/足少阳胆经/天冲',
             -1.1608070135116577, 10.60427188873291, 229.67662048339844,
             0.11886703222990036, -0.04878551512956619, 1.0668758153915405,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '头临泣_001',
             '人体/足少阳胆经/头临泣_001',
             -0.4693099856376648, 10.79216194152832, 230.78237915039062,
             0.21022383868694305, -0.19486409425735474, 1.0917490720748901,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '头窍阴',
             '人体/足少阳胆经/头窍阴',
             -1.209363579750061, 10.034006118774414, 229.11111450195312,
             0.11245200783014297, 0.025900162756443024, 0.9915096163749695,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '完骨',
             '人体/足少阳胆经/完骨',
             -1.1116071939468384, 9.465520858764648, 229.2198944091797,
             0.12536704540252686, 0.01150218490511179, 0.9164091944694519,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '居髎_001',
             '人体/足少阳胆经/居髎_001',
             -2.798915147781372, -1.2942492961883545, 228.8887481689453,
             -0.0975508838891983, 0.05476033687591553, -0.5051279067993164,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '带脉_001',
             '人体/足少阳胆经/带脉_001',
             -2.0488898754119873, 1.5919404029846191, 228.26034545898438,
             0.0015383911086246371, 0.13791273534297943, -0.12384892255067825,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '悬厘',
             '人体/足少阳胆经/悬厘',
             -0.9869681000709534, 10.30445671081543, 230.2917022705078,
             0.14183367788791656, -0.13006171584129333, 1.0272938013076782,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '悬钟',
             '人体/足少阳胆经/悬钟',
             -5.127195835113525, -17.75874137878418, 228.72279357910156,
             -0.4051505923271179, 0.07593590766191483, -2.6803343296051025,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '悬颅',
             '人体/足少阳胆经/悬颅',
             -0.9312389492988586, 10.436088562011719, 230.39117431640625,
             0.1491963118314743, -0.14319656789302826, 1.0446889400482178,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '承灵_001',
             '人体/足少阳胆经/承灵_001',
             -0.6048587560653687, 11.59758186340332, 229.77288818359375,
             0.19231587648391724, -0.06145816668868065, 1.198110818862915,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '日月',
             '人体/足少阳胆经/日月',
             -1.0806490182876587, 3.7119503021240234, 229.9764862060547,
             0.12945705652236938, -0.08871753513813019, 0.15631349384784698,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '曲鬓',
             '人体/足少阳胆经/曲鬓',
             -1.0513358116149902, 10.15965461730957, 230.18368530273438,
             0.13332976400852203, -0.1157974973320961, 1.008158564567566,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '本神_001',
             '人体/足少阳胆经/本神_001',
             -0.6178686618804932, 10.5319242477417, 230.67515563964844,
             0.1905970722436905, -0.18070942163467407, 1.0573631525039673,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '正营_001',
             '人体/足少阳胆经/正营_001',
             -0.41323989629745483, 11.328185081481934, 230.41635131835938,
             0.2176315039396286, -0.14648200571537018, 1.1625488996505737,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '浮白',
             '人体/足少阳胆经/浮白',
             -1.2364872694015503, 10.428001403808594, 229.35360717773438,
             0.1088685616850853, -0.006120262201875448, 1.0435729026794434,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '渊腋',
             '人体/足少阳胆经/渊腋',
             -2.3895246982574463, 4.586308479309082, 228.50503540039062,
             -0.043464429676532745, 0.1057223379611969, 0.27176180481910706,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '率谷',
             '人体/足少阳胆经/率谷',
             -1.0260443687438965, 10.611482620239258, 230.03704833984375,
             0.13667114078998566, -0.09640441834926605, 1.0678447484970093,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '环跳',
             '人体/足少阳胆经/环跳',
             -2.600609064102173, -1.61643385887146, 227.36810302734375,
             -0.07135177403688431, 0.2556445002555847, -0.5477625131607056,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '目窗_001',
             '人体/足少阳胆经/目窗_001',
             -0.4166285991668701, 11.056634902954102, 230.62168884277344,
             0.21718382835388184, -0.17362356185913086, 1.1266825199127197,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '瞳子髎',
             '人体/足少阳胆经/瞳子髎',
             -0.7127792239189148, 9.948135375976562, 230.6271514892578,
             0.17805801331996918, -0.1743955910205841, 0.9802338480949402,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '维道_001',
             '人体/足少阳胆经/维道_001',
             -0.8499777913093567, -0.38985371589660645, 229.92803955078125,
             0.15993209183216095, -0.08250407874584198, -0.38559669256210327,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '肩井_001',
             '人体/足少阳胆经/肩井_001',
             -0.9565523266792297, 7.924272537231445, 227.69024658203125,
             0.14585204422473907, 0.21352161467075348, 0.7127182483673096,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '脑空_001',
             '人体/足少阳胆经/脑空_001',
             -1.0191826820373535, 10.400184631347656, 228.4408721923828,
             0.13757766783237457, 0.11446445435285568, 1.0398564338684082,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '膝阳关',
             '人体/足少阳胆经/膝阳关',
             -3.971186399459839, -8.418932914733887, 228.5553436279297,
             -0.252424955368042, 0.09848321974277496, -1.4464173316955566,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '足临泣',
             '人体/足少阳胆经/足临泣',
             -5.3670759201049805, -19.095767974853516, 230.02493286132812,
             -0.43684229254722595, -0.09615661203861237, -2.8569154739379883,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '足窍阴',
             '人体/足少阳胆经/足窍阴',
             -5.291817665100098, -19.473838806152344, 231.79483032226562,
             -0.4268995225429535, -0.3300043046474457, -2.90678334236145,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '辄筋',
             '人体/足少阳胆经/辄筋',
             -2.296159505844116, 4.348382472991943, 228.64288330078125,
             -0.03112953156232834, 0.08749999850988388, 0.24033454060554504,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '阳交_001',
             '人体/足少阳胆经/阳交_001',
             -4.91005277633667, -14.439495086669922, 228.3844451904297,
             -0.37646281719207764, 0.12078814208507538, -2.2418289184570312,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '阳白_001',
             '人体/足少阳胆经/阳白_001',
             -0.4799611568450928, 10.224102020263672, 230.79246520996094,
             0.20881667733192444, -0.19622325897216797, 1.0167007446289062,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '阳辅',
             '人体/足少阳胆经/阳辅',
             -5.1012282371521, -16.60516929626465, 228.70774841308594,
             -0.4017198979854584, 0.0779750645160675, -2.5279314517974854,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '阳陵泉',
             '人体/足少阳胆经/阳陵泉',
             -4.107560157775879, -10.02345085144043, 228.6073760986328,
             -0.2704419195652008, 0.09153594821691513, -1.6583951711654663,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '颔厌',
             '人体/足少阳胆经/颔厌',
             -0.827044665813446, 10.609116554260254, 230.53436279296875,
             0.16296188533306122, -0.16210521757602692, 1.0675548315048218,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '风市',
             '人体/足少阳胆经/风市',
             -3.385890007019043, -3.977985382080078, 228.11517333984375,
             -0.17509876191616058, 0.15683835744857788, -0.8597237467765808,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '风池_001',
             '人体/足少阳胆经/风池_001',
             -0.9755170941352844, 9.937214851379395, 228.3864288330078,
             0.14334651827812195, 0.12163738906383514, 0.9786888957023621,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '中注_001',
             '人体/足少阴肾经/中注_001',
             -0.802810549736023, 0.1713971495628357, 229.9875946044922,
             -0.0069403275847435, -0.010945877991616726, -0.04792366921901703,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.030319932848215103, 0.030319932848215103, 0.030319932848215103
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '俞府',
             '人体/足少阴肾经/俞府',
             -1.108959674835205, 6.205941200256348, 230.19259643554688,
             -0.008166670799255371, -0.011758693493902683, -0.02375078573822975,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.030319932848215103, 0.030319932848215103, 0.030319932848215103
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '商曲_001',
             '人体/足少阴肾经/商曲_001',
             -0.7395966053009033, 1.6228299140930176, 230.01107788085938,
             -0.006687111686915159, -0.01103791780769825, -0.04210962727665901,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.030319932848215103, 0.030319932848215103, 0.030319932848215103
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '四满_001',
             '人体/足少阴肾经/四满_001',
             -0.8250192403793335, -0.564340353012085, 229.98789978027344,
             -0.0070292893797159195, -0.010948123410344124, -0.05087081715464592,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.030319932848215103, 0.030319932848215103, 0.030319932848215103
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '大赫_001',
             '人体/足少阴肾经/大赫_001',
             -0.7795939445495605, -2.0456690788269043, 229.90089416503906,
             -0.006847328972071409, -0.010601630434393883, -0.05680469796061516,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.030319932848215103, 0.030319932848215103, 0.030319932848215103
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '幽门_001',
             '人体/足少阴肾经/幽门_001',
             -0.6361691951751709, 3.4224343299865723, 230.10350036621094,
             -0.006272811908274889, -0.01140566822141409, -0.034900814294815063,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.030319932848215103, 0.030319932848215103, 0.030319932848215103
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '彧中',
             '人体/足少阴肾经/彧中',
             -1.1279957294464111, 5.834217071533203, 230.31121826171875,
             -0.008242923766374588, -0.012234377674758434, -0.02523963898420334,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.030319932848215103, 0.030319932848215103, 0.030319932848215103
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '横骨_001',
             '人体/足少阴肾经/横骨_001',
             -0.7536703944206238, -2.8934426307678223, 229.61737060546875,
             -0.006743486970663071, -0.009467139840126038, -0.060201022773981094,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.030319932848215103, 0.030319932848215103, 0.030319932848215103
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '步廊',
             '人体/足少阴肾经/步廊',
             -1.1183439493179321, 4.031336784362793, 230.18704223632812,
             -0.008204260841012001, -0.011739468201994896, -0.03246161714196205,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.030319932848215103, 0.030319932848215103, 0.030319932848215103
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '气_001',
             '人体/足少阴肾经/气_001',
             -0.7914506196975708, -1.2454485893249512, 229.94937133789062,
             -0.0068948231637477875, -0.0107947438955307, -0.05359918996691704,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.030319932848215103, 0.030319932848215103, 0.030319932848215103
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '灵墟',
             '人体/足少阴肾经/灵墟',
             -1.138318657875061, 5.020893096923828, 230.43438720703125,
             -0.008284274488687515, -0.012728896923363209, -0.028497401624917984,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.030319932848215103, 0.030319932848215103, 0.030319932848215103
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '石关_001',
             '人体/足少阴肾经/石关_001',
             -0.7350215911865234, 2.1040291786193848, 230.05288696289062,
             -0.006668785586953163, -0.011204728856682777, -0.04018202796578407,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.030319932848215103, 0.030319932848215103, 0.030319932848215103
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '神封',
             '人体/足少阴肾经/神封',
             -1.1154297590255737, 4.565674781799316, 230.38233947753906,
             -0.00819258764386177, -0.012521045282483101, -0.030320944264531136,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.030319932848215103, 0.030319932848215103, 0.030319932848215103
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '神藏',
             '人体/足少阴肾经/神藏',
             -1.1523019075393677, 5.412830352783203, 230.41226196289062,
             -0.008340287022292614, -0.012639745138585567, -0.02692744880914688,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.030319932848215103, 0.030319932848215103, 0.030319932848215103
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '肓俞_001',
             '人体/足少阴肾经/肓俞_001',
             -0.7266978025436401, 0.7171783447265625, 230.0086669921875,
             -0.006635442841798067, -0.011029521003365517, -0.04573740065097809,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.030319932848215103, 0.030319932848215103, 0.030319932848215103
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '腹通谷',
             '人体/足少阴肾经/腹通谷',
             -0.6343093514442444, 2.9834156036376953, 230.0919647216797,
             -0.006265361327677965, -0.011360080912709236, -0.03665940836071968,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.030319932848215103, 0.030319932848215103, 0.030319932848215103
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '阴都_001',
             '人体/足少阴肾经/阴都_001',
             -0.7056225538253784, 2.5198378562927246, 230.0653839111328,
             -0.006551021244376898, -0.011254222132265568, -0.03851640224456787,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.030319932848215103, 0.030319932848215103, 0.030319932848215103
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '上巨虚',
             '人体/足阳明胃经/上巨虚',
             -4.4393229484558105, -12.985672950744629, 229.7334747314453,
             -0.03138982132077217, 0.004134891089051962, -0.15951956808567047,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '下关',
             '人体/足阳明胃经/下关',
             -0.9644037485122681, 9.77078914642334, 230.2844696044922,
             0.010135647840797901, -0.002355676842853427, 0.1124236211180687,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '下巨虚',
             '人体/足阳明胃经/下巨虚',
             -4.807048797607422, -14.9498291015625, 229.41885375976562,
             -0.03578416630625725, 0.007886393927037716, -0.182992622256279,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '不容',
             '人体/足阳明胃经/不容',
             -1.0194947719573975, 3.7446391582489014, 230.03775024414062,
             0.00947730801999569, 0.0005677473382093012, 0.04040980711579323,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '丰隆',
             '人体/足阳明胃经/丰隆',
             -4.957519054412842, -14.949421882629395, 229.0054168701172,
             -0.03758229315280914, 0.012827095575630665, -0.1829894632101059,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '乳中',
             '人体/足阳明胃经/乳中',
             -1.4835125207901, 5.153429985046387, 230.2978057861328,
             0.003932270687073469, -0.002534110564738512, 0.05724600329995155,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '乳根',
             '人体/足阳明胃经/乳根',
             -1.4990177154541016, 4.690032958984375, 230.2179412841797,
             0.0037469814997166395, -0.0015816722298040986, 0.051708053797483444,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '人迎',
             '人体/足阳明胃经/人迎',
             -0.32117486000061035, 8.148286819458008, 229.71987915039062,
             0.01782226748764515, 0.0043845283798873425, 0.09303230792284012,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '伏兔',
             '人体/足阳明胃经/伏兔',
             -3.0296237468719482, -7.05070686340332, 230.40074157714844,
             -0.01454384159296751, -0.003814618568867445, -0.08859366178512573,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '关门',
             '人体/足阳明胃经/关门',
             -0.9605076313018799, 1.7930809259414673, 229.96383666992188,
             0.010182206518948078, 0.001442897249944508, 0.0170882735401392,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '内庭',
             '人体/足阳明胃经/内庭',
             -4.945943832397461, -19.300033569335938, 231.37933349609375,
             -0.037443969398736954, -0.01555941067636013, -0.23496970534324646,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '冲阳',
             '人体/足阳明胃经/冲阳',
             -4.970057010650635, -18.8714656829834, 230.30352783203125,
             -0.037732116878032684, -0.002701532794162631, -0.22985276579856873,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '厉兑',
             '人体/足阳明胃经/厉兑',
             -4.832887172698975, -19.482051849365234, 232.0718536376953,
             -0.036092936992645264, -0.023835796862840652, -0.23714198172092438,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '四白',
             '人体/足阳明胃经/四白',
             -0.5082937479019165, 9.673221588134766, 230.69798278808594,
             0.015586186200380325, -0.0072976467199623585, 0.11125940084457397,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '地仓_001',
             '人体/足阳明胃经/地仓_001',
             -0.5208367109298706, 9.179112434387207, 230.63214111328125,
             0.015436297282576561, -0.006512808613479137, 0.10535448789596558,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '外陵',
             '人体/足阳明胃经/外陵',
             -0.9020859599113464, -0.7747402191162109, 229.851806640625,
             0.010880348272621632, 0.0027710688300430775, -0.013597787357866764,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '大巨',
             '人体/足阳明胃经/大巨',
             -0.9144269824028015, -1.432539463043213, 229.8359832763672,
             0.010732872411608696, 0.0029574621003121138, -0.021458586677908897,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '大迎',
             '人体/足阳明胃经/大迎',
             -0.6676921844482422, 8.696742057800293, 230.02789306640625,
             0.013681366108357906, 0.0007058489136397839, 0.09958765655755997,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '天枢',
             '人体/足阳明胃经/天枢',
             -0.8406189680099487, -0.061340928077697754, 229.87684631347656,
             0.01161488238722086, 0.0024747943971306086, -0.005072524305433035,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '太乙',
             '人体/足阳明胃经/太乙',
             -0.9421553015708923, 1.1480796337127686, 229.8664093017578,
             0.01040151808410883, 0.002604538109153509, 0.00938007328659296,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '头维_001',
             '人体/足阳明胃经/头维_001',
             -0.5365615487098694, 11.305697441101074, 230.37875366210938,
             0.01524838525801897, -0.003476080484688282, 0.13076625764369965,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '屋翳',
             '人体/足阳明胃经/屋翳',
             -1.4103320837020874, 6.1023359298706055, 230.14791870117188,
             0.004806780721992254, -0.0007390260579995811, 0.0685848593711853,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '巨髎_001',
             '人体/足阳明胃经/巨髎_001',
             -0.5203450918197632, 9.457825660705566, 230.72882080078125,
             0.01544217299669981, -0.007667131256312132, 0.10868553817272186,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '库房',
             '人体/足阳明胃经/库房',
             -1.3994643688201904, 6.491875648498535, 229.98985290527344,
             0.004936649464070797, 0.0011514340294525027, 0.07323922961950302,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '归来',
             '人体/足阳明胃经/归来',
             -1.0014724731445312, -2.4501471519470215, 229.67857360839844,
             0.009692675434052944, 0.004834283608943224, -0.033619701862335205,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '承泣_001',
             '人体/足阳明胃经/承泣_001',
             -0.528537929058075, 9.890061378479004, 230.73448181152344,
             0.015344267711043358, -0.007732856087386608, 0.11385079473257065,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '承满',
             '人体/足阳明胃经/承满',
             -0.9741454720497131, 3.210695266723633, 230.00303649902344,
             0.010019233450293541, 0.0009802448330447078, 0.034029003232717514,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '条口',
             '人体/足阳明胃经/条口',
             -4.649205207824707, -13.987871170043945, 229.5582275390625,
             -0.03389792516827583, 0.00622494937852025, -0.17149659991264343,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '梁丘',
             '人体/足阳明胃经/梁丘',
             -3.3791122436523438, -8.927827835083008, 230.35357666015625,
             -0.018720244988799095, -0.003258701413869858, -0.11102554947137833,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '梁门',
             '人体/足阳明胃经/梁门',
             -0.9842963218688965, 2.4400241374969482, 229.93856811523438,
             0.009897930547595024, 0.001747565227560699, 0.02481917291879654,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '气冲_001',
             '人体/足阳明胃经/气冲_001',
             -1.1555039882659912, -2.939650058746338, 229.55084228515625,
             0.007851989008486271, 0.00635862210765481, -0.03946981206536293,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '气户',
             '人体/足阳明胃经/气户',
             -1.3650550842285156, 6.924945831298828, 229.7835235595703,
             0.005347843281924725, 0.0036188364028930664, 0.07841359078884125,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '气舍',
             '人体/足阳明胃经/气舍',
             -0.3993678390979767, 7.2097649574279785, 229.73683166503906,
             0.016887856647372246, 0.0041779885068535805, 0.08181699365377426,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '水突',
             '人体/足阳明胃经/水突',
             -0.3809553384780884, 7.667367935180664, 229.6057891845703,
             0.0171078871935606, 0.005745758768171072, 0.08728483319282532,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '水道',
             '人体/足阳明胃经/水道',
             -1.0331182479858398, -1.8403644561767578, 229.72689819335938,
             0.009314505383372307, 0.0042593455873429775, -0.026332568377256393,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '滑肉门',
             '人体/足阳明胃经/滑肉门',
             -0.8985286951065063, 0.6286025047302246, 229.9340057373047,
             0.010922858491539955, 0.001794534851796925, 0.003172572236508131,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '犊鼻',
             '人体/足阳明胃经/犊鼻',
             -3.7143800258636475, -10.724983215332031, 230.00962829589844,
             -0.022726714611053467, 0.0008441649843007326, -0.13250306248664856,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '缺盆',
             '人体/足阳明胃经/缺盆',
             -1.3061487674713135, 7.328901767730713, 229.44932556152344,
             0.006051776465028524, 0.007614270783960819, 0.08323949575424194,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '膺窗',
             '人体/足阳明胃经/膺窗',
             -1.4434703588485718, 5.659411430358887, 230.27760314941406,
             0.004410776775330305, -0.002290678909048438, 0.06329242885112762,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '解溪',
             '人体/足阳明胃经/解溪',
             -4.991014003753662, -18.711959838867188, 229.864990234375,
             -0.03798255696892738, 0.002539504785090685, -0.22794845700263977,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '足三里',
             '人体/足阳明胃经/足三里',
             -4.2052130699157715, -12.1436767578125, 229.87811279296875,
             -0.028592195361852646, 0.00240987166762352, -0.14945706725120544,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '阴市',
             '人体/足阳明胃经/阴市',
             -3.304129123687744, -8.252096176147461, 230.40357971191406,
             -0.017824197188019753, -0.003853472415357828, -0.1029503121972084,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '陷谷',
             '人体/足阳明胃经/陷谷',
             -4.949522972106934, -19.174232482910156, 231.09231567382812,
             -0.037486739456653595, -0.01212900597602129, -0.23346759378910065,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '颊车',
             '人体/足阳明胃经/颊车',
             -0.8707864284515381, 9.273845672607422, 230.1763916015625,
             0.011254379525780678, -0.0010662006679922342, 0.10648468136787415,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '髀关',
             '人体/足阳明胃经/髀关',
             -2.1559858322143555, -2.9076647758483887, 229.83935546875,
             -0.004103822633624077, 0.0029111814219504595, -0.039086394011974335,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.09045220911502838, 0.09045220911502838, 0.09045221656560898
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '俞臑',
             '人体/阳维脉/俞臑',
             -2.6779065132141113, 7.121382236480713, 227.6388397216797,
             0.003917860798537731, -0.00488997669890523, -0.02044290490448475,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.03949621319770813, -0.03949621319770813, -0.03949621319770813
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '哑门',
             '人体/阳维脉/哑门',
             -0.02489536814391613, 8.699395179748535, 227.9219207763672,
             -0.009925616905093193, -0.0034156686160713434, -0.028677526861429214,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.03949621319770813, -0.03949621319770813, -0.03949621319770813
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '天髎_002',
             '人体/阳维脉/天髎_002',
             -1.3611011505126953, 7.551612377166748, 227.5987548828125,
             -0.002953261137008667, -0.0050998954102396965, -0.02268778532743454,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.03949621319770813, -0.03949621319770813, -0.03949621319770813
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '头临泣',
             '人体/阳维脉/头临泣',
             -0.3402338922023773, 10.997712135314941, 230.76419067382812,
             -0.008280172012746334, 0.011411190964281559, -0.040675319731235504,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.03949621319770813, -0.03949621319770813, -0.03949621319770813
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '头维',
             '人体/阳维脉/头维',
             -0.7951694130897522, 10.870542526245117, 230.41079711914062,
             -0.005906307604163885, 0.009567401371896267, -0.04001110419631004,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.03949621319770813, -0.03949621319770813, -0.03949621319770813
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '承灵',
             '人体/阳维脉/承灵',
             -0.4579485058784485, 11.721534729003906, 229.3870391845703,
             -0.007665934506803751, 0.00422388780862093, -0.044449761509895325,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.03949621319770813, -0.03949621319770813, -0.03949621319770813
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '本神',
             '人体/阳维脉/本神',
             -0.6124921441078186, 10.947052955627441, 230.6123046875,
             -0.006859521847218275, 0.010618720203638077, -0.04041070491075516,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.03949621319770813, -0.03949621319770813, -0.03949621319770813
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '正营',
             '人体/阳维脉/正营',
             -0.39924055337905884, 11.593236923217773, 230.09161376953125,
             -0.007972273975610733, 0.00790063664317131, -0.043781571090221405,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.03949621319770813, -0.03949621319770813, -0.03949621319770813
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '目窗',
             '人体/阳维脉/目窗',
             -0.38947775959968567, 11.407087326049805, 230.41488647460938,
             -0.008023216389119625, 0.009587777778506279, -0.042810820043087006,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.03949621319770813, -0.03949621319770813, -0.03949621319770813
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '肩井',
             '人体/阳维脉/肩井',
             -1.5496563911437988, 7.3260498046875, 227.4915313720703,
             -0.0019693756476044655, -0.005658975336700678, -0.02151060290634632,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.03949621319770813, -0.03949621319770813, -0.03949621319770813
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '脑空',
             '人体/阳维脉/脑空',
             -0.45411044359207153, 9.811991691589355, 228.03045654296875,
             -0.007685961667448282, -0.0028513926081359386, -0.034483276307582855,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.03949621319770813, -0.03949621319770813, -0.03949621319770813
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '金门',
             '人体/阳维脉/金门',
             -5.358728885650635, -19.391830444335938, 229.4202880859375,
             0.01790645718574524, 0.004453437868505716, 0.11790048331022263,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.03949621319770813, -0.03949621319770813, -0.03949621319770813
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '阳交',
             '人体/阳维脉/阳交',
             -5.051898002624512, -16.167011260986328, 228.6415557861328,
             0.016305407509207726, 0.0003841446596197784, 0.1010746955871582,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.03949621319770813, -0.03949621319770813, -0.03949621319770813
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '阳白',
             '人体/阳维脉/阳白',
             -0.38644611835479736, 10.331928253173828, 230.8782501220703,
             -0.008039035834372044, 0.012007521465420723, -0.037201445549726486,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.03949621319770813, -0.03949621319770813, -0.03949621319770813
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '风府',
             '人体/阳维脉/风府',
             -0.023354774340987206, 9.288390159606934, 227.9337158203125,
             -0.0099336551502347, -0.0033552031964063644, -0.031750936061143875,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.03949621319770813, -0.03949621319770813, -0.03949621319770813
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '风池',
             '人体/阳维脉/风池',
             -0.3938198685646057, 9.309388160705566, 227.93373107910156,
             -0.00800055917352438, -0.0033552031964063644, -0.03186050429940224,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             -0.03949621319770813, -0.03949621319770813, -0.03949621319770813
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '仆参',
             '人体/阳跷脉/仆参',
             -5.255511283874512, -19.562580108642578, 228.82470703125,
             -0.39284953474998474, -0.01609048806130886, -2.779437303543091,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '地仓',
             '人体/阳跷脉/地仓',
             -0.5450717806816101, 8.836808204650879, 230.36734008789062,
             0.22946803271770477, -0.21860067546367645, 0.9726051092147827,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '天髎',
             '人体/阳跷脉/天髎',
             -0.807786762714386, 7.542509078979492, 227.3406524658203,
             0.1947595626115799, 0.1812095046043396, 0.8014714121818542,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '居髎',
             '人体/阳跷脉/居髎',
             -2.5153021812438965, -0.6447023153305054, 228.9669189453125,
             -0.030828053131699562, -0.034017618745565414, -0.2801040709018707,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '巨骨',
             '人体/阳跷脉/巨骨',
             -2.4874250888824463, 7.450778007507324, 228.53221130371094,
             -0.02714509889483452, 0.023783814162015915, 0.7894067168235779,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '巨髎',
             '人体/阳跷脉/巨髎',
             -0.5276634693145752, 9.361818313598633, 230.65066528320312,
             0.2317679226398468, -0.25600895285606384, 1.0419795513153076,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '承泣',
             '人体/阳跷脉/承泣',
             -0.5503672957420349, 10.017290115356445, 230.67977905273438,
             0.22876842319965363, -0.2598256468772888, 1.1285783052444458,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '晴明',
             '人体/阳跷脉/晴明',
             -0.2620098888874054, 10.063140869140625, 230.84109497070312,
             0.2668646275997162, -0.28113409876823425, 1.1346429586410522,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '申脉',
             '人体/阳跷脉/申脉',
             -5.346736431121826, -19.324758529663086, 229.59136962890625,
             -0.4049016833305359, -0.11736683547496796, -2.7479827404022217,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '肩髃',
             '人体/阳跷脉/肩髃',
             -3.539325714111328, 7.365354061126709, 228.81796264648438,
             -0.16611644625663757, -0.013973407447338104, 0.7781339883804321,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '臑俞',
             '人体/阳跷脉/臑俞',
             -1.6114863157272339, 7.1778717041015625, 227.41050720214844,
             0.08857917785644531, 0.1719639003276825, 0.7533006072044373,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '跗阳',
             '人体/阳跷脉/跗阳',
             -5.038361549377441, -17.500226974487305, 228.39329528808594,
             -0.3641609251499176, 0.040997765958309174, -2.5069899559020996,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '大横',
             '人体/阴维脉/大横',
             -1.4568356275558472, 0.022392332553863525, 229.4838409423828,
             0.007204818539321423, 0.027126722037792206, 0.17791157960891724,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '天突',
             '人体/阴维脉/天突',
             0.019844526425004005, 6.597043991088867, 229.95535278320312,
             0.20229573547840118, -0.034867770969867706, 1.0465401411056519,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '府舍_002',
             '人体/阴维脉/府舍_002',
             -1.5241791009902954, -2.6820664405822754, 229.7279510498047,
             -0.0016922377981245518, -0.005246038548648357, -0.17937560379505157,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '廉泉_001',
             '人体/阴维脉/廉泉_001',
             -5.587934879258682e-07, 8.319997787475586, 230.17156982421875,
             0.19967392086982727, -0.06335370987653732, 1.274177074432373,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '期门',
             '人体/阴维脉/期门',
             -1.4088653326034546, 3.7519614696502686, 229.84764099121094,
             0.013542402535676956, -0.0207669734954834, 0.6706584692001343,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '筑宾',
             '人体/阴维脉/筑宾',
             -3.8212788105010986, -16.447635650634766, 228.74993896484375,
             -0.30517250299453735, 0.12333489209413528, -1.9980520009994507,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '腹哀_002',
             '人体/阴维脉/腹哀_002',
             -1.4064929485321045, 1.724399447441101, 229.5706024169922,
             0.013855819590389729, 0.01574236899614334, 0.4027754068374634,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '交信',
             '人体/阴跷脉/交信',
             -4.200730323791504, -17.90345573425293, 228.92233276367188,
             0.05216751620173454, -0.02463775873184204, -2.5488979816436768,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '照海',
             '人体/阴跷脉/照海',
             -4.361349105834961, -19.335041046142578, 229.33253479003906,
             0.030947407707571983, -0.07889619469642639, -2.7380125522613525,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );


INSERT INTO acupuncture_points (
    model_name, path,
    position_x, position_y, position_z,
    local_position_x, local_position_y, local_position_z,
    rotation_x, rotation_y, rotation_z, rotation_w,
    local_rotation_x, local_rotation_y, local_rotation_z, local_rotation_w,
    scale_x, scale_y, scale_z
) VALUES (
             '睛明',
             '人体/阴跷脉/睛明',
             -0.1814335435628891, 10.019750595092773, 230.85015869140625,
             0.5831750631332397, -0.2780577540397644, 1.1402511596679688,
             -0.7069847583770752, 0.0, 0.0, 0.7072287797927856,
             0.0, 0.0, 0.0, 1.0,
             0.9999999403953552, 0.9999999403953552, 0.9999999403953552
         );
