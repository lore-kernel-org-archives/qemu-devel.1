Received: from eggs.gnu.org ([2001:4830:134:3::10]:60651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gK6QA-0006Jz-34
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 13:49:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gK6Q6-0001Uo-Nt
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 13:49:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gK6Q6-0001Ee-Ds
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 13:49:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id a8-v6so13227763wmf.1
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 10:49:35 -0800 (PST)
References: <1541528230-31817-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c0febf9a-f098-112d-9c8d-c320cc66b04a@redhat.com>
Date: Tue, 6 Nov 2018 19:49:32 +0100
MIME-Version: 1.0
In-Reply-To: <1541528230-31817-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add an entry for the 'collie'
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, qemu-devel@nongnu.org

On 6/11/18 19:17, Thomas Huth wrote:
> There is no active maintainer, but since Peter is picking up
> patches via qemu-arm@nongnu.org, I think we could at least use
> "Odd Fixes" as status here.

This looks more as "Orphan" to me...

Regardless the one choosed:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0499e11..471cf72 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -592,6 +592,12 @@ F: hw/*/pxa2xx*
>   F: hw/misc/mst_fpga.c
>   F: include/hw/arm/pxa.h
>   
> +Sharp SL-5500 (Collie) PDA
> +L: qemu-arm@nongnu.org
> +S: Odd Fixes
> +F: hw/arm/collie.c
> +F: hw/arm/strongarm*
> +
>   Stellaris
>   M: Peter Maydell <peter.maydell@linaro.org>
>   L: qemu-arm@nongnu.org
> 
