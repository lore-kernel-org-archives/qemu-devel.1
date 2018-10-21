Received: from eggs.gnu.org ([2001:4830:134:3::10]:39452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDQb-0004B7-24
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDIO-0003KT-BW
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 08:57:31 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:40656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDIN-0003K9-QC
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 08:57:28 -0400
Received: by mail-wr1-x436.google.com with SMTP id d2-v6so41991097wro.7
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 05:57:27 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-12-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5c3f6616-e22c-5b58-bebe-efbbdddd8f2e@linaro.org>
Date: Sun, 21 Oct 2018 13:57:23 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-12-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 11/56] sh4: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/sh4/op_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
