Received: from eggs.gnu.org ([2001:4830:134:3::10]:50738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqMCp-0001JJ-1m
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:37:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqMCl-000285-3R
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:37:07 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:42202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fqMCk-00027r-T3
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:37:03 -0400
Received: by mail-pl0-x242.google.com with SMTP id g6-v6so2417793plq.9
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 10:37:02 -0700 (PDT)
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-47-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <04af817d-732f-7f61-a9e4-66c6f91318eb@linaro.org>
Date: Thu, 16 Aug 2018 10:36:59 -0700
MIME-Version: 1.0
In-Reply-To: <1534431497-1385-47-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 46/84] target/mips: Add emulation of DSP
 ASE for nanoMIPS - part 5
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
> Add emulation of DSP ASE instructions for nanoMIPS - part 5.
> 
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 142 insertions(+)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
