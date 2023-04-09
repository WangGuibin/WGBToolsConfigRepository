import tkinter as tk
from tkinter import filedialog
import os
import subprocess
import datetime 
import shutil

class AppIconCreator:
    def __init__(self, master):
        # 定义用到的变量
        self.image_path = ""
        
        # 创建控件
        self.label = tk.Label(master, text="Enter origin image path:")
        self.label.pack()
        
        self.entry = tk.Entry(master, width=50)
        self.entry.pack()
        
        self.button = tk.Button(master, text="Select Image", command=self.select_image)
        self.button.pack()
        
        self.create_button = tk.Button(master, text="Create App Icon", command=self.create_app_icon)
        self.create_button.pack()
        
        self.status = tk.Label(master, text="")
        self.status.pack()
        
    def select_image(self):
        # 打开文件对话框选择图片
        self.image_path = filedialog.askopenfilename(
            title="Select Image",
            filetypes=[("PNG files", "*.png"),("All Files", "*.*")]
        )
        
        if self.image_path:
            self.entry.delete(0, tk.END)
            self.entry.insert(0, self.image_path)
        
    def create_app_icon(self):
        # 如果文件存在且为目录则为真
        if os.path.isdir(self.image_path):
            self.status.config(text="Error: the file path is directory")
            return
        # 如果文件存在且可读则为真
        elif not os.path.isfile(self.image_path) or not os.access(self.image_path, os.R_OK):
            self.status.config(text="Error: the file path is not found or not readable")
            return
        else:
            ext = (".jpeg", ".jpg", ".png", ".JPEG", ".JPG", ".PNG", ".gif", ".bmp")
            # 匹配到图片格式才处理
            if not self.image_path.endswith(ext):
                self.status.config(text="Error: the file is not a legal format")
                return
            else:
                self.status.config(text="Processing...")
                self.creat_app_icon()
                self.status.config(text="Finished!")
                
    def creat_app_icon(self):
        # 图片的上一级目录
        prev_path = os.path.dirname(self.image_path)

        # 输出icon的目录
        icon_path = os.path.join(prev_path, "iOS_icon_" + datetime.datetime.now().strftime("%Y%m%d_%H%M%S"))

        # 创建目录
        os.makedirs(icon_path)

        # 1024 icon 特别处理
        icon_1024_path = os.path.join(icon_path, "icon-1024.png")
        shutil.copyfile(self.image_path, icon_1024_path)

        subprocess.run(["sips", "-s", "format", "png", self.image_path, "--out", icon_1024_path], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

        subprocess.run(["sips", "-z", "1024", "1024", icon_1024_path], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

        prev_size_path = icon_1024_path #用于复制小图，减少内存消耗
        # 需要生成的图标尺寸
        icons = (180, 167, 152, 120, 87, 80, 76, 60, 58, 40)
        for size in icons:
            size_path = os.path.join(icon_path, "icon-" + str(size) + ".png")
            shutil.copyfile(prev_size_path, size_path)
            prev_size_path = size_path
            subprocess.run(["sips", "-Z", str(size), size_path], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

        # 转换1024图片为jpg，防止有透明区域导致上传 App Store 失败
        icon_1024_jpg_path = os.path.join(icon_path, "icon-1024.jpg")
        os.rename(icon_1024_path, icon_1024_jpg_path)
        subprocess.run(["sips", "-s", "format", "jpeg", icon_1024_jpg_path, "--out", icon_1024_jpg_path], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

        contents_json_path = os.path.join(icon_path, "Contents.json")
        # 生成图标对应的配置文件
        with open(contents_json_path, "w") as f:
            f.write('{"images" : [\n')
            f.write('\t{\n\t\t"size" : "20x20",\n\t\t"idiom" : "iphone",\n\t\t"filename" : "icon-40.png",\n\t\t"scale" : "2x"\n\t},\n')
            f.write('\t{\n\t\t"size" : "20x20",\n\t\t"idiom" : "iphone",\n\t\t"filename" : "icon-60.png",\n\t\t"scale" : "3x"\n\t},\n')
            f.write('\t{\n\t\t"size" : "29x29",\n\t\t"idiom" : "iphone",\n\t\t"filename" : "icon-58.png",\n\t\t"scale" : "2x"\n\t},\n')
            f.write('\t{\n\t\t"size" : "29x29",\n\t\t"idiom" : "iphone",\n\t\t"filename" : "icon-87.png",\n\t\t"scale" : "3x"\n\t},\n')
            f.write('\t{\n\t\t"size" : "40x40",\n\t\t"idiom" : "iphone",\n\t\t"filename" : "icon-80.png",\n\t\t"scale" : "2x"\n\t},\n')
            f.write('\t{\n\t\t"size" : "40x40",\n\t\t"idiom" : "iphone",\n\t\t"filename" : "icon-120.png",\n\t\t"scale" : "3x"\n\t},\n')
            f.write('\t{\n\t\t"size" : "60x60",\n\t\t"idiom" : "iphone",\n\t\t"filename" : "icon-120.png",\n\t\t"scale" : "2x"\n\t},\n')
            f.write('\t{\n\t\t"size" : "60x60",\n\t\t"idiom" : "iphone",\n\t\t"filename" : "icon-180.png",\n\t\t"scale" : "3x"\n\t},\n')
            f.write('\t{\n\t\t"idiom" : "ipad",\n\t\t"size" : "20x20",\n\t\t"scale" : "1x"\n\t},\n')
            f.write('\t{\n\t\t"size" : "20x20",\n\t\t"idiom" : "ipad",\n\t\t"filename" : "icon-40.png",\n\t\t"scale" : "2x"\n\t},\n')
            f.write('\t{\n\t\t"idiom" : "ipad",\n\t\t"size" : "29x29",\n\t\t"scale" : "1x"\n\t},\n')
            f.write('\t{\n\t\t"size" : "29x29",\n\t\t"idiom" : "ipad",\n\t\t"filename" : "icon-58.png",\n\t\t"scale" : "2x"\n\t},\n')
            f.write('\t{\n\t\t"idiom" : "ipad",\n\t\t"size" : "40x40",\n\t\t"scale" : "1x"\n\t},\n')
            f.write('\t{\n\t\t"size" : "40x40",\n\t\t"idiom" : "ipad",\n\t\t"filename" : "icon-80.png",\n\t\t"scale" : "2x"\n\t},\n')
            f.write('\t{\n\t\t"idiom" : "ipad",\n\t\t"size" : "76x76",\n\t\t"filename" : "icon-76.png",\n\t\t"scale" : "1x"\n\t},\n')
            f.write('\t{\n\t\t"size" : "76x76",\n\t\t"idiom" : "ipad",\n\t\t"filename" : "icon-152.png",\n\t\t"scale" : "2x"\n\t},\n')
            f.write('\t{\n\t\t"size" : "83.5x83.5",\n\t\t"idiom" : "ipad",\n\t\t"filename" : "icon-167.png",\n\t\t"scale" : "2x"\n\t},\n')
            f.write('\t{\n\t\t"size" : "1024x1024",\n\t\t"idiom" : "ios-marketing",\n\t\t"filename" : "icon-1024.jpg",\n\t\t"scale" : "1x"\n\t}\n')
            f.write('],\n"info" : {\n\t"version" : 1,\n\t"author" : "xcode"\n}\n}')

if __name__ == "__main__":
    root = tk.Tk()
    app = AppIconCreator(root)
    root.mainloop()