Received: from eggs.gnu.org ([2001:4830:134:3::10]:57419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJLMP-0002jk-Ug
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJLMK-0002eo-5r
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:02:34 -0400
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:46694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJLMK-0002eT-1Y
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:02:28 -0400
Received: by mail-ot0-x233.google.com with SMTP id t1-v6so5601593ott.13
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 09:02:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180516223007.10256-5-richard.henderson@linaro.org>
References: <20180516223007.10256-1-richard.henderson@linaro.org>
	<20180516223007.10256-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 May 2018 17:02:06 +0100
Message-ID: <CAFEAcA9QyVB4BBrtygCpNO_jroydUBM1oS8D7J7ahx0X5qmtkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3-a 04/27] target/arm: Implement SVE load
 vector/predicate
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

On 16 May 2018 at 23:29, Richard Henderson <richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-sve.c | 127 +++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  20 ++++++
>  2 files changed, 147 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
