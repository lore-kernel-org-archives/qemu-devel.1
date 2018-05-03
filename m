Received: from eggs.gnu.org ([2001:4830:134:3::10]:60061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEE45-0005PE-9F
	for qemu-devel@nongnu.org; Thu, 03 May 2018 09:14:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEE44-0003a4-EK
	for qemu-devel@nongnu.org; Thu, 03 May 2018 09:14:29 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:36658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEE44-0003ZV-A3
	for qemu-devel@nongnu.org; Thu, 03 May 2018 09:14:28 -0400
Received: by mail-ot0-x242.google.com with SMTP id m11-v6so14377211otf.3
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 06:14:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180427002651.28356-3-richard.henderson@linaro.org>
References: <20180427002651.28356-1-richard.henderson@linaro.org>
	<20180427002651.28356-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 May 2018 14:14:07 +0100
Message-ID: <CAFEAcA8sB72ttJbid89g__dg1GbSSyiJBFbMHsnG8m49z-8a0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/9] target/arm: Use new min/max
 expanders
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 27 April 2018 at 01:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The generic expanders replace nearly identical code in the translator.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 46 ++++++++++++++--------------------------------
>  1 file changed, 14 insertions(+), 32 deletions(-)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
