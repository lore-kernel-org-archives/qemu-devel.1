Received: from eggs.gnu.org ([2001:4830:134:3::10]:54517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftD1R-00083S-PG
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftD1Q-0002wV-W6
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:25:09 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:40031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ftD1Q-0002vB-QO
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:25:08 -0400
Received: by mail-oi0-x243.google.com with SMTP id l202-v6so8698209oig.7
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 07:25:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180822080751.11307-1-quintela@redhat.com>
References: <20180822080751.11307-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 15:24:47 +0100
Message-ID: <CAFEAcA8+3A5mzep9oyuY72J1Zrek-w3mrX38gvumzGgXU8qtUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/19] Be able to disable several devices
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

On 22 August 2018 at 09:07, Juan Quintela <quintela@redhat.com> wrote:
> The following changes since commit 13b7b188501d419a7d63c016e00065bcc693b7d4:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20180821-pull-request' into staging (2018-08-21 15:57:56 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/check/20180822
>
> for you to fetch changes up to 889d52a243fb6f1d19c92dec2c8055a7f4efbe22:
>
>   check: Only test tpm devices when they are compiled in (2018-08-21 19:52:16 +0200)
>
> ----------------------------------------------------------------
> check/next for 20180822
>
> This patch series enable the disable of several devices, and if they
> are disabled, the checks for those devices are also disable.
>
> This are only the parts that have been reviewed.  The rest of them
> will be posted when all comments from reviews have been addressed.
>
> As you can see, this only touches tests/Makefile.include
>
> The changes for pvpanic are to make it the same that other devices.
>
> Please apply, Juan.
>

Applied, thanks.

-- PMM
