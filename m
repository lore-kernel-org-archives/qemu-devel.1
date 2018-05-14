Received: from eggs.gnu.org ([2001:4830:134:3::10]:40512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIIN3-0007iu-12
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:38:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIIN2-0004XY-5r
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:38:53 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:43906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIIN2-0004Wh-0l
	for qemu-devel@nongnu.org; Mon, 14 May 2018 14:38:52 -0400
Received: by mail-oi0-x236.google.com with SMTP id p62-v6so11613518oie.10
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 11:38:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180514154114.2558-1-cohuck@redhat.com>
References: <20180514154114.2558-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 19:38:30 +0100
Message-ID: <CAFEAcA_OVeDZMGgth1YZvse+ZwdRj1=i+Q5swtg-gZcdHvV2zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] s390x fixes/cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 14 May 2018 at 16:41, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit bbd87423ea0c436c55bbc3f9c23d4f811d1f3f29:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2018-05-14 11:08:16 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20180514
>
> for you to fetch changes up to b0dad618baad1efb014c88f4507492a79f2eaf1c:
>
>   target/s390x: Fix brace Werror with clang 6.0.0 (2018-05-14 17:10:02 +0200)
>
> ----------------------------------------------------------------
> Some s390x fixes/cleanups, mainly in the reset area and build fixes
> for recent compilers (GCC 8 and clang 6.0.0).
>
> ----------------------------------------------------------------
>

Applied, thanks.

-- PMM
