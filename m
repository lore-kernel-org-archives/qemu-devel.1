Received: from eggs.gnu.org ([2001:4830:134:3::10]:43993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ff37g-0002E3-7g
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ff37c-0002oc-Fy
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:01:04 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:46310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ff37c-0002oD-Ag
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:01:00 -0400
Received: by mail-oi0-x244.google.com with SMTP id y207-v6so74563582oie.13
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 06:01:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180716083809.17115-1-david@gibson.dropbear.id.au>
References: <20180716083809.17115-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jul 2018 14:00:38 +0100
Message-ID: <CAFEAcA_BFO9+7n1XRwhLg2Qe823axL7JFNYgC2HWQ+T0c-HgGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] ppc-for-3.0 queue 20180716
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 16 July 2018 at 09:38, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 9277d81f5c2c6f4d0b5e47c8476eb7ee7e5c0beb:
>
>   docs: Grammar and spelling fixes (2018-07-13 10:16:04 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-3.0-20180716
>
> for you to fetch changes up to 6730df0514d3aec35e646ff9833fbe8b05fd0776:
>
>   sm501: Fix warning about unreachable code (2018-07-16 11:19:10 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2018-07-16
>
> Here's my first hard freeze pull request for qemu-3.0.  This contains
> an assortment of bugfixes. Several are for regressions, others are for
> bugs that I think are significant enough to address during hard freeze.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
