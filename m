Received: from eggs.gnu.org ([209.51.188.92]:54847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMXiB-0001Ov-HG
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMXiA-0002rP-Gp
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:54:47 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:35309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMXiA-0002r8-AD
	for qemu-devel@nongnu.org; Fri, 03 May 2019 08:54:46 -0400
Received: by mail-oi1-x231.google.com with SMTP id w197so4342466oia.2
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 05:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190502223007.29494-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190502223007.29494-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 13:54:34 +0100
Message-ID: <CAFEAcA-eVOZhXj+OLB+VvxXZTniny_sMCFaeWsv+2uEErM-=zA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] slirp: move slirp as git submodule
 project
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

On Thu, 2 May 2019 at 23:30, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> The following changes since commit 8482ff2eb3bb95020eb2f370a9b3ea26511e41=
df:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request'=
 into staging (2019-05-02 12:04:51 +0100)
>
> are available in the Git repository at:
>
>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to 7c57bdd82026ba03f3158bbcd841afde7c2dc43a:
>
>   build-sys: move slirp as git submodule project (2019-05-03 00:15:37 +02=
00)
>
> ----------------------------------------------------------------
> slirp: move slirp as git submodule project
>
> Marc-Andr=C3=A9 Lureau (2):
>   build-sys: pass CFLAGS & LDFLAGS to subdir-slirp
>   build-sys: move slirp as git submodule project
>
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (2):
>       build-sys: pass CFLAGS & LDFLAGS to subdir-slirp
>       build-sys: move slirp as git submodule project
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM
