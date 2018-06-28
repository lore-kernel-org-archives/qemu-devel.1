Received: from eggs.gnu.org ([2001:4830:134:3::10]:44141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYWKx-0000fh-BQ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYWKw-00029S-LK
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:47:47 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:33615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYWKw-00028C-Fp
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:47:46 -0400
Received: by mail-ot0-x241.google.com with SMTP id h6-v6so5980046otj.0
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 05:47:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627043328.11531-32-richard.henderson@linaro.org>
References: <20180627043328.11531-1-richard.henderson@linaro.org>
	<20180627043328.11531-32-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 13:47:24 +0100
Message-ID: <CAFEAcA98L_XYJJt6LWa28=EKnNBbS56W7WLVZ+w+u=xVrcNm9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 31/35] target/arm: Implement SVE fp
 complex multiply add (indexed)
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

On 27 June 2018 at 05:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Enhance the existing helpers to support SVE, which takes the
> index from each 128-bit segment.  The change has no effect
> for AdvSIMD, since there is only one such segment.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
