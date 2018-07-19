Received: from eggs.gnu.org ([2001:4830:134:3::10]:33825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgB9A-0006sN-Tp
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgB97-0007r7-21
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:47:16 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:34099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgB96-0007pw-Pu
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:47:12 -0400
Received: by mail-pl0-x243.google.com with SMTP id f6-v6so3839620plo.1
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 08:47:12 -0700 (PDT)
References: <1532004727-13778-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004727-13778-10-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4dc414e8-1e41-bdd2-2ddd-1c24751b3bf7@linaro.org>
Date: Thu, 19 Jul 2018 08:47:08 -0700
MIME-Version: 1.0
In-Reply-To: <1532004727-13778-10-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 09/11] elf: Add ELF flags for MIPS
 machine variants
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
> Add MIPS machine variants ELF flags so that the emulation behavior
> can be adjusted if needed.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  include/elf.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
