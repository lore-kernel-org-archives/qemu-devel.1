Received: from eggs.gnu.org ([209.51.188.92]:40281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIw1u-0006kK-2v
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIw1L-0007Bi-Sj
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:03:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hIw1L-0007Av-N1
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:03:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id c6so14693146wrm.1
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 07:03:39 -0700 (PDT)
References: <1555669092-10351-1-git-send-email-frederic.konrad@adacore.com>
	<1555669092-10351-4-git-send-email-frederic.konrad@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9971c427-45e2-4f3b-b871-19539da11a41@redhat.com>
Date: Tue, 23 Apr 2019 16:03:35 +0200
MIME-Version: 1.0
In-Reply-To: <1555669092-10351-4-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V1 3/3] MAINTAINERS: add myself for leon3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com, chouteau@adacore.com

On 4/19/19 12:18 PM, KONRAD Frederic wrote:
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 56139ac..3543035 100644
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
> 

Thank you for stepping in!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
