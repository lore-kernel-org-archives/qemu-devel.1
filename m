Received: from eggs.gnu.org ([2001:4830:134:3::10]:33846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvOpO-0000bg-BD
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvOpK-00065I-FT
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:21:14 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:45995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dvOpK-00064Z-8i
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 10:21:10 -0400
Received: by mail-wm0-x232.google.com with SMTP id q124so4391832wmb.0
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 07:21:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170922122505.9413-1-quintela@redhat.com>
References: <20170922122505.9413-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 15:20:48 +0100
Message-ID: <CAFEAcA9d+3ErHep8WWx1eD648W1uMq6fFYZZnBzGaF9=gbKrsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/18] Migration PULL request (3rd try)
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

On 22 September 2017 at 13:24, Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> From yesterday pull:
> - s/__WORD_SIZE/HOST_LONG_BITS/
> - rebase on top of today
>
> [2nd try]
>
> To make merges easier, this includes:
> - Peter Xu reviewed patches from Postocpy recovery (3)
> - Alexey reviewed pages from block postcopy (4)
> - Vladimir reviewed patches (3)
> - reviewed patches from Multifd (me)
>
> Please apply, Juan.
>
>
> The following changes since commit a664607440511fdf8cff9d1c2afefbdbca1d1295:
>
>   Merge remote-tracking branch 'remotes/famz/tags/build-and-test-automation-pull-request' into staging (2017-09-22 12:14:28 +0100)
>
> are available in the git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20170922-1
>
> for you to fetch changes up to 54ae0886b12c4934e84381af777d4df6147cc2ec:
>
>   migration: split ufd_version_check onto receive/request features part (2017-09-22 14:11:29 +0200)
>
> ----------------------------------------------------------------
> migration/next for 20170922

Applied, thanks.

-- PMM
