Received: from eggs.gnu.org ([208.118.235.92]:48048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1geeCb-0004Ig-Nj
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 05:56:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1geeCV-0004JL-D2
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 05:56:45 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1geeCV-0004H9-6T
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 05:56:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so26334899wml.2
	for <qemu-devel@nongnu.org>; Wed, 02 Jan 2019 02:56:37 -0800 (PST)
References: <20190102102243.28822-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7c055c4c-075a-8c32-110a-e88afa81b074@redhat.com>
Date: Wed, 2 Jan 2019 11:56:35 +0100
MIME-Version: 1.0
In-Reply-To: <20190102102243.28822-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: add qemu_vga.ndrv file entry
 for Mac machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 1/2/19 11:22 AM, Mark Cave-Ayland wrote:
> The VGA driver built from Ben's QemuMacDrivers repository is used exclusively
> by the Mac machines.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 344cb2d7fd..3da3d103b1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -965,6 +965,7 @@ F: include/hw/misc/macio/
>  F: include/hw/misc/mos6522.h
>  F: include/hw/ppc/mac_dbdma.h
>  F: include/hw/pci-host/uninorth.h
> +F: pc-bios/qemu_vga.ndrv
>  
>  Old World
>  M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> @@ -976,6 +977,7 @@ F: hw/pci-host/grackle.c
>  F: hw/misc/macio/
>  F: hw/intc/heathrow_pic.c
>  F: include/hw/intc/heathrow_pic.h
> +F: pc-bios/qemu_vga.ndrv
>  
>  PReP
>  M: Hervé Poussineau <hpoussin@reactos.org>
> 
