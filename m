Received: from eggs.gnu.org ([2001:4830:134:3::10]:40166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fcXws-0007vI-A5
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fcXwn-0004Q7-UY
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:19:34 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fcXwn-0004Pt-NE
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:19:29 -0400
Received: by mail-pg1-x542.google.com with SMTP id y5-v6so1326354pgv.1
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 08:19:29 -0700 (PDT)
References: <1531137463-28014-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1531137463-28014-6-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ffec5782-bc11-fc0b-717f-f5be5ef63ef1@linaro.org>
Date: Mon, 9 Jul 2018 08:19:26 -0700
MIME-Version: 1.0
In-Reply-To: <1531137463-28014-6-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 5/7] target/mips: Add CP0 BadInstrX
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: pburton@wavecomp.com, smarkovic@wavecomp.com, philippe.mathieu.daude@gmail.com, amarkovic@wavecomp.com, pjovanovic@wavecomp.com, aurelien@aurel32.net

On 07/09/2018 04:57 AM, Aleksandar Markovic wrote:
> From: Stefan Markovic <smarkovic@wavecomp.com>
> 
> Add CP0 BadInstrX register. This register will be used in nanoMIPS.
> 
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/mips/cpu.h       |  1 +
>  target/mips/machine.c   |  5 +++--
>  target/mips/translate.c | 22 +++++++++++++++++++++-
>  3 files changed, 25 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
