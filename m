Received: from eggs.gnu.org ([2001:4830:134:3::10]:34133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1b8H-0004O8-CN
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 12:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1b8G-0004xP-Dc
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 12:10:05 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:35236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d1b8G-0004xJ-6j
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 12:10:04 -0400
Received: by mail-wr0-x22e.google.com with SMTP id z52so16194007wrc.2
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 09:10:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170421115646.15544-1-quintela@redhat.com>
References: <20170421115646.15544-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Apr 2017 17:09:42 +0100
Message-ID: <CAFEAcA_mEhJyT12Sb1uS4MW+p=VyJcB5yhsW3qv8bpp4spKC1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/65] Migration pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 21 April 2017 at 12:55, Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> This pull includes:
>
> - fixes from (peter xu)
> - page-size parameter for info migrate (chao)
> - Fix for virtio-rng migration with postcopy (laurent)
> - RAMState series cleanup (me)
>
> Please apply.
>
>
> The following changes since commit fa54abb8c298f892639ffc4bc2f61448ac3be4a1:
>
>   Drop QEMU_GNUC_PREREQ() checks for gcc older than 4.1 (2017-04-20 18:33:33 +0100)
>
> are available in the git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20170421
>
> for you to fetch changes up to 2c02468c9b1750aaa5fbeee49cdb55f101608c6a:
>
>   hmp: info migrate_parameters format tunes (2017-04-21 12:25:41 +0200)
>
> ----------------------------------------------------------------
> migration/next for 20170421
>

Applied, thanks.

-- PMM
