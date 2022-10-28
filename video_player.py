import tkinter as tk
from matplotlib.pyplot import show
import tkvideo

video_x, video_y = 1280, 720

def show_video():
    app = tk.Tk()
    app.title('Video Player')
    app.overrideredirect(True)

    w, h, = app.winfo_screenwidth(), app.winfo_screenheight()

    rescale = min(w // video_x, h // video_y)

    app.wm_geometry(f'{w}x{h}+0+0')
    label = tk.Label(app)
    label.pack()

    player = tkvideo.tkvideo(r'.\video.mp4', label, 0, (video_x * rescale, video_y * rescale))
    player.play()

    # def snd1():
    #     os.system(r".\video.mp4")

    # var = tk.IntVar()

    # rb1 = tk.Radiobutton(app, text= "Play Video", variable = var, value=1, command=snd1)
    # rb1.pack(anchor = tk.W)

    #fade(app, 0, 255, 10)

    app.deiconify()
    app.mainloop()

def fade(app: tk.Tk, from_, to_, time):
    d_alpha = (from_ - to_) / time
    dt = 1/60
    for i in range(int(time//dt)):
        app.after(int(i*dt*1000), app.attributes, '-alpha', int(from_ + d_alpha*i))


def main():
    show_video()

if __name__ == '__main__':
    main()