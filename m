Received: from eggs.gnu.org ([2001:4830:134:3::10]:43929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYxCz-00016x-7q
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYxCy-0006zg-7q
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:29:21 -0400
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:39497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYxCx-0006wY-Pc
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:29:20 -0400
Received: by mail-ot0-x234.google.com with SMTP id l15-v6so10731596oth.6
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 10:29:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629132045.429006-1-groug@kaod.org>
References: <20180629132045.429006-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 18:28:58 +0100
Message-ID: <CAFEAcA9Yw=_MvudjTkgqdD-54b1dwWhAo2JAndv4zwmVbvH=rQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] 9p patches 2018-06-29
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 29 June 2018 at 14:20, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit 609ef9f451759151d0bfe7c3843410ab94d68f18:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/qio-next-pull-request' into staging (2018-06-28 17:53:31 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to 230f1b31c5d58a852e1ac46e1ef05cfa7d5d9280:
>
>   9p: darwin: Explicitly cast comparisons of mode_t with -1 (2018-06-29 12:32:10 +0200)
>
> ----------------------------------------------------------------
> The Darwin host support still needs some more work. It won't make it for
> soft-freeze, but I'd like these preparatory patches to be merged anyway.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
