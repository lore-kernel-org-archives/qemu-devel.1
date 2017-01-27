Received: from eggs.gnu.org ([2001:4830:134:3::10]:38143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX55l-0006Yk-Ll
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 06:53:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX55k-0003Tq-U4
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 06:53:21 -0500
Received: from mail-vk0-x22a.google.com ([2607:f8b0:400c:c05::22a]:35483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cX55k-0003Te-Q9
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 06:53:20 -0500
Received: by mail-vk0-x22a.google.com with SMTP id x75so173659097vke.2
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 03:53:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170126024815.22841-1-famz@redhat.com>
References: <20170126024815.22841-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 11:52:59 +0000
Message-ID: <CAFEAcA-NuU+LE9QyFztGKkghh_qXm4deOXz3J1+tzT=rvJh59Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] HBitmap patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 26 January 2017 at 02:48, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit c7f1cf01b8245762ca5864e835d84f6677ae8b1f:
>
>   Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2017-01-25 17:54:14 +0000)
>
> are available in the git repository at:
>
>   git://github.com/famz/qemu.git tags/for-upstream
>
> for you to fetch changes up to 7cdc49b9a2ee127b2403f6ce98ce3f96afb41733:
>
>   test-hbitmap: Add hbitmap_is_serializable() calls (2017-01-26 10:25:01 +0800)
>
> ----------------------------------------------------------------
>
> Two patches by Max submitted back in 2.8 timeframe.
>
> ----------------------------------------------------------------
>
> Max Reitz (2):
>   hbitmap: Add hbitmap_is_serializable()
>   test-hbitmap: Add hbitmap_is_serializable() calls
>
>  include/qemu/hbitmap.h | 13 +++++++++++++
>  tests/test-hbitmap.c   | 11 +++++++++++
>  util/hbitmap.c         | 22 +++++++++++++++++++---
>  3 files changed, 43 insertions(+), 3 deletions(-)
>
> -


Applied, thanks.

-- PMM
