#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <linux/sched.h>

#define NV_IOCTL_MAGIC      'F'
#define NV_IOCTL_BASE       200
// yj start
#define NV_4PD_VGPU_CTL              (NV_IOCTL_BASE + 19)
// yj end

typedef struct nv_4pd_vgpu_ctl
{
    u_int32_t   mem_limit;
} nv_4pd_vgpu_ctl_t;

#define WR_VALUE _IOW(NV_IOCTL_MAGIC,NV_4PD_VGPU_CTL,nv_4pd_vgpu_ctl_t*)

int main()
{
        int fd;
        nv_4pd_vgpu_ctl_t vgpu_ctl;
        int ret;
        int gpu_id;
        char device_name[20];
        printf("*******vgpu-ioctl-example*******\n");
        printf("Enter the id of GPU (0-indexed) to send\n");
        scanf("%d",&(gpu_id));
        sprintf(device_name, "/dev/nvidia%d", gpu_id);
        printf("\nOpening driver: %s\n", device_name);
        fd = open(device_name, O_RDWR);
        if(fd < 0) {
                printf("Cannot open device file...\n");
                return 0;
        }
        printf("Driver opened, PID = %d, PPID = %d\n", getpid(), getppid());
        printf("Enter the mem_limit to send\n");
        scanf("%d",&(vgpu_ctl.mem_limit));
        printf("Writing to driver\n");
        if (ret = ioctl(fd, WR_VALUE, &vgpu_ctl))
        {
            printf("ioctl return error : %d\n", ret);
        }
        printf("Closing driver\n");
        close(fd);
        printf("Driver closed.\n");
}