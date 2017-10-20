Received: from eggs.gnu.org ([2001:4830:134:3::10]:44243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5Xu0-0003zH-Az
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 10:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5Xtz-0007xz-GT
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 10:03:56 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:50323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5Xtz-0007xS-8K
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 10:03:55 -0400
Received: by mail-wm0-x22e.google.com with SMTP id u138so22182959wmu.5
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 07:03:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171020115418.2050-1-cohuck@redhat.com>
References: <20171020115418.2050-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Oct 2017 15:03:33 +0100
Message-ID: <CAFEAcA9ewOa2uPgm3iLwq9scg3yHAmu9gm7BY5-hE=bTKT4hLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/46] more s390x patches for 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>

On 20 October 2017 at 12:53, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit e67277f8f32d56c64c7993163f41bb4338aec566:
>
>   Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2017-10-19-1' into staging (2017-10-20 10:49:55 +0100)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20171020
>
> for you to fetch changes up to 2bcf018340cbf233f7145e643fc1bb367f23fd90:
>
>   s390x/tcg: low-address protection support (2017-10-20 13:32:10 +0200)
>
> ----------------------------------------------------------------
> The last big chunk of s390x changes:
> - (experimental) smp support under tcg
> - provide the virtio-input devices for virtio-ccw
> - improve error handling in the css code
> - enable some simple virtio tests for s390x
> - low-address protection in tcg
> - some more cleanups and fixes
>

Applied, thanks.

-- PMM
