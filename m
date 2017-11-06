Received: from eggs.gnu.org ([2001:4830:134:3::10]:47494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eBp9W-0004jn-3D
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 16:41:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1eBp9V-0003yp-AW
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 16:41:54 -0500
References: <20171017164426.25277-1-f4bug@amsat.org>
	<20171017164426.25277-3-f4bug@amsat.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <62624405-626a-bcbb-d164-e34ef06c8a81@reactos.org>
Date: Mon, 6 Nov 2017 22:41:03 +0100
MIME-Version: 1.0
In-Reply-To: <20171017164426.25277-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 02/42] MAINTAINERS: add an entry for the
 i82374 (southbridge)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Otubo <otubo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org

Le 17/10/2017 à 18:43, Philippe Mathieu-Daudé a écrit :
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6f56c1349b..331f7391c1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -713,6 +713,7 @@ F: hw/ppc/prep_systemio.c
>   F: hw/ppc/rs6000_mc.c
>   F: hw/pci-host/prep.[hc]
>   F: hw/isa/pc87312.[hc]
> +F: hw/dma/i82374.c
>   F: pc-bios/ppc_rom.bin
>   
>   sPAPR
> 

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
