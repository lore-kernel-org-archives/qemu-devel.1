Received: from eggs.gnu.org ([2001:4830:134:3::10]:49702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSgyX-0002MH-4x
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:56:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSgyW-0006AA-G6
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:56:33 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:41664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fSgyW-00069u-AK
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:56:32 -0400
Received: by mail-ot0-x243.google.com with SMTP id d19-v6so21954751oti.8
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 03:56:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180611173452.28087-1-ehabkost@redhat.com>
References: <20180611173452.28087-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Jun 2018 11:56:11 +0100
Message-ID: <CAFEAcA83ZYsZB-yaaUFzddmG7ZKqV5oAq-6rnBobcMp9C-ddkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Machine queue, 2018-06-11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

On 11 June 2018 at 18:34, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit 9f55925b8f50a962d1d08d815044db7767ae3838:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-3.0-pull-request' into staging (2018-06-11 12:46:16 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 0f5319ea25fb0a05827d512859b7c7d23371ac5d:
>
>   cli: Don't run early event loop if no --preconfig was specified (2018-06-11 14:25:49 -0300)
>
> ----------------------------------------------------------------
> Machine queue, 2018-06-11
>
> * Fix -daemonize hang caused by --preconfig code
>
> ----------------------------------------------------------------
>
> Queue for Machine Core patches
>
>
> Igor Mammedov (1):
>   cli: Don't run early event loop if no --preconfig was specified
>
>  vl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --

Applied, thanks.

-- PMM
