Received: from eggs.gnu.org ([2001:4830:134:3::10]:57983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQGKx-0005dg-LA
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQGKv-00071V-Tt
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:05:39 -0400
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:33061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQGKv-00070M-O3
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:05:37 -0400
Received: by mail-ot0-x234.google.com with SMTP id h6-v6so3947421otj.0
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 11:05:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180530180120.13355-17-richard.henderson@linaro.org>
References: <20180530180120.13355-1-richard.henderson@linaro.org>
	<20180530180120.13355-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Jun 2018 19:05:16 +0100
Message-ID: <CAFEAcA-O7DuYhFgMAY41BLQUs18+BECJ4D=hKfhgVdLUf-Ub+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3b 16/18] target/arm: Implement FDUP/DUP
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

On 30 May 2018 at 19:01, Richard Henderson <richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate-sve.c | 37 +++++++++++++++++++++++++++++++++++++
>  target/arm/sve.decode      |  8 ++++++++
>  2 files changed, 45 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
