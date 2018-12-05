Received: from eggs.gnu.org ([2001:4830:134:3::10]:49552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gUXNE-0007Dz-T2
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:37:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gUXNB-0005Gp-Kh
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:37:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gUXNB-0005G0-Cs
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:37:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so19719716wra.6
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 05:37:53 -0800 (PST)
References: <20181205124812.10552-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9f4643a6-6305-a132-b7ce-626acac35c8c@redhat.com>
Date: Wed, 5 Dec 2018 14:37:49 +0100
MIME-Version: 1.0
In-Reply-To: <20181205124812.10552-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: update status of FPU emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, aurelien@aurel32.net

On 12/5/18 1:48 PM, Alex Bennée wrote:
> Given I've spent a fair amount of time around this code now I'm
> putting myself forward as a maintainer. Also given that the code has
> been extensively re-written and has testing and new incoming features
> it's probably more than just Odd Fixes.

Thanks!

> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 63effdc473..aeee83ba0e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -127,9 +127,11 @@ F: include/sysemu/cpus.h
>  FPU emulation
>  M: Aurelien Jarno <aurelien@aurel32.net>
>  M: Peter Maydell <peter.maydell@linaro.org>
> -S: Odd Fixes
> +M: Alex Bennée <alex.bennee@linaro.org>
> +S: Maintained
>  F: fpu/
>  F: include/fpu/
> +F: tests/fp/
>  
>  Alpha
>  M: Richard Henderson <rth@twiddle.net>
> 
