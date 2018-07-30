Received: from eggs.gnu.org ([2001:4830:134:3::10]:36566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkFE7-0001qV-0e
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkFE3-0005GO-VH
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:57:11 -0400
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242]:36861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkFE3-0005GB-Po
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 16:57:07 -0400
Received: by mail-ua0-x242.google.com with SMTP id c12-v6so8811602uan.3
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 13:57:07 -0700 (PDT)
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-22-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9d95bdd1-64ec-7b14-3bbf-0d799aa2701a@linaro.org>
Date: Mon, 30 Jul 2018 16:57:02 -0400
MIME-Version: 1.0
In-Reply-To: <1532967169-22265-22-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 21/76] target/mips: Add emulation of
 nanoMIPS 16-bit shift instructions
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
> Add emulation of nanoMIPS 16-bit shift instructions.
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/translate.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
