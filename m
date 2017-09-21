Received: from eggs.gnu.org ([2001:4830:134:3::10]:33996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dv1iN-0000jJ-Bh
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dv1iH-0007e3-QL
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:40:27 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:56456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dv1iH-0007dm-IQ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:40:21 -0400
Received: by mail-wr0-x22b.google.com with SMTP id r74so4599730wrb.13
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 06:40:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170921075134.GB19099@kentang.lan>
References: <20170921075134.GB19099@kentang.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2017 14:39:59 +0100
Message-ID: <CAFEAcA-mKF_2E_ZjC8QYY5qpeCx+9tqwBNtc-DQY4gfqAc-Dcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL] qemu-sparc updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 September 2017 at 08:51, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> Hi Peter,
>
> This contains the code for the new Sun HME (Happy Meal Ethernet) card and switches the sun4u machine
> over to use it as the default. Please pull.
>
>
> ATB,
>
> Mark.
>
>
> The following changes since commit b62b7ed0fc9c58e373b8946c9bd2e193be98dae6:
>
>   Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2017-09-20 20:33:48 +0100)
>
> are available in the git repository at:
>
>
>   https://github.com/mcayland/qemu.git tags/qemu-sparc-signed
>
> for you to fetch changes up to 8d9329719cc0996e5837fb466ca4d7be8030f8c9:
>
>   sun4u: use sunhme as default on-board NIC (2017-09-21 08:38:42 +0100)
>
> ----------------------------------------------------------------
> qemu-sparc update
>
> ----------------------------------------------------------------
> Mark Cave-Ayland (2):
>       net: add Sun HME (Happy Meal Ethernet) on-board NIC
>       sun4u: use sunhme as default on-board NIC

Applied, thanks.

-- PMM
