Received: from eggs.gnu.org ([2001:4830:134:3::10]:45961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXTXG-0001Ps-NJ
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:36:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXTXF-0003DA-Vk
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:36:10 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:34071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXTXF-0003Cs-QK
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:36:09 -0400
Received: by mail-oi0-x231.google.com with SMTP id c2-v6so1232212oic.1
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 08:36:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-9-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 16:35:48 +0100
Message-ID: <CAFEAcA95_KOz6BHiVxgXRLfo0FJu7koAP-7qr9Rtmhjdc7TvKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 08/35] target/arm: Implement SVE
 Floating Point Accumulating Reduction Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 June 2018 at 02:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  7 +++++
>  target/arm/sve_helper.c    | 56 ++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 45 ++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  5 ++++
>  4 files changed, 113 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
