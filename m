Received: from eggs.gnu.org ([2001:4830:134:3::10]:42184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXmrR-0000Vk-Av
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:14:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXmrQ-0005Nx-Cb
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:14:17 -0400
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:45704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXmrQ-0005Nm-7u
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:14:16 -0400
Received: by mail-ot0-x235.google.com with SMTP id k3-v6so5177797otl.12
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 05:14:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-27-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 13:13:55 +0100
Message-ID: <CAFEAcA-Qa=KBaQ4ZyjT3SrgxLm_VX6H70nEa2tD3pD-mK=rMCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 26/35] target/arm: Implement SVE
 floating-point unary operations
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
>  target/arm/helper-sve.h    | 14 ++++++++++++++
>  target/arm/sve_helper.c    |  8 ++++++++
>  target/arm/translate-sve.c | 26 ++++++++++++++++++++++++++
>  target/arm/sve.decode      |  4 ++++
>  4 files changed, 52 insertions(+)
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
