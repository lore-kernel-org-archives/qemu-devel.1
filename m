Received: from eggs.gnu.org ([209.51.188.92]:38633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxqv7-0001L9-Uh
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 05:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxqv7-00027H-7v
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 05:22:05 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:42848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gxqv7-00025Q-1N
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 05:22:05 -0500
Received: by mail-ot1-x32d.google.com with SMTP id i5so5473906oto.9
	for <qemu-devel@nongnu.org>; Sun, 24 Feb 2019 02:22:04 -0800 (PST)
MIME-Version: 1.0
References: <20190221173326.31874-1-mst@redhat.com>
	<CAFEAcA_Nmo1bpWr5rUmXotB_J9J78wvqB9TU174WWyqt+CEZZw@mail.gmail.com>
	<20190222105159-mutt-send-email-mst@kernel.org>
	<20190223193335-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190223193335-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 24 Feb 2019 10:21:52 +0000
Message-ID: <CAFEAcA87W8VdNSoROcn_wV2UnOQpP7qaLgok6RsbsPLhVvnZ1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On Sun, 24 Feb 2019 at 00:34, Michael S. Tsirkin <mst@redhat.com> wrote:
> Peter, can you merge for_upstream now pls? Don't want to spam
> the list with a trivial change like that ...

Yes, it's on my list, but so are seven other pullreqs;
seems like everybody likes to submit on a Friday, so
sending on a Friday guarantees maximum delay because
you'll be in a big queue with other people and I don't
generally handle pullreqs on the weekend either...

In general I prefer it if you just re-send the cover-letter
email as a v2 rather than informally asking for a retry: that
guarantees I'll see it and automatically makes it appear
in my list of things to process. You don't need to
resend all the individual patchmails if the change was
minor.

thanks
-- PMM
