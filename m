Received: from eggs.gnu.org ([2001:4830:134:3::10]:38268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euFO0-0007iO-CI
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:36:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1euFNz-0004yt-86
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:36:28 -0500
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:34648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1euFNz-0004yZ-2b
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:36:27 -0500
Received: by mail-oi0-x231.google.com with SMTP id c83so6655614oib.1
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 02:36:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180308180423.941-1-cohuck@redhat.com>
References: <20180308180423.941-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Mar 2018 10:36:05 +0000
Message-ID: <CAFEAcA9J2TuzhLFyuQ7gL7fpE3Cq-nN4pUfXry0S9RcJO4DF=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/11] s390x patches for the 2.12 softfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>

On 8 March 2018 at 18:04, Cornelia Huck <cohuck@redhat.com> wrote:
> Note that this currently does not work on s390x/tcg (needs "memory: fix
> flatview_access_valid RCU read lock/unlock imbalance", which hopefully
> should be submitted soon) -- s390x/kvm is fine.
>
> The following changes since commit 83d2e94cba776c02c761a5d14b5c2504796a8c0a:
>
>   Merge remote-tracking branch 'remotes/mcayland/tags/qemu-sparc-signed' into staging (2018-03-08 13:42:26 +0000)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20180308
>
> for you to fetch changes up to 24118af846868bb22e573be206c63e684ba9846a:
>
>   s390x/virtio: Convert virtio-ccw from *_exit to *_unrealize (2018-03-08 17:22:20 +0100)
>
> ----------------------------------------------------------------
> Fixes and cleanups for the 2.12 softfreeze.
>
> ----------------------------------------------------------------
>

Applied, thanks.

-- PMM
