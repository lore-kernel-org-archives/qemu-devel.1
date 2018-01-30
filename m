Received: from eggs.gnu.org ([2001:4830:134:3::10]:38133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egTUx-0005jk-O3
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egTUs-00032e-8q
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:50:43 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:46397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1egTUs-00032R-15
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 05:50:38 -0500
Received: by mail-ot0-x232.google.com with SMTP id t35so9510465otd.13
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 02:50:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180129160740.1195-1-stefanha@redhat.com>
References: <20180129160740.1195-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jan 2018 10:50:16 +0000
Message-ID: <CAFEAcA9Pu-RLS-LJ20d6ZJTN1z=bUmV-Y8fM9KE3tHYfVe4L=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 29 January 2018 at 16:07, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 6233b4a8c2a32ef6955a921246fa08705bbb3676:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-01-26' into staging (2018-01-26 17:29:14 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to 24f4d3d3aeabf83445839099d6d66cbb3089c37a:
>
>   tracetool: report error on foo() instead of foo(void) (2018-01-29 10:34:55 +0000)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Stefan Hajnoczi (3):
>   tracetool: prefix parse errors with line numbers
>   tracetool: clarify that "formats" means "format strings"
>   tracetool: report error on foo() instead of foo(void)
>
>  scripts/tracetool/__init__.py | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)

Applied, thanks.

-- PMM
