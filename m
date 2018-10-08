Received: from eggs.gnu.org ([2001:4830:134:3::10]:44500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9Tsl-0001Zl-PL
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 07:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g9Tsj-0002N5-VA
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 07:39:27 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g9Tsj-0002Mz-QV
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 07:39:25 -0400
Received: by mail-ot1-x341.google.com with SMTP id o21so18978854otb.13
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 04:39:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181007180518.5212-1-samuel.thibault@ens-lyon.org>
References: <20181007180518.5212-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Oct 2018 12:39:04 +0100
Message-ID: <CAFEAcA8XSn_+8XorYCKQeiCidcgRDXwp0GH1OU0fJyr++gz1aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Slirp updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

On 7 October 2018 at 19:05, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
> The following changes since commit 3c2d3042849686969add641bd38b08b9877b9e8f:
>
>   Merge remote-tracking branch 'remotes/mcayland/tags/qemu-openbios.for-upstream-20181005' into staging (2018-10-05 17:55:22 +0100)
>
> are available in the Git repository at:
>
>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to 93a972f8548571d35c718ca3a94d5ab1507b2443:
>
>   slirp: Propagate host TCP RST packet to the guest after socket disconnected (2018-10-07 19:50:48 +0200)
>
> ----------------------------------------------------------------
> slirp updates
>
> Andrew Oates (1):
>   slirp: fix ICMP handling on macOS hosts
>
> Gavin Grant (1):
>   slirp: Propagate host TCP RST packet to the guest after socket
>     disconnected
>
> Peter Maydell (1):
>   slirp: document mbuf pointers and sizes
>

Applied, thanks.

-- PMM
