Received: from eggs.gnu.org ([2001:4830:134:3::10]:43820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIVsp-0006n6-De
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIVsl-0002ED-FL
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:04:35 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:40514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIVsl-0002Df-AN
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:04:31 -0400
Received: by mail-ot0-x22b.google.com with SMTP id n1-v6so17579588otf.7
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 02:04:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180514180506.17388-1-laurent@vivier.eu>
References: <20180514180506.17388-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 10:04:10 +0100
Message-ID: <CAFEAcA93i7mxfQMU=+z60G_ye6OHkSJeCZVGJ+XWk22YR0qveA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] M68k for 2.13 patches
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

On 14 May 2018 at 19:05, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 7a9180b77eca258ab418ec00ab397392e70e55d9:
>
>   Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2018-05-14 14:15:27 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.13-pull-request
>
> for you to fetch changes up to 5a73e7f313da0e4657bcac61b533ced71b0d0224:
>
>   m68k: fix floatx80_mod() (Coverity CID1390568) (2018-05-14 19:13:07 +0200)
>
> ----------------------------------------------------------------
> Fix coverity CID1390568
> ----------------------------------------------------------------
>
> Laurent Vivier (1):
>   m68k: fix floatx80_mod() (Coverity CID1390568)
>
>  target/m68k/softfloat.c | 1 +
>  1 file changed, 1 insertion(+)
>

Applied, thanks.

-- PMM
