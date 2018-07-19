Received: from eggs.gnu.org ([2001:4830:134:3::10]:59616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgAzD-00012Z-J2
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgAz9-0002fW-9u
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:36:59 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgAz9-0002fM-2q
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:36:55 -0400
Received: by mail-pg1-x541.google.com with SMTP id r5-v6so4106435pgv.0
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 08:36:54 -0700 (PDT)
References: <1532004727-13778-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004727-13778-4-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <472dd83b-b361-2b7e-f29c-da47f1d270f5@linaro.org>
Date: Thu, 19 Jul 2018 08:36:51 -0700
MIME-Version: 1.0
In-Reply-To: <1532004727-13778-4-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 03/11] target/mips: Update some CP0
 registers bit definitions
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

On 07/19/2018 05:51 AM, Stefan Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Update CP0 registers Config0, Config1, Config2, Config3,
> Config4, and Config5 bit definitions.
> 
> Some of these bits will be utilized by upcoming nanoMIPS changes.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/mips/cpu.h | 157 ++++++++++++++++++++++++++++++------------------------
>  1 file changed, 88 insertions(+), 69 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
