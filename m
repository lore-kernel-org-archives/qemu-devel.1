Received: from eggs.gnu.org ([2001:4830:134:3::10]:42448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqffV-0005GA-Sk
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:51:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqffV-0004RK-75
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:51:45 -0500
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:40217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqffV-0004Qd-2L
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:51:45 -0500
Received: by mail-oi0-x234.google.com with SMTP id c12so12895453oic.7
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 05:51:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-48-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-48-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 13:51:24 +0000
Message-ID: <CAFEAcA8bW2W7acrwtS632ongJb0Ly1mcneNqn4XS+cj_n3=MyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 47/67] target/arm: Implement SVE integer
 convert to floating-point
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


> +/*
> + *** SVE Floating Point Unary Operations Prediated Group
> + */

Just noticed the typo: should be "Predicated".

thanks
-- PMM
