Received: from eggs.gnu.org ([2001:4830:134:3::10]:34129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUxC8-0005Em-4y
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:35:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUxC4-0007Al-7O
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:35:24 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:35111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUxC4-0007AM-1A
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:35:20 -0400
Received: by mail-wr0-f182.google.com with SMTP id k67so4026299wrc.2
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 08:35:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170710190904.32728.74078.stgit@gimli.home>
References: <20170710190904.32728.74078.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 16:33:58 +0100
Message-ID: <CAFEAcA_hCTOSexttqOm52jj5U1eX_uWX4DOZ-w=Lpejge0V0Ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] VFIO fixes 2017-07-10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10 July 2017 at 20:10, Alex Williamson <alex.williamson@redhat.com> wrote:
> The following changes since commit 6b06e3e49eb8c91cc286c16d6bf3181ac296f33d:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2017-07-10-v2'
> into staging (2017-07-10 16:12:47 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-updates-20170710.0
>
> for you to fetch changes up to 47985727e383eee191a39cc007541c17cd8680ee:
>
>   vfio/pci: Fixup v0 PCIe capabilities (2017-07-10 10:39:43 -0600)
>
> ----------------------------------------------------------------
> VFIO fixes 2017-07-10
>
>  - Don't iterate over non-realized devices (Alex Williamson)
>  - Add PCIe capability version fixup (Alex Williamson)
>
Applied, thanks.

-- PMM
