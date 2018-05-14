Received: from eggs.gnu.org ([2001:4830:134:3::10]:42916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fI98K-0005Tt-Au
	for qemu-devel@nongnu.org; Mon, 14 May 2018 04:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fI98J-00015W-Mg
	for qemu-devel@nongnu.org; Mon, 14 May 2018 04:47:04 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:35739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fI98J-00014u-Gs
	for qemu-devel@nongnu.org; Mon, 14 May 2018 04:47:03 -0400
Received: by mail-ot0-x243.google.com with SMTP id h8-v6so13349505otb.2
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 01:47:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180510174519.11264-1-peter.maydell@linaro.org>
References: <20180510174519.11264-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 09:46:42 +0100
Message-ID: <CAFEAcA-6_G+izAH_JQLJDYvKDW58VY+-LL4N9pgOTiKqyDCrog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/21] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 10 May 2018 at 18:44, Peter Maydell <peter.maydell@linaro.org> wrote:
> The following changes since commit e5cd695266c5709308aa95b1baae499e4b5d4544:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2018-05-08 17:05:58 +0100)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180510
>
> for you to fetch changes up to 9a9f1f59521f46e8ff4527d9a2b52f83577e2aa3:
>
>   target/arm: Clear SVE high bits for FMOV (2018-05-10 18:10:58 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * hw/arm/iotkit.c: fix minor memory leak
>  * softfloat: fix wrong-exception-flags bug for multiply-add corner case
>  * arm: isolate and clean up DTB generation
>  * implement Arm v8.1-Atomics extension
>  * Fix some bugs and missing instructions in the v8.2-FP16 extension
>

Applied, thanks.

-- PMM
