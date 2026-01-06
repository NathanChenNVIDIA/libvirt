#include <config.h>

#include "viriommufd.h"
#include "virlog.h"
#include "virerror.h"
#include "virfile.h"

#ifdef __linux__

# include <sys/ioctl.h>
# include <linux/types.h>

# ifdef HAVE_LINUX_IOMMUFD_H
#  include <linux/iommufd.h>
# endif

# define VIR_FROM_THIS VIR_FROM_NONE

VIR_LOG_INIT("util.iommufd");

# ifndef IOMMU_OPTION

enum iommufd_option {
    IOMMU_OPTION_RLIMIT_MODE = 0,
    IOMMU_OPTION_HUGE_PAGES = 1,
};

enum iommufd_option_ops {
    IOMMU_OPTION_OP_SET = 0,
    IOMMU_OPTION_OP_GET = 1,
};

struct iommu_option {
    __u32 size;
    __u32 option_id;
    __u16 op;
    __u16 __reserved;
    __u32 object_id;
    __aligned_u64 val64;
};

#  define IOMMUFD_TYPE (';')
#  define IOMMUFD_CMD_OPTION 0x87
#  define IOMMU_OPTION _IO(IOMMUFD_TYPE, IOMMUFD_CMD_OPTION)

# endif

/**
 * virIOMMUFDSetRLimitMode:
 * @fd: iommufd file descriptor
 * @processAccounting: true for per-process, false for per-user
 *
 * Set RLIMIT_MEMLOCK accounting mode for the iommufd.
 *
 * Returns: 0 on success, -1 on error
 */
int
virIOMMUFDSetRLimitMode(int fd, bool processAccounting)
{
    struct iommu_option option = {
        .size = sizeof(struct iommu_option),
        .option_id = IOMMU_OPTION_RLIMIT_MODE,
        .op = IOMMU_OPTION_OP_SET,
        .__reserved = 0,
        .object_id = 0,
        .val64 = processAccounting ? 1 : 0,
    };

    if (ioctl(fd, IOMMU_OPTION, &option) < 0) {
        switch (errno) {
            case ENOTTY:
                VIR_WARN("IOMMU_OPTION ioctl not supported");
                return 0;

            case EOPNOTSUPP:
                VIR_WARN("IOMMU_OPTION_RLIMIT_MODE not supported by kernel");
                return 0;

            case EINVAL:
                virReportSystemError(errno, "%s",
                                     _("invalid iommufd option parameters"));
                return -1;

            case EPERM:
                VIR_WARN("Permission denied for IOMMU_OPTION ioctl. "
                         "Per-user-based memory accounting to be used by default.");
                return 0;

            default:
                virReportSystemError(errno, "%s",
                                     _("failed to set iommufd option"));
                return -1;
        }
    }

    VIR_DEBUG("Set iommufd rlimit mode to %s-based accounting",
              processAccounting ? "process" : "user");
    return 0;
}

#else

int virIOMMUFDSetRLimitMode(int fd G_GNUC_UNUSED,
                            bool processAccounting G_GNUC_UNUSED)
{
    virReportError(VIR_ERR_NO_SUPPORT, "%s",
                   _("IOMMUFD is not supported on this platform"));
    return -1;
}

#endif
