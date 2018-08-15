Received: from eggs.gnu.org ([2001:4830:134:3::10]:46637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fpux0-0002Sa-Hi
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fpuwT-0007J0-1w
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:30:26 -0400
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:44310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fpuw2-0005s3-6Y
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 08:30:01 -0400
Received: by mail-oi0-x22d.google.com with SMTP id s198-v6so1578053oih.11
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 05:29:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180814181815.23348-1-peter.maydell@linaro.org>
References: <20180814181815.23348-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Aug 2018 13:29:34 +0100
Message-ID: <CAFEAcA86XV13pSpYQYDm-NgLFmhP3MzOCkS4PSa-P11DxAg3iw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/45] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 14 August 2018 at 19:17, Peter Maydell <peter.maydell@linaro.org> wrote:
> First pullreq of the 3.1 release cycle, with lots of
> Arm related patches accumulated during freeze. Most
> notable here is Luc's GICv2 virtualization support and
> my execute-from-MMIO patches.
>
> I stopped looking at my to-review queue towards the
> end of freeze, since 45 patches is already pushing what
> I consider a reasonable sized pullreq; once this goes into
> master I'll start working through it again.
>
> thanks
> -- PMM
>
> The following changes since commit 38441756b70eec5807b5f60dad11a93a91199866:
>
>   Update version for v3.0.0 release (2018-08-14 16:38:43 +0100)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180814
>
> for you to fetch changes up to 054e7adf4e64e4acb3b033348ebf7cc871baa34f:
>
>   target/arm: Fix typo in helper_sve_movz_d (2018-08-14 17:17:22 +0100)
>

Applied, thanks.

-- PMM
