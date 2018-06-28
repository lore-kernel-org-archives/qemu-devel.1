Received: from eggs.gnu.org ([2001:4830:134:3::10]:55460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYWxA-0006Gg-Fe
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYWx9-0006sA-G0
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:27:16 -0400
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:41071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYWx9-0006rw-Ai
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:27:15 -0400
Received: by mail-ot0-x22a.google.com with SMTP id d19-v6so6105091oti.8
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 06:27:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627125847.5413-1-stefanha@redhat.com>
References: <20180627125847.5413-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 14:26:54 +0100
Message-ID: <CAFEAcA8zG-GdAqxXVPgLFCOjgA2ECcfdm6vF_tqtKovDa4cTtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 27 June 2018 at 13:58, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 00928a421d47f49691cace1207481b7aad31b1f1:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180626' into staging (2018-06-26 18:23:49 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to ec09f877532210e28e1d4b6b12896d3eb6d8e8d1:
>
>   trace: forbid floating point types (2018-06-27 11:09:29 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
>  * Trace TCG atomic memory accesses
>  * Document that trace event arguments cannot be floating point
>
Applied, thanks.

-- PMM
