Received: from eggs.gnu.org ([2001:4830:134:3::10]:56764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLTOt-00062L-Th
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 07:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLTOt-0003FD-5I
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 07:57:23 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:33476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dLTOs-0003F0-UC
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 07:57:23 -0400
Received: by mail-wr0-x22f.google.com with SMTP id r103so18797529wrb.0
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 04:57:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170614115138.19571-1-quintela@redhat.com>
References: <20170614115138.19571-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Jun 2017 12:56:58 +0100
Message-ID: <CAFEAcA_Z1-ywrxmYygouzmoozMz19Axw0zhsGm3pSfMWH4VtgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Migration PULL request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On 14 June 2017 at 12:51, Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> In this pull requset:
> - I included the v1 of peter return path, fix it
> - fix the compliation with older compilers (new compliers don't
>    complain about a repeated typedef, so I didn't noticed)
> - Add test for disabled features
> - Last bit of misc cleanup, remove of not needed includes
>
> Please, apply.
>
> Thanks, Juan.
>
> The following changes since commit 3f0602927b120a480b35dcf58cf6f95435b3ae91:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170613' into staging (2017-06-13 15:49:07 +0100)
>
> are available in the git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20170614
>
> for you to fetch changes up to 3416ab5bb452f1b6cea58aed8983ffb9a455b7c4:
>
>   migration: Don't create decompression threads if not enabled (2017-06-14 11:11:06 +0200)
>
> ----------------------------------------------------------------
> migration/next for 20170614
>

Applied, thanks.

-- PMM
