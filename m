Received: from eggs.gnu.org ([2001:4830:134:3::10]:47850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhcSC-0005eU-FN
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhcSB-0002xj-LU
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:04:20 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:34364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dhcSB-0002xG-EW
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 10:04:19 -0400
Received: by mail-wr0-x230.google.com with SMTP id y96so68058wrc.1
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 07:04:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170815132746.12540-1-stefanha@redhat.com>
References: <20170815132746.12540-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Aug 2017 15:03:57 +0100
Message-ID: <CAFEAcA_cAg=J4MfiKOfnerBDm0KCJ02yovc5UnW1aQZVQo2Evg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Tracing patches
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

On 15 August 2017 at 14:27, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 5681da292242550f37ba4c03f46a8a6f8ee9278a:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20170815' into staging (2017-08-15 09:39:14 +0100)
>
> are available in the git repository at:
>
>   git://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to 840d8351774664d01c328d31ed33b0e2d85c866e:
>
>   simpletrace: fix flight recorder --no-header option (2017-08-15 12:50:29 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Stefan Hajnoczi (2):
>   trace: use static event ID mapping in simpletrace.stp
>   simpletrace: fix flight recorder --no-header option
>
>  scripts/simpletrace.py                       | 24 +++++++++++++++------
>  scripts/tracetool/format/simpletrace_stap.py | 31 ++--------------------------
>  2 files changed, 20 insertions(+), 35 deletions(-)

Applied, thanks.

-- PMM
