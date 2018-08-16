Received: from eggs.gnu.org ([2001:4830:134:3::10]:52063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqKu5-0001ZK-KK
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqKu1-0001k1-Oy
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:13:40 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:41376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fqKu1-0001ji-JG
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:13:37 -0400
Received: by mail-pl0-x244.google.com with SMTP id w19-v6so2311314ply.8
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 09:13:37 -0700 (PDT)
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-33-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b6da9a36-8632-755d-4c44-2f7523d70399@linaro.org>
Date: Thu, 16 Aug 2018 09:13:34 -0700
MIME-Version: 1.0
In-Reply-To: <1534431497-1385-33-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 32/84] target/mips: Add emulation of
 misc nanoMIPS instructions (pool32a0)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 08/16/2018 07:57 AM, Aleksandar Markovic wrote:
> From: Yongbok Kim <yongbok.kim@mips.com>
> 
> Add emulation of nanoMIPS instructions that are situated in pool32a0.
> 
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 185 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 185 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
