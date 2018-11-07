Received: from eggs.gnu.org ([2001:4830:134:3::10]:56006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gKRuh-0003fj-70
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 12:46:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gKRud-0005u1-8P
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 12:46:47 -0500
References: <20181030093531.18587-1-agraf@suse.de>
	<655b9090-bb99-2255-5020-d2da2a404bfc@ilande.co.uk>
	<20181107042520.GC5575@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <bad5af59-2f6f-0138-2b5c-c2e4fceabb65@ilande.co.uk>
Date: Wed, 7 Nov 2018 17:46:18 +0000
MIME-Version: 1.0
In-Reply-To: <20181107042520.GC5575@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: PPC: Remove myself
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org

On 07/11/2018 04:25, David Gibson wrote:

> On Tue, Oct 30, 2018 at 02:34:46PM +0000, Mark Cave-Ayland wrote:
>> On 30/10/2018 09:35, Alexander Graf wrote:
>>
>>> I haven't really been maintaining any PowerPC code for quite a while now,
>>> so let's reflect reality: David does all the work and embedded PPC is in
>>> "Odd Fixes" state rather than supported now.
>>
>> It was a pleasure working with you, but of course life moves
>> on... :)
> 
> [snip]
>>>  New World
>>> -M: Alexander Graf <agraf@suse.de>
>>> +M: David Gibson <david@gibson.dropbear.id.au>
>>>  L: qemu-ppc@nongnu.org
>>> -S: Maintained
>>> +S: Odd Fixes
>>
>> There was actually a patch floating around to add myself to MAINTAINERS for the New
>> World and Old World machines, but I think it got lost when trying to set up a
>> sub-maintainer queue with David. I'm happy to look after these
>> machines for now.
> 
> Yeah, it did.  Still need to sort that out...

Okay well as you've still got a ppc-for-3.1 pull pending, I can send a patch to add
myself as a maintainer. Should I leave you listed there?

Also I see that Alex also switched the Old World/New World machines to "Odd Fixes"
from "Maintained" - is that correct?

>>>  F: hw/ppc/mac_newworld.c
>>>  F: hw/pci-host/uninorth.c
>>>  F: hw/pci-bridge/dec.[hc]
>>> @@ -823,9 +822,9 @@ F: include/hw/misc/mos6522.h
>>>  F: include/hw/ppc/mac_dbdma.h
>>>  
>>>  Old World
>>> -M: Alexander Graf <agraf@suse.de>
>>> +M: David Gibson <david@gibson.dropbear.id.au>
>>>  L: qemu-ppc@nongnu.org
>>> -S: Maintained
>>> +S: Odd Fixes
>>>  F: hw/ppc/mac_oldworld.c
>>>  F: hw/pci-host/grackle.c
>>>  F: hw/misc/macio/
>>> @@ -850,7 +849,6 @@ F: pc-bios/ppc_rom.bin
>>>  
>>>  sPAPR
>>>  M: David Gibson <david@gibson.dropbear.id.au>
>>> -M: Alexander Graf <agraf@suse.de>
>>>  L: qemu-ppc@nongnu.org
>>>  S: Supported
>>>  F: hw/*/spapr*
>>> @@ -1117,7 +1115,7 @@ F: tests/bios-tables-test.c
>>>  F: tests/acpi-utils.[hc]
>>>  
>>>  ppc4xx
>>> -M: Alexander Graf <agraf@suse.de>
>>> +M: David Gibson <david@gibson.dropbear.id.au>
>>>  L: qemu-ppc@nongnu.org
>>>  S: Odd Fixes
>>>  F: hw/ppc/ppc4*.c
>>> @@ -1126,9 +1124,9 @@ F: include/hw/ppc/ppc4xx.h
>>>  F: include/hw/i2c/ppc4xx_i2c.h
>>>  
>>>  ppce500
>>> -M: Alexander Graf <agraf@suse.de>
>>> +M: David Gibson <david@gibson.dropbear.id.au>
>>>  L: qemu-ppc@nongnu.org
>>> -S: Supported
>>> +S: Odd Fixes
>>>  F: hw/ppc/e500*
>>>  F: hw/pci-host/ppce500.c
>>>  F: hw/net/fsl_etsec/


ATB,

Mark.
