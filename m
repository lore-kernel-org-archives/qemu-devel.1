Received: from eggs.gnu.org ([2001:4830:134:3::10]:57353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epGth-0002Rr-UH
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:12:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epGth-0004Ll-03
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:12:37 -0500
Received: from mail-pl0-x22f.google.com ([2607:f8b0:400e:c01::22f]:38442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epGtg-0004JY-O7
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:12:36 -0500
Received: by mail-pl0-x22f.google.com with SMTP id d4so5236017pll.5
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 09:12:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180217182323.25885-42-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-42-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 17:12:15 +0000
Message-ID: <CAFEAcA92ENqt_qV-n9T59PBbSjyWJFxhOuaN3Me3PvGSFS3_Rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 41/67] target/arm: Implement FDUP/DUP
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
>  target/arm/translate-sve.c | 35 +++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  8 ++++++++
>  2 files changed, 43 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
