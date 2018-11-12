Received: from eggs.gnu.org ([2001:4830:134:3::10]:43958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gM7Ot-0006Ys-PQ
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:16:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gM7Om-0008Sh-ET
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:16:50 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:32836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gM7Oh-0008PG-47
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:16:41 -0500
Received: by mail-wr1-x444.google.com with SMTP id u9-v6so8232569wrr.0
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 00:16:31 -0800 (PST)
References: <20181111233622.8976-1-f4bug@amsat.org>
	<20181111233622.8976-4-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b64f1d38-571e-7bbb-a25c-aec66df0d4ee@linaro.org>
Date: Mon, 12 Nov 2018 09:16:27 +0100
MIME-Version: 1.0
In-Reply-To: <20181111233622.8976-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 03/11] target/mips: Move the
 !ISA_MIPS32R6 check out of decode_opc_special2_legacy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>, Richard Henderson <rth@twiddle.net>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 11/12/18 12:36 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/mips/translate.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
