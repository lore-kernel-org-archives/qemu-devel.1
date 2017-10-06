Received: from eggs.gnu.org ([2001:4830:134:3::10]:58597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0V33-0005Wn-2w
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 12:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0V32-0000TI-AX
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 12:00:25 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:47687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0V31-0000Sh-TL
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 12:00:24 -0400
Received: by mail-wr0-x22f.google.com with SMTP id y44so8020742wrd.4
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 09:00:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Oct 2017 17:00:01 +0100
Message-ID: <CAFEAcA_Eq6QDgLehz+kYae3bk4uc1HFvUCKq5H79dKN3AoEnUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/33] next batch of s390x patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>

On 6 October 2017 at 10:59, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit d8f932cc696250cb740240d668b39df5fbb2d5a0:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2017-10-05 16:54:29 +0100)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20171006
>
> for you to fetch changes up to b923ab3112ed5ab47c2ff35776f17ab54c60d651:
>
>   hw/s390x: Mark the "sclpquiesce" device with user_creatable = false (2017-10-06 10:53:02 +0200)
>
> ----------------------------------------------------------------
> s390x changes:
> - support for IDA (indirect addressing in ccws) via ccw data stream
> - support for extended TOD-Clock (z14 feature)
> - various fixes and improvements all over the place
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
