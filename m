Received: from eggs.gnu.org ([2001:4830:134:3::10]:45149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dN0aU-0004Gz-Rp
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 13:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dN0aU-00013o-0C
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 13:35:42 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:34228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dN0aT-00012V-PO
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 13:35:41 -0400
Received: by mail-wm0-x22d.google.com with SMTP id d64so19526378wmf.1
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 10:35:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170614075111.24886-1-kraxel@redhat.com>
References: <20170614075111.24886-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2017 18:35:20 +0100
Message-ID: <CAFEAcA8xCWRmUXb4c+XE7BYQ8NJM4aXmfqHdfz+Vi+gNQjavgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] usb: bugfixes for ehci and xhci
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

On 14 June 2017 at 08:51, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Here is the usb patch queue with two bugfixes.
>
> please pull,
>   Gerd
>
> The following changes since commit 475df9d809b1f3a7ebe8b15abd208216591f0143:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-06-12 10:43:32 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/pull-usb-20170614-1
>
> for you to fetch changes up to ad3c5412f2704672bb212bb82035c9b1a72db782:
>
>   ehci: stop recursive calls to ehci_work_bh (2017-06-13 12:17:33 +0200)
>
> ----------------------------------------------------------------
> usb: bugfixes for ehci and xhci
>
> ----------------------------------------------------------------
> Gerd Hoffmann (2):
>       xhci: only update dequeue ptr on completed transfers
>       ehci: stop recursive calls to ehci_work_bh

Applied, thanks.

-- PMM
