Received: from eggs.gnu.org ([2001:4830:134:3::10]:53982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5aHX-0005Du-Sx
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 12:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5aHX-00085Q-7Z
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 12:36:23 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:52291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5aHX-000857-0s
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 12:36:23 -0400
Received: by mail-wm0-x243.google.com with SMTP id k4so23678702wmc.1
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 09:36:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171020120235.29142-1-stefanha@redhat.com>
References: <20171020120235.29142-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Oct 2017 17:36:01 +0100
Message-ID: <CAFEAcA-dTbWEwCOwCJ9qp=VJ5iAHHnPiJA_Ftmv4xb95u55acg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] Block patches
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

On 20 October 2017 at 13:02, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 063833a6ec2a6747e27c5f9866bb44c7e8de1265:
>
>   Merge remote-tracking branch 'remotes/mcayland/tags/qemu-sparc-signed' into staging (2017-10-19 18:42:51 +0100)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to e947d47da0b16e80d237c510e9d2e80799578c7f:
>
>   oslib-posix: Fix compiler warning and some data types (2017-10-20 11:16:27 +0200)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Stefan Weil (1):
>   oslib-posix: Fix compiler warning and some data types
>
>  util/oslib-posix.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Applied, thanks.

-- PMM
