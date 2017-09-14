Received: from eggs.gnu.org ([2001:4830:134:3::10]:35328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsTUc-0002h9-9X
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsTUb-0001pk-Ct
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:43:42 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:49256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dsTUb-0001pG-5k
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:43:41 -0400
Received: by mail-wr0-x229.google.com with SMTP id u96so212849wrb.6
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 05:43:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170913074140.5160-1-kraxel@redhat.com>
References: <20170913074140.5160-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 13:43:19 +0100
Message-ID: <CAFEAcA9E6LVCTQSpJ8UjfHamkTJ599eK-N2So64Xxz6zvSR0fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] Vga 20170913 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 13 September 2017 at 08:41, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 223cd0e13f2e46078d7b573f0b8402bfbee339be:
>
>   Merge remote-tracking branch 'remotes/elmarco/tags/tidy-pull-request' into staging (2017-08-31 15:52:43 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20170913-pull-request
>
> for you to fetch changes up to 79d16c21a565927943486b26789caa62413ff371:
>
>   virtio-gpu: don't clear QemuUIInfo information on reset (2017-09-13 09:39:32 +0200)
>
> ----------------------------------------------------------------
> vga: bugfixes.
> qxl: chunked cursor support.
>

Applied, thanks.

-- PMM
