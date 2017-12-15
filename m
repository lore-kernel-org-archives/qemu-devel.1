Received: from eggs.gnu.org ([2001:4830:134:3::10]:33762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePn9T-0006UM-7L
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:23:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePn9Q-0005vf-1C
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:23:35 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171215033015.738-1-f4bug@amsat.org>
	<20171215033015.738-5-f4bug@amsat.org>
	<800d15c5-fe10-56af-083c-501291d245ad@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9db63210-0e85-5463-e420-34327f24e1d3@amsat.org>
Date: Fri, 15 Dec 2017 07:23:17 -0300
MIME-Version: 1.0
In-Reply-To: <800d15c5-fe10-56af-083c-501291d245ad@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 04/43] MAINTAINERS: add an entry for the
 i82378 (superio)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org

On 12/15/2017 07:17 AM, Thomas Huth wrote:
> On 15.12.2017 04:29, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
>> Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
> 
> Remove the doubled Reviewed-by, or replace the second line with:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Haha ok, thanks :)

I applied this series from a patchwork bundle and didn't notice it would
keep enqueueing R-b from the same reviewer.

> 
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 31c673d60a..4618f9b4db 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -732,6 +732,7 @@ F: hw/ppc/prep.c
>>  F: hw/ppc/prep_systemio.c
>>  F: hw/ppc/rs6000_mc.c
>>  F: hw/pci-host/prep.[hc]
>> +F: hw/isa/i82378.c
>>  F: hw/isa/pc87312.[hc]
>>  F: hw/dma/i82374.c
>>  F: pc-bios/ppc_rom.bin
