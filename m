Received: from eggs.gnu.org ([2001:4830:134:3::10]:60693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQDcN-0006Mo-Ou
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQDcM-0000xA-LD
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:11:27 -0400
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:36274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQDcM-0000ww-GX
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 11:11:26 -0400
Received: by mail-oi0-x22d.google.com with SMTP id 14-v6so2405628oie.3
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 08:11:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180605141933.30169-1-jcody@redhat.com>
References: <20180605141933.30169-1-jcody@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Jun 2018 16:11:00 +0100
Message-ID: <CAFEAcA9UwDDtSc5f_8f4CL+Nqgwz=L7skhv1gj5yRY-tBFUrsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 5 June 2018 at 15:19, Jeff Cody <jcody@redhat.com> wrote:
> The following changes since commit 41feb5b955f0d7c9d071b2c5adbc404ae2895c7a:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.0-pull-request' into staging (2018-06-05 10:38:33 +0100)
>
> are available in the git repository at:
>
>   git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request
>
> for you to fetch changes up to 68acc99f143b60ec4faa2903065b187d4d3c4bf3:
>
>   sheepdog: remove huge BSS object (2018-06-05 10:15:12 -0400)
>
> ----------------------------------------------------------------
> Sheepdog patches
> ----------------------------------------------------------------
>
> Paolo Bonzini (2):
>   sheepdog: cleanup repeated expression
>   sheepdog: remove huge BSS object
>
>  block/sheepdog.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)

Applied, thanks.

-- PMM
