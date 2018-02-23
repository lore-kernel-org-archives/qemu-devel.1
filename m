Received: from eggs.gnu.org ([2001:4830:134:3::10]:35090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epDMI-0006HZ-SI
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:25:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epDMH-0001NC-UG
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:25:54 -0500
Received: from mail-pg0-x22c.google.com ([2607:f8b0:400e:c05::22c]:45198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epDMH-0001MZ-OZ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:25:53 -0500
Received: by mail-pg0-x22c.google.com with SMTP id e11so3347247pgq.12
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 05:25:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-19-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 13:25:32 +0000
Message-ID: <CAFEAcA_5-Q_or5JhwZSBAdhzm=0wdSK5meA9Bw4v3zMzuU6Svg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 18/67] target/arm: Implement SVE Stack
 Allocation Group
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

On 17 February 2018 at 18:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-sve.c | 24 ++++++++++++++++++++++++
>  target/arm/sve.decode      | 12 ++++++++++++
>  2 files changed, 36 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
