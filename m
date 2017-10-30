Received: from eggs.gnu.org ([2001:4830:134:3::10]:33162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e96g6-0004Cu-Pq
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 05:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e96g5-00071M-Rf
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 05:48:18 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:47511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e96g5-000713-KX
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 05:48:17 -0400
Received: by mail-wr0-x22b.google.com with SMTP id y39so11878504wrd.4
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 02:48:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171027011849.29195-1-mdroth@linux.vnet.ibm.com>
References: <20171027011849.29195-1-mdroth@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Oct 2017 09:47:55 +0000
Message-ID: <CAFEAcA--O6ArHkLN21u7AgaHoQ+wB5kwDxcRmSOan4YVkLMLOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] qemu-ga patch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 27 October 2017 at 02:18, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> The following changes since commit ae49fbbcd8e4e9d8bf7131add34773f579e1aff7:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20171025' into staging (2017-10-25 16:38:57 +0100)
>
> are available in the git repository at:
>
>   git://github.com/mdroth/qemu.git tags/qga-pull-2017-10-26-tag
>
> for you to fetch changes up to 8cedc80555e5a395a4fda7130b0115015e775c48:
>
>   qga-win: fix error-handling in getNameByStringSID() (2017-10-26 20:01:32 -0500)
>
> ----------------------------------------------------------------
> qemu-ga patch queue for 2.11
>
> * support for network interface stats
> * w32: improvements for guest-set-time
> * w32: fix a hang with guest-fsfreeze-freeze when timeout occurs
>   during heavy I/O
> * w32: fix faulty error-handling in VSS/fsfreeze COM registration
>

Applied, thanks.

-- PMM
