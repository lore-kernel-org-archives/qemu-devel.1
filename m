Received: from eggs.gnu.org ([2001:4830:134:3::10]:47400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Jason@zx2c4.com>) id 1eOlV7-0000mO-V3
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:25:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Jason@zx2c4.com>) id 1eOlV7-0003iK-2G
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:25:41 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA926yVWg6n+QE0mydU5v1DLBwtkfEM+Hs28H9bMVcgyMA@mail.gmail.com>
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
	<1512745328-5109-3-git-send-email-peter.maydell@linaro.org>
	<5A2F6F44.8050602@huawei.com>
	<CAFEAcA926yVWg6n+QE0mydU5v1DLBwtkfEM+Hs28H9bMVcgyMA@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 12 Dec 2017 15:25:25 +0100
Message-ID: <CAHmME9p3qUrX6UNDfTCh6dZ-1ahj4ZsmnqaMyEbRu-+Po=9mNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/arm/virt: Add another UART to the
 virt board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhao@linaro.org>

In case it's of direct interest in this thread, the ARM results on
https://www.wireguard.com/build-status/ are running on a QEMU built
with this disgusting cludge: https://=D7=90.cc/roJ0gMw3

The patch of this thread is the actually correct way of accomplishing
what that cludge does.
