Received: from eggs.gnu.org ([2001:4830:134:3::10]:45598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fi2tf-0008Lk-9P
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 15:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fi2te-0001Bs-8H
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 15:22:59 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fi2te-0001BG-0H
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 15:22:58 -0400
Received: by mail-pg1-x541.google.com with SMTP id y5-v6so3572398pgv.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 12:22:57 -0700 (PDT)
References: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532453527-22911-6-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d5fc2056-9178-f2bb-6d06-eb5d15bab98f@linaro.org>
Date: Tue, 24 Jul 2018 12:22:54 -0700
MIME-Version: 1.0
In-Reply-To: <1532453527-22911-6-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 05/55] target/mips: Add nanoMIPS
 decoding and extraction utilities
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

On 07/24/2018 10:31 AM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Add some basic utility functions and macros for nanoMIPS decoding
> engine.
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
