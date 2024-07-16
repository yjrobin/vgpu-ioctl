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
#define NV_4PD_VGPU_SET_MEM_LIMIT              (NV_IOCTL_BASE + 19)
#define NV_4PD_VGPU_GET_MEM_LIMIT              (NV_IOCTL_BASE + 20)
// yj end

typedef struct
{
    u_int32_t   mem_limit;
} nv_4pd_vgpu_set_mem_limit_t;

typedef struct
{
    u_int32_t   pid_ns;
    u_int32_t   mem_limit;
} nv_4pd_vgpu_get_mem_limit_t;

#define WR_VALUE _IOW(NV_IOCTL_MAGIC,NV_4PD_VGPU_SET_MEM_LIMIT,nv_4pd_vgpu_set_mem_limit_t*)
#define RD_VALUE _IOR(NV_IOCTL_MAGIC,NV_4PD_VGPU_GET_MEM_LIMIT,nv_4pd_vgpu_get_mem_limit_t*)

int main()
{
        int fd;
        nv_4pd_vgpu_set_mem_limit_t vgpu_set_mem_limit;
        nv_4pd_vgpu_get_mem_limit_t vgpu_get_mem_limit;
        int ret;
        int gpu_id;
        char device_name[20];
        printf("*******vgpu-ioctl-example*******\n");
        printf("Enter the id of GPU (0-indexed) to send IOCTL\n");
        scanf("%d",&(gpu_id));
        sprintf(device_name, "/dev/nvidia%d", gpu_id);
        printf("\nOpening driver: %s\n", device_name);
        fd = open(device_name, O_RDWR);
        if(fd < 0) {
                printf("Cannot open device file...\n");
                return 0;
        }
        printf("Driver opened, PID = %d, PPID = %d\n", getpid(), getppid());
        printf("Enter mem_limit to set\n");
        scanf("%d",&(vgpu_set_mem_limit.mem_limit));
        printf("Writing to driver\n");
        if (ret = ioctl(fd, WR_VALUE, &vgpu_set_mem_limit))
        {
            printf("ioctl return error : %d\n", ret);
        }
        printf("Write successfully.\n");
        printf("Get last mem_limit info from driver <pid_namespace, mem_limit>:\n");
        if (ret = ioctl(fd, RD_VALUE, &vgpu_get_mem_limit))
        {
            printf("ioctl return error : %d\n", ret);
        }
        printf("%u, %u\n", vgpu_get_mem_limit.pid_ns, vgpu_get_mem_limit.mem_limit);
        printf("Closing driver\n");
        close(fd);
        printf("Driver closed.\n");
}