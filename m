Received: from eggs.gnu.org ([2001:4830:134:3::10]:45321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPt2m-00048R-Gj
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 13:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPt2l-0004K3-L0
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 13:13:20 -0400
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:35461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPt2l-0004ID-Fl
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 13:13:19 -0400
Received: by mail-ot0-x22f.google.com with SMTP id q17-v6so28015150otg.2
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 10:13:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180530180120.13355-11-richard.henderson@linaro.org>
References: <20180530180120.13355-1-richard.henderson@linaro.org>
	<20180530180120.13355-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Jun 2018 18:12:58 +0100
Message-ID: <CAFEAcA--ORAcmi1h74EeRpSY40tJ=wvAVTT9594A_oMFty5pZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3b 10/18] target/arm: Implement SVE Select
 Vectors Group
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
>  target/arm/helper-sve.h    |  9 +++++++
>  target/arm/sve_helper.c    | 55 ++++++++++++++++++++++++++++++++++++++
>  target/arm/translate-sve.c |  2 ++
>  target/arm/sve.decode      |  6 +++++
>  4 files changed, 72 insertions(+)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
