Received: from eggs.gnu.org ([2001:4830:134:3::10]:42867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsXTU-0004zl-4E
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsXTT-0005nw-8k
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:58:48 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:44244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dsXTT-0005nU-1k
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 12:58:47 -0400
Received: by mail-wm0-x229.google.com with SMTP id 189so6782430wmh.1
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 09:58:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170914150447.19352-1-dgilbert@redhat.com>
References: <20170914150447.19352-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 17:58:25 +0100
Message-ID: <CAFEAcA_eBenr0axM-X2oMxJiH2Pt-DCZByBPOcPKdwmkgFqsrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, vadim.galitsyn@profitbricks.com, Igor Mammedov <imammedo@redhat.com>, Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, Peter Xu <peterx@redhat.com>

On 14 September 2017 at 16:04, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 9d81b2d2000f41be55a0624a26873f993fb6e928:
>
>   sparc: Fix typedef clash (2017-09-14 15:00:41 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-hmp-20170914
>
> for you to fetch changes up to d0f63c1e291a0c27cafc0e6faec5a84130b012e0:
>
>   hmp: introduce 'info memory_size_summary' command (2017-09-14 15:52:10 +0100)
>
> ----------------------------------------------------------------
> HMP pull 2017-09-14
>
> ----------------------------------------------------------------
> Cornelia Huck (1):
>       dump: do not dump non-existent guest memory
>
> Laurent Vivier (3):
>       hmp: fix "dump-quest-memory" segfault (ppc)
>       hmp: fix "dump-quest-memory" segfault (arm)
>       tests/hmp: test "none" machine with memory
>
> Vadim Galitsyn (3):
>       hmp: extend "info numa" with hotplugged memory information
>       qmp: introduce query-memory-size-summary command
>       hmp: introduce 'info memory_size_summary' command

Applied, thanks.

-- PMM
