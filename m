Received: from eggs.gnu.org ([2001:4830:134:3::10]:46411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgBnP-0003I3-GJ
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgBnK-0006a5-Rd
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:28:51 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgBnK-0006Zn-JL
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 12:28:46 -0400
Received: by mail-pg1-x543.google.com with SMTP id v13-v6so4227668pgr.10
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 09:28:46 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-4-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <37f2db69-7c82-10f5-e1af-9c059c7a9fdd@linaro.org>
Date: Thu, 19 Jul 2018 09:28:42 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-4-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/40] target/mips: Add nanoMIPS DSP ASE
 opcodes
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

On 07/19/2018 05:54 AM, Stefan Markovic wrote:
> From: Stefan Markovic <smarkovic@wavecomp.com>
> 
> Add nanoMIPS opcodes for DSP ASE instruction pools and instructions.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 144 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
