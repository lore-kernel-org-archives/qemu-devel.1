Received: from eggs.gnu.org ([2001:4830:134:3::10]:46789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csv3s-0005Et-5t
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 13:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csv3r-00023C-Ep
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 13:37:40 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1csv3r-000232-98
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 13:37:39 -0400
Received: by mail-wm0-x231.google.com with SMTP id t189so4928685wmt.1
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 10:37:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170328142346.3899-1-stefanha@redhat.com>
References: <20170328142346.3899-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Mar 2017 18:37:17 +0100
Message-ID: <CAFEAcA9wpDD27axZMoK+Ptr5jxyBZKFe7M_G7jtKUxBzyHE0vA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for-2.9 0/1] Tracing patches
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

On 28 March 2017 at 15:23, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit eb06c9e2d3c8f026a206e8402b0ffa201060ec8e:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-03-27 17:34:50 +0100)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to 7609ffb9191e3fc473203f4bd58b934161eab358:
>
>   trace: fix tcg tracing build breakage (2017-03-28 11:07:46 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Stefan Hajnoczi (1):
>   trace: fix tcg tracing build breakage
>
>  docs/tracing.txt                         |  3 +++
>  trace/Makefile.objs                      | 16 ++++++++--------
>  scripts/tracetool/format/tcg_h.py        |  1 +
>  scripts/tracetool/format/tcg_helper_c.py |  1 +
>  4 files changed, 13 insertions(+), 8 deletions(-)

Applied, thanks.

-- PMM
