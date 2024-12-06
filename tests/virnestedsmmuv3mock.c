/*
 * virnestedsmmuv3mock.c: Mock sysfs nested SMMU paths
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

#include <config.h>

#include "conf/domain_conf.h"
#include "viralloc.h"
#include "virstring.h"
#include "internal.h"
#include "virmock.h"

int
virDomainDefAddImplicitNestedSmmuv3(virDomainDef *def)
{
    virDomainNestedSmmuv3Def* nestedsmmuv3 = NULL;

    if (!(nestedsmmuv3 = virDomainNestedSmmuv3DefNew()))
        return -1;
    VIR_REALLOC_N(nestedsmmuv3->name, strlen("smmu3.0x0000000000000001") + 1);
    virStrcpy(nestedsmmuv3->name, "smmu3.0x0000000000000001",
              strlen("smmu3.0x0000000000000001") + 1);
    VIR_REALLOC_N(def->nestedsmmus, def->nnestedsmmus + 1);
    def->nestedsmmus[def->nnestedsmmus++] = nestedsmmuv3;

    if (!(nestedsmmuv3 = virDomainNestedSmmuv3DefNew()))
        return -1;
    VIR_REALLOC_N(nestedsmmuv3->name, strlen("smmu3.0x0000000000000002") + 1);
    virStrcpy(nestedsmmuv3->name, "smmu3.0x0000000000000002",
              strlen("smmu3.0x0000000000000002") + 1);
    VIR_REALLOC_N(def->nestedsmmus, def->nnestedsmmus + 1);
    def->nestedsmmus[def->nnestedsmmus++] = nestedsmmuv3;

    if (!(nestedsmmuv3 = virDomainNestedSmmuv3DefNew()))
        return -1;
    VIR_REALLOC_N(nestedsmmuv3->name, strlen("smmu3.0x0000000000000003") + 1);
    virStrcpy(nestedsmmuv3->name, "smmu3.0x0000000000000003",
              strlen("smmu3.0x0000000000000003") + 1);
    VIR_REALLOC_N(def->nestedsmmus, def->nnestedsmmus + 1);
    def->nestedsmmus[def->nnestedsmmus++] = nestedsmmuv3;

    return 0;
}
