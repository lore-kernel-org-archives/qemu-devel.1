Received: from eggs.gnu.org ([209.51.188.92]:46831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <davidkiarie4@gmail.com>) id 1h1AsN-0000Z3-3M
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 09:17:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <davidkiarie4@gmail.com>) id 1h1AsM-0007ov-0R
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 09:16:59 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:33662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <davidkiarie4@gmail.com>)
	id 1h1AsL-0007nJ-MY
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 09:16:57 -0500
Received: by mail-oi1-x22e.google.com with SMTP id z14so6930479oid.0
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 06:16:57 -0800 (PST)
MIME-Version: 1.0
References: <20190304151827.1813-1-davidkiarie4@gmail.com>
	<82c88a70-13e1-d4e9-4faf-420a56fbba92@redhat.com>
In-Reply-To: <82c88a70-13e1-d4e9-4faf-420a56fbba92@redhat.com>
From: David Kiarie <davidkiarie4@gmail.com>
Date: Tue, 5 Mar 2019 17:16:07 +0300
Message-ID: <CABdVeAD5RseQ4WKapozTjUfUarAikpngiX-yb+CGnD3AmuqdLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4? 0/1] update copyright notice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, Mar 4, 2019 at 11:52 PM Eric Blake <eblake@redhat.com> wrote:

> On 3/4/19 9:18 AM, David Kiarie wrote:
> > i think it is best put as i've updated.
> >
> > David Kiarie (1):
> >    update copyright notice
> >
> >   hw/i386/amd_iommu.c | 2 +-
> >   hw/i386/amd_iommu.h | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
>
> You have now posted two separate threads with identical subjects but
> with different contents. As a courtesy to your reviewers, and to help
> the maintainers know for sure which version you want incorporated, it
> would have been nicer if you had used 'git send-email -v4' for this
> series, to differentiate it from v3 (if I counted right) sent at
> https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg06457.html, as
> well as summarizing how this version differs from the previous.
>
> That said, I do not think you need to send a v5 just to fix the subject
> line in the cover letter (as the cover letter doesn't end up in git
> anyways), especially since Paolo has already said he will queue your
> patch, and I trust Paolo to get the right version included.
>

i am not okay with maintainer behaviour, this is just something personal.

i will definitely send v4 but this series will include a patch stripping
all AMD IOMMU code from for Paolo to choose what to merge.


> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
