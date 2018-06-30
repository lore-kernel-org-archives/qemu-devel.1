Received: from eggs.gnu.org ([2001:4830:134:3::10]:39518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZGUy-0000lw-Uh
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 10:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZGUy-0003Fr-9W
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 10:05:12 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:44419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fZGUy-0003EZ-4I
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 10:05:12 -0400
Received: by mail-ot0-x22b.google.com with SMTP id w13-v6so12887206ote.11
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 07:05:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629175330.19391-1-stefanha@redhat.com>
References: <20180629175330.19391-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 30 Jun 2018 15:04:50 +0100
Message-ID: <CAFEAcA96fEdTQrRvFoa6TZns4dZyOLXiHaNAo4SCQ2ZHvTqR+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/11] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Richard Henderson <rth@twiddle.net>

On 29 June 2018 at 18:53, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 609ef9f451759151d0bfe7c3843410ab94d68f18:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/qio-next-pull-request' into staging (2018-06-28 17:53:31 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to 13019f1fd6c683b243120b7eb999f1b50a224940:
>
>   hw/block/pflash_cfi: Convert from DPRINTF() macro to trace events (2018-06-29 15:04:18 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
>  * Python 3 support in simpletrace.py
>  * Convert DPRINTF() to trace events

Applied, thanks.

-- PMM
