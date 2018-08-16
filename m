Received: from eggs.gnu.org ([2001:4830:134:3::10]:47396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqO2j-0003h5-C0
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqO2f-0005yI-E2
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:34:49 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:40029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fqO2e-0005xU-Tj
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:34:45 -0400
Received: by mail-pf1-x430.google.com with SMTP id e13-v6so2459082pff.7
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 12:34:44 -0700 (PDT)
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-56-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7ab7fae7-41f2-f1a8-81bd-b7e9f789bad8@linaro.org>
Date: Thu, 16 Aug 2018 12:34:40 -0700
MIME-Version: 1.0
In-Reply-To: <1534431497-1385-56-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 55/84] elf: Add EM_NANOMIPS value as a
 valid one for e_machine field
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
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
> 
> Value 249 is registered as valid for usage for nanoMIPS executables.
> 
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  include/elf.h | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
