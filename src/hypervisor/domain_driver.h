/*
 * domain_driver.h: general functions shared between hypervisor drivers
 *
 * Copyright IBM Corp. 2020
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library.  If not, see
 * <http://www.gnu.org/licenses/>.
 */

#pragma once

#include "node_device_conf.h"
#include "virhostdev.h"
#include "virpci.h"
#include "virdomainobjlist.h"
#include "virenum.h"

char *
virDomainDriverGenerateRootHash(const char *drivername,
                                const char *root);

char *
virDomainDriverGenerateMachineName(const char *drivername,
                                   const char *root,
                                   int id,
                                   const char *name,
                                   bool privileged);

int virDomainDriverMergeBlkioDevice(virBlkioDevice **dest_array,
                                    size_t *dest_size,
                                    virBlkioDevice *src_array,
                                    size_t src_size,
                                    const char *type);

int virDomainDriverParseBlkioDeviceStr(char *blkioDeviceStr, const char *type,
                                       virBlkioDevice **dev, size_t *size);

int virDomainDriverSetupPersistentDefBlkioParams(virDomainDef *persistentDef,
                                                 virTypedParameterPtr params,
                                                 int nparams);

int virDomainDriverNodeDeviceGetPCIInfo(virNodeDeviceDef *def,
                                        virPCIDeviceAddress *devAddr);

int virDomainDriverNodeDeviceReset(virNodeDevicePtr dev,
                                   virHostdevManager *hostdevMgr);

int virDomainDriverNodeDeviceReAttach(virNodeDevicePtr dev,
                                      virHostdevManager *hostdevMgr);

int virDomainDriverNodeDeviceDetachFlags(virNodeDevicePtr dev,
                                         virHostdevManager *hostdevMgr,
                                         virPCIStubDriver driverType,
                                         const char *driverName);

int virDomainDriverAddIOThreadCheck(virDomainDef *def,
                                    unsigned int iothread_id);

int virDomainDriverDelIOThreadCheck(virDomainDef *def,
                                    unsigned int iothread_id);

int virDomainDriverGetIOThreadsConfig(virDomainDef *targetDef,
                                      virDomainIOThreadInfoPtr **info,
                                      unsigned int bitmap_size);

/*
 * Will be called with 'vm' locked and ref count held,
 * which will be released when this returns.
 */
typedef void (*virDomainDriverAutoStartCallback)(virDomainObj *vm,
                                                 void *opaque);

typedef struct _virDomainDriverAutoStartConfig {
    const char *stateDir;
    virDomainDriverAutoStartCallback callback;
    void *opaque;
    unsigned int delayMS; /* milliseconds to wait between initiating the
                           * startup of each guest */
} virDomainDriverAutoStartConfig;

void virDomainDriverAutoStart(virDomainObjList *domains,
                              virDomainDriverAutoStartConfig *cfg);

typedef enum {
    VIR_DOMAIN_DRIVER_AUTO_SHUTDOWN_SCOPE_NONE,
    VIR_DOMAIN_DRIVER_AUTO_SHUTDOWN_SCOPE_PERSISTENT,
    VIR_DOMAIN_DRIVER_AUTO_SHUTDOWN_SCOPE_TRANSIENT,
    VIR_DOMAIN_DRIVER_AUTO_SHUTDOWN_SCOPE_ALL,

    VIR_DOMAIN_DRIVER_AUTO_SHUTDOWN_SCOPE_LAST,
} virDomainDriverAutoShutdownScope;

VIR_ENUM_DECL(virDomainDriverAutoShutdownScope);

typedef struct _virDomainDriverAutoShutdownConfig {
    const char *uri;
    virDomainDriverAutoShutdownScope trySave;
    virDomainDriverAutoShutdownScope tryShutdown;
    virDomainDriverAutoShutdownScope poweroff;
    unsigned int waitShutdownSecs; /* Seconds to wait for VM to shutdown
                                    * before moving onto next action.
                                    * If 0 a default is used (currently 30 secs)
                                    */
    bool saveBypassCache;
    bool autoRestore;
} virDomainDriverAutoShutdownConfig;

bool virDomainDriverAutoShutdownActive(virDomainDriverAutoShutdownConfig *cfg);
void virDomainDriverAutoShutdown(virDomainDriverAutoShutdownConfig *cfg);
