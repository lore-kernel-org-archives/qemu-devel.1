Received: from eggs.gnu.org ([2001:4830:134:3::10]:48384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXkyT-0000cu-SE
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXkyT-0008Mz-2P
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:13:25 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:42877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXkyS-0008Mo-Sn
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:13:24 -0400
Received: by mail-oi0-x241.google.com with SMTP id n84-v6so7839475oib.9
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 03:13:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-21-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-21-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 11:13:03 +0100
Message-ID: <CAFEAcA___+-R6xXQRLBO7MwEVBrDsGE0393OuYfh96TkgAaDgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 20/35] target/arm: Implement SVE
 Floating Point Unary Operations - Unpredicated Group
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
>  target/arm/helper.h        |  8 +++++++
>  target/arm/translate-sve.c | 47 ++++++++++++++++++++++++++++++++++++++
>  target/arm/vec_helper.c    | 20 ++++++++++++++++
>  target/arm/sve.decode      |  5 ++++
>  4 files changed, 80 insertions(+)
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
