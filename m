Received: from eggs.gnu.org ([2001:4830:134:3::10]:52499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g6xs3-0005LI-82
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 09:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g6xs2-0006zj-GM
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 09:04:19 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:44803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g6xs2-0006xa-1h
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 09:04:18 -0400
Received: by mail-oi1-x229.google.com with SMTP id u74-v6so11055955oia.11
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 06:04:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9cKPNKs_eR638eEqbAVW9sLxwHdnKVb-P-6hXJ3Kwyig@mail.gmail.com>
References: <20180925151541.18932-1-mreitz@redhat.com>
	<CAFEAcA-3bf02knEbNgq5ouFVnJDL6a9HqAvCo3Z4vaWYu-8yUw@mail.gmail.com>
	<CAFEAcA9cKPNKs_eR638eEqbAVW9sLxwHdnKVb-P-6hXJ3Kwyig@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Oct 2018 14:03:56 +0100
Message-ID: <CAFEAcA95G4Nc4+Av0JNeh2NHa5NZR1wyos28V9xhQZn4v0WAWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/42] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>

On 28 September 2018 at 15:36, Peter Maydell <peter.maydell@linaro.org> wrote:
> I'm finding that test-bdrv-drain hangs intermittently on my OSX host.

Ping? Between this and test-replication I'm finding that my
parallel build tests for merges are failing about 50% of the
time :-(

If there's no immediate sign of a fix, could we disable these
tests?

thanks
-- PMM
