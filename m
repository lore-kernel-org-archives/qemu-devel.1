Received: from eggs.gnu.org ([2001:4830:134:3::10]:59996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqgdg-0000E2-UB
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:53:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqgdg-0000tO-6q
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:53:56 -0500
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:34002)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqgdg-0000pb-0F
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 09:53:56 -0500
Received: by mail-oi0-x22b.google.com with SMTP id c83so13068809oib.1
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 06:53:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-56-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-56-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 14:53:34 +0000
Message-ID: <CAFEAcA9tOn4cJEeZSuEyyAMO=i-+=A7HX9Rft7HcEVPXNSyweA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 55/67] target/arm: Implement
 SVE gather loads
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

On 17 February 2018 at 18:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    | 67 ++++++++++++++++++++++++++++++++
>  target/arm/sve_helper.c    | 75 +++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      | 53 +++++++++++++++++++++++++
>  4 files changed, 292 insertions(+)
>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
