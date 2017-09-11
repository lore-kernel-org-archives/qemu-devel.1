Received: from eggs.gnu.org ([2001:4830:134:3::10]:54770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drLd8-0005Ih-Ly
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:07:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drLd7-0008B1-S8
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:07:50 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:45575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1drLd7-00089w-Kn
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 06:07:49 -0400
Received: by mail-wm0-x22b.google.com with SMTP id f199so35655567wme.0
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 03:07:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170910161811.21413-1-laurent@vivier.eu>
References: <20170910161811.21413-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2017 11:07:26 +0100
Message-ID: <CAFEAcA8j=ng95gARMTxbOkA2UUF-B=GNw8O0wefAM3bsVgzCoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] M68k for 2.11 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10 September 2017 at 17:18, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit fcea73709b966a7ded9efa7b106ea50c7fe9025c:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-09-08 16:04:42 +0100)
>
> are available in the git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.11-pull-request
>
> for you to fetch changes up to 6fa9ba09dbf4eb8b52bcb47d6820957f1b77ee0b:
>
>   target/m68k: Switch fpu_rom from make_floatx80() to make_floatx80_init() (2017-09-10 18:07:40 +0200)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Kamil Rytarowski (1):
>   target/m68k: Switch fpu_rom from make_floatx80() to
>     make_floatx80_init()
>
>  target/m68k/fpu_helper.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
>
> --

Applied, thanks.

-- PMM
