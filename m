Received: from eggs.gnu.org ([2001:4830:134:3::10]:58006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJLO9-00043q-Ng
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJLO5-000394-SF
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:04:21 -0400
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:36745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJLO5-00038t-O7
	for qemu-devel@nongnu.org; Thu, 17 May 2018 12:04:17 -0400
Received: by mail-ot0-x230.google.com with SMTP id m11-v6so5648907otf.3
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 09:04:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180516223007.10256-9-richard.henderson@linaro.org>
References: <20180516223007.10256-1-richard.henderson@linaro.org>
	<20180516223007.10256-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 May 2018 17:03:56 +0100
Message-ID: <CAFEAcA8ATbdfprPZRJmPjF_KBnnBsmrW+kH6Cm2_8QqGufQkAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3-a 08/27] target/arm: Implement SVE
 Integer Binary Arithmetic - Predicated Group
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
>  target/arm/helper-sve.h    | 145 +++++++++++++++++++++++++++
>  target/arm/sve_helper.c    | 194 +++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c |  68 +++++++++++++
>  target/arm/sve.decode      |  42 ++++++++
>  4 files changed, 449 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
