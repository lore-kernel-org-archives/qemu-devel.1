Received: from eggs.gnu.org ([2001:4830:134:3::10]:44957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSlRq-0003G9-Me
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSlRp-0003LP-Sb
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:43:06 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:44621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fSlRp-0003L3-Oj
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:43:05 -0400
Received: by mail-ot0-x22d.google.com with SMTP id w13-v6so28579817ote.11
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 08:43:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180612104430.25745-1-kraxel@redhat.com>
References: <20180612104430.25745-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Jun 2018 16:42:39 +0100
Message-ID: <CAFEAcA9SWjaB-CxwJTH=jtkw6dYdWNhhW40v+fnz+9vZXzKF8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] Usb 20180612 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, qemu-arm <qemu-arm@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Zhang Chen <zhangckid@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Corey Minyard <minyard@acm.org>

On 12 June 2018 at 11:44, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 2afc4e3df80d947dd1bd42ce80278f591b35c74a:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2018-06-11' into staging (2018-06-11 15:31:20 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20180612-pull-request
>
> for you to fetch changes up to 3c969a6022438cf59de10d2dc3c58f4807788f98:
>
>   usb-mtp: Return error on suspicious TYPE_DATA packet from initiator (2018-06-12 12:08:12 +0200)
>
> ----------------------------------------------------------------
> usb: bug fix collection, doc update.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
