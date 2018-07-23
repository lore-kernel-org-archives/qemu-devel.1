Received: from eggs.gnu.org ([2001:4830:134:3::10]:57009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fheET-0006Ya-1O
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:02:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fheES-0006SA-B1
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:02:49 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fheES-0006Rr-3A
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:02:48 -0400
Received: by mail-pf1-x442.google.com with SMTP id e13-v6so210638pff.7
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 10:02:47 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-35-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bdd0e035-1c40-7b79-e734-3b0f44891021@linaro.org>
Date: Mon, 23 Jul 2018 10:02:44 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-35-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 34/40] linux-user: Don't check
 FCR31_NAN2008 bit for nanoMIPS
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

On 07/19/2018 05:55 AM, Stefan Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  linux-user/mips/cpu_loop.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
