Received: from eggs.gnu.org ([209.51.188.92]:45171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyK35-0005l5-US
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 12:28:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyK35-0002Y1-9e
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 12:28:15 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:44604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gyK35-0002N3-3K
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 12:28:15 -0500
Received: by mail-ot1-x32d.google.com with SMTP id g1so8501149otj.11
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 09:27:56 -0800 (PST)
MIME-Version: 1.0
References: <20190221173326.31874-1-mst@redhat.com>
	<CAFEAcA_Nmo1bpWr5rUmXotB_J9J78wvqB9TU174WWyqt+CEZZw@mail.gmail.com>
	<20190222105159-mutt-send-email-mst@kernel.org>
	<20190223193335-mutt-send-email-mst@kernel.org>
	<CAFEAcA87W8VdNSoROcn_wV2UnOQpP7qaLgok6RsbsPLhVvnZ1w@mail.gmail.com>
	<20190224114135-mutt-send-email-mst@kernel.org>
	<6079ace1-7e96-7f30-9f45-6e79c8137fb9@redhat.com>
In-Reply-To: <6079ace1-7e96-7f30-9f45-6e79c8137fb9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Feb 2019 17:27:45 +0000
Message-ID: <CAFEAcA92i+JyxtDoa8ir5N5S_-9o8nYUB4=N4tmSSjCdD79i5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 25 Feb 2019 at 16:23, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 2/24/19 5:41 PM, Michael S. Tsirkin wrote:
> > On Sun, Feb 24, 2019 at 10:21:52AM +0000, Peter Maydell wrote:
> >> In general I prefer it if you just re-send the cover-letter
> >> email as a v2 rather than informally asking for a retry: that
> >> guarantees I'll see it and automatically makes it appear
> >> in my list of things to process. You don't need to
> >> resend all the individual patchmails if the change was
> >> minor.
>
> I appreciate what some maintainers do (such Paolo/Richard):
> sending the cover + the patches changed, because we can review the
> updated patch on the list and tag/remove the patch from the mail queue,
> rather than after it was merged via the git tree (if smth was wrong, it
> is too late).

Yes, I meant more "you don't need to resend everything";
sending the 1 changed patch is usually a good idea.

thanks
-- PMM
