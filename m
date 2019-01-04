Received: from eggs.gnu.org ([208.118.235.92]:35508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfSpi-0000go-JV
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:00:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfSpg-0001rI-N0
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:00:30 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfSpg-0001ji-0T
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:00:28 -0500
Received: by mail-oi1-x241.google.com with SMTP id x202so30833388oif.13
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 09:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20181214052410.11863-1-richard.henderson@linaro.org>
	<20181214052410.11863-8-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 17:00:13 +0000
Message-ID: <CAFEAcA_f_sRW4g2mmADE4QozGYdkKyASgi4VYhs8BVqCLg5s_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 07/27] target/arm: Decode PAuth within
 disas_data_proc_1src
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

On Fri, 14 Dec 2018 at 05:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-a64.c | 146 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 146 insertions(+)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
