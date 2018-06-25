Received: from eggs.gnu.org ([2001:4830:134:3::10]:57673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXUCl-00034Z-5J
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXUCk-0006HL-EA
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:19:03 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXUCk-0006Gu-9H
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:19:02 -0400
Received: by mail-oi0-x242.google.com with SMTP id e8-v6so13059652oii.2
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 09:19:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-13-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 17:18:41 +0100
Message-ID: <CAFEAcA_9FCZkEuO=p3OqFBZ1rz5MFfTshU9OADZVj-gqkAsMZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 12/35] target/arm: Implement SVE
 prefetches
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
>  target/arm/translate-sve.c | 21 +++++++++++++++++++++
>  target/arm/sve.decode      | 23 +++++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
