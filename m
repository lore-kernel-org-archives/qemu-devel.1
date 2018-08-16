Received: from eggs.gnu.org ([2001:4830:134:3::10]:32906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqLNN-00056k-Na
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqLNI-0000d2-2p
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:43:57 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43761)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fqLNH-0000bv-P2
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:43:51 -0400
Received: by mail-pf1-x444.google.com with SMTP id j26-v6so2262039pfi.10
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 09:43:51 -0700 (PDT)
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-45-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d3d96f8a-edf9-9c72-4672-37afc4a1d102@linaro.org>
Date: Thu, 16 Aug 2018 09:43:47 -0700
MIME-Version: 1.0
In-Reply-To: <1534431497-1385-45-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 44/84] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 3
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
> From: Stefan Markovic <smarkovic@wavecomp.com>
> 
> Add emulation of DSP ASE instructions for nanoMIPS - part 3.
> 
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 183 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 183 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
