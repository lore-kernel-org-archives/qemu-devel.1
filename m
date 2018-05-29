Received: from eggs.gnu.org ([2001:4830:134:3::10]:53450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fNZWc-00035B-P7
	for qemu-devel@nongnu.org; Tue, 29 May 2018 03:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fNZWc-0008OJ-2m
	for qemu-devel@nongnu.org; Tue, 29 May 2018 03:58:34 -0400
References: <20180528232719.4721-1-f4bug@amsat.org>
	<20180528232719.4721-20-f4bug@amsat.org>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <a191de37-6b8f-33d3-cd9f-18b14af934b8@gmail.com>
Date: Tue, 29 May 2018 10:58:25 +0300
MIME-Version: 1.0
In-Reply-To: <20180528232719.4721-20-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 19/21] hw/i386/pc: Remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>



On 05/29/2018 02:27 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   hw/i386/pc.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index d768930d02..8b0803cb83 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -64,7 +64,6 @@
>   #include "hw/acpi/acpi.h"
>   #include "hw/acpi/cpu_hotplug.h"
>   #include "hw/boards.h"
> -#include "hw/pci/pci_host.h"
>   #include "acpi-build.h"
>   #include "hw/mem/pc-dimm.h"
>   #include "qapi/error.h"

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
