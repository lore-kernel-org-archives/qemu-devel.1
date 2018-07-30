Received: from eggs.gnu.org ([2001:4830:134:3::10]:36450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkFDe-0001cm-Ts
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkFDb-0005Ag-RQ
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:56:43 -0400
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243]:40001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkFDb-0005AU-Lg
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:56:39 -0400
Received: by mail-vk0-x243.google.com with SMTP id q184-v6so3190276vke.7
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 13:56:39 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-21-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <feec6938-90d4-3271-40ac-9d11c9f64257@linaro.org>
Date: Mon, 30 Jul 2018 16:56:34 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-21-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 20/76] target/mips: Add emulation of
 nanoMIPS 16-bit branch instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/30/2018 12:11 PM, Aleksandar Markovic wrote:
> From: Yongbok Kim <yongbok.kim@mips.com>
> 
> Add emulation of nanoMIPS 16-bit branch instructions.
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
