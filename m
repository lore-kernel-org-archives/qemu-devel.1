Received: from eggs.gnu.org ([2001:4830:134:3::10]:60692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faRT7-0006k9-MN
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:00:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1faRT6-0000Jm-Of
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:00:09 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:44775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1faRT6-0000JQ-IH
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:00:08 -0400
Received: by mail-oi0-x231.google.com with SMTP id s198-v6so6245123oih.11
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 13:00:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703091847.7057-1-kraxel@redhat.com>
References: <20180703091847.7057-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Jul 2018 20:59:47 +0100
Message-ID: <CAFEAcA_oRgzg4fQ3Tne0V5WoPs3Kg-=ZsA+E0ix7Mdo_VtQhgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Ui 20180703 patches
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

On 3 July 2018 at 10:18, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit ab08440a4ee09032d1a9cb22fdcab23bc7e1c656:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180702' into staging (2018-07-02 17:57:46 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20180703-pull-request
>
> for you to fetch changes up to 4939a1df7d60b4a24458544557ae262852e28567:
>
>   ui: do not build-depend or link with libdrm, it is not needed (2018-07-03 10:30:25 +0200)
>
> ----------------------------------------------------------------
> ui: drop libdrm dependency.
>
> ----------------------------------------------------------------
>
> Michael Tokarev (1):
>   ui: do not build-depend or link with libdrm, it is not needed
>
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
Applied, thanks.

-- PMM
