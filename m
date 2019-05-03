Received: from eggs.gnu.org ([209.51.188.92]:52192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hMTIM-0001UJ-Cv
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hMTIL-0008Oo-CW
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:11:50 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:34566
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hMTIL-0008O7-5r
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:11:49 -0400
References: <1556194715-24427-1-git-send-email-frederic.konrad@adacore.com>
	<1556194715-24427-4-git-send-email-frederic.konrad@adacore.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <60441e06-1777-5abf-46a0-bf76864f54f5@ilande.co.uk>
Date: Fri, 3 May 2019 09:11:45 +0100
MIME-Version: 1.0
In-Reply-To: <1556194715-24427-4-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] MAINTAINERS: add myself for leon3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, chouteau@adacore.com, philmd@redhat.com, atar4qemu@gmail.com

On 25/04/2019 13:18, KONRAD Frederic wrote:

> Reviewed-by: Fabien Chouteau <chouteau@adacore.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23db6f8..6f7d237 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1151,6 +1151,7 @@ F: include/hw/timer/sun4v-rtc.h
>  
>  Leon3
>  M: Fabien Chouteau <chouteau@adacore.com>
> +M: KONRAD Frederic <frederic.konrad@adacore.com>
>  S: Maintained
>  F: hw/sparc/leon3.c
>  F: hw/*/grlib*

See my previous note about missing an entry for the new
include/hw/misc/grlib_ahb_apb_pnp.h file, but otherwise:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.
