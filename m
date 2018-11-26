Received: from eggs.gnu.org ([2001:4830:134:3::10]:47837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gRKHi-0004qY-A0
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:02:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gRKHe-0000xr-Li
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:02:58 -0500
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-10-philmd@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <d4959433-0436-9806-4a33-8a2d8ba96ebc@ilande.co.uk>
Date: Mon, 26 Nov 2018 17:02:44 +0000
MIME-Version: 1.0
In-Reply-To: <20181125205000.10324-10-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 09/25] MAINTAINERS: Add a missing
 entry for the sun4m machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 25/11/2018 20:49, Philippe Mathieu-Daudé wrote:

> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa51ae813b..ba9cd9ac2b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1013,6 +1013,7 @@ F: hw/misc/eccmemctl.c
>  F: hw/misc/slavio_misc.c
>  F: include/hw/sparc/sparc32_dma.h
>  F: pc-bios/openbios-sparc32
> +F: include/hw/sparc/sun4m_iommu.h
>  
>  Sun4u
>  M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.
