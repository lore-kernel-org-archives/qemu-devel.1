Received: from eggs.gnu.org ([2001:4830:134:3::10]:52446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqKvD-0002fX-UE
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:14:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqKv8-0002bW-3y
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:14:50 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fqKv4-0002Xs-Ez
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:14:43 -0400
Received: by mail-pf1-x444.google.com with SMTP id j8-v6so2234820pff.6
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 09:14:41 -0700 (PDT)
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-35-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <66c7a1af-5dc8-7e29-e950-40345cb30900@linaro.org>
Date: Thu, 16 Aug 2018 09:14:38 -0700
MIME-Version: 1.0
In-Reply-To: <1534431497-1385-35-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 34/84] target/mips: Add emulation of
 misc nanoMIPS instructions (p_lsx)
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
> Add emulation of nanoMIPS instructions situated in pool p_lsx, and
> emulation of LSA instruction as well.
> 
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 131 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
