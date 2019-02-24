Received: from eggs.gnu.org ([209.51.188.92]:41617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gxwqq-0005Td-3O
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 11:42:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gxwqp-0008ME-Ef
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 11:42:04 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:36873)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gxwqp-0008Lj-8h
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 11:42:03 -0500
Received: by mail-wm1-f42.google.com with SMTP id x10so5896419wmg.2
	for <qemu-devel@nongnu.org>; Sun, 24 Feb 2019 08:42:02 -0800 (PST)
Date: Sun, 24 Feb 2019 11:41:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190224114135-mutt-send-email-mst@kernel.org>
References: <20190221173326.31874-1-mst@redhat.com>
	<CAFEAcA_Nmo1bpWr5rUmXotB_J9J78wvqB9TU174WWyqt+CEZZw@mail.gmail.com>
	<20190222105159-mutt-send-email-mst@kernel.org>
	<20190223193335-mutt-send-email-mst@kernel.org>
	<CAFEAcA87W8VdNSoROcn_wV2UnOQpP7qaLgok6RsbsPLhVvnZ1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA87W8VdNSoROcn_wV2UnOQpP7qaLgok6RsbsPLhVvnZ1w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/26] pci, pc, virtio: fixes, cleanups,
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On Sun, Feb 24, 2019 at 10:21:52AM +0000, Peter Maydell wrote:
> On Sun, 24 Feb 2019 at 00:34, Michael S. Tsirkin <mst@redhat.com> wrote:
> > Peter, can you merge for_upstream now pls? Don't want to spam
> > the list with a trivial change like that ...
> 
> Yes, it's on my list, but so are seven other pullreqs;
> seems like everybody likes to submit on a Friday, so
> sending on a Friday guarantees maximum delay because
> you'll be in a big queue with other people and I don't
> generally handle pullreqs on the weekend either...

OK I'll try to switch over to middle of the week.

> In general I prefer it if you just re-send the cover-letter
> email as a v2 rather than informally asking for a retry: that
> guarantees I'll see it and automatically makes it appear
> in my list of things to process. You don't need to
> resend all the individual patchmails if the change was
> minor.
> 
> thanks
> -- PMM

Good to know.

-- 
MST
