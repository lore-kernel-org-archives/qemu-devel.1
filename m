Received: from eggs.gnu.org ([2001:4830:134:3::10]:60838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgB3b-0004Po-4J
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:41:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgB3X-00055L-74
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:41:31 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgB3W-000552-N6
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:41:27 -0400
Received: by mail-pg1-x543.google.com with SMTP id y4-v6so4108290pgp.9
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 08:41:26 -0700 (PDT)
References: <1532004727-13778-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004727-13778-9-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <36cd9481-b4cb-48bf-79b0-af662f74e243@linaro.org>
Date: Thu, 19 Jul 2018 08:41:22 -0700
MIME-Version: 1.0
In-Reply-To: <1532004727-13778-9-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 08/11] elf: Remove duplicate
 preprocessor constant definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/19/2018 05:52 AM, Stefan Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Remove duplicate preprocessor constant definition for EF_MIPS_ARCH.
> 
> The duplicate was introduced in commit 45506bdd.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  include/elf.h | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
