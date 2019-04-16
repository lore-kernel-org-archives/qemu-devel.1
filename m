Received: from eggs.gnu.org ([209.51.188.92]:49701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGKYI-00079I-Nb
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGKYH-0003DE-Qc
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:38:54 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGKYH-0003Ck-JC
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:38:53 -0400
Received: by mail-oi1-x244.google.com with SMTP id j132so16399075oib.2
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 02:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190415180618.1450-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190415180618.1450-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 10:38:38 +0100
Message-ID: <CAFEAcA9z-ELZJ+WunWYwprzMOpC7WPxPiwNjdtFoNxL+LE=jQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] slirp gcc9 build fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

On Mon, 15 Apr 2019 at 19:06, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> The following changes since commit afccfc0c4c6134a7bc9da6375996b3b91d291de4:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-04-12 17:06:49 +0100)
>
> are available in the Git repository at:
>
>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to 6fabae61a9393fd2bc703837e464b9c34ec5ef25:
>
>   slirp: Gcc 9 -O3 fix (2019-04-15 20:01:18 +0200)
>
> ----------------------------------------------------------------
> Slirp updates
>
> Dr. David Alan Gilbert (1):
>   slirp: Gcc 9 -O3 fix
>
> ----------------------------------------------------------------
> Dr. David Alan Gilbert (1):
>       slirp: Gcc 9 -O3 fix
>
>  slirp/src/socket.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
