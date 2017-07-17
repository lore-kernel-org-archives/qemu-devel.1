Received: from eggs.gnu.org ([2001:4830:134:3::10]:43570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX9ze-0005Wg-NJ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX9zd-0003t3-TB
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:39:38 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:35223)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dX9zd-0003sV-Ms
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:39:37 -0400
Received: by mail-wm0-x236.google.com with SMTP id w126so83076173wme.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 10:39:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717094011.15905-1-kraxel@redhat.com>
References: <20170717094011.15905-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 18:39:15 +0100
Message-ID: <CAFEAcA-7qJV1kxT5DYHoG6Psgpz5NSWmSNu0FE5ZE=9nKJwSrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Usb 20170717 patches
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

On 17 July 2017 at 10:40, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 6e2c46334385c7e295ac883c801c81b4925fb54f:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170711' into staging (2017-07-13 10:47:10 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20170717-pull-request
>
> for you to fetch changes up to 2a7f2630684ee556a394a354d64159a4470c0151:
>
>   ehci: add sanity check for maxframes (2017-07-17 11:39:08 +0200)
>
> ----------------------------------------------------------------
> ehci fix for 2.10
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (1):
>   ehci: add sanity check for maxframes
>
>  hw/usb/hcd-ehci.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied, thanks.

-- PMM
