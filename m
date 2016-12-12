Received: from eggs.gnu.org ([2001:4830:134:3::10]:50283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Claudio.Fontana@huawei.com>) id 1cGQNJ-0004y0-Em
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 08:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Claudio.Fontana@huawei.com>) id 1cGQND-0006eS-C8
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 08:10:37 -0500
From: Claudio Fontana <claudio.fontana@huawei.com>
Message-ID: <584EA1BC.7030801@huawei.com>
Date: Mon, 12 Dec 2016 14:10:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] TCG AArch64 target maintained status change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

Hello all,

the last bug report from Alex pointed me to the fact that I am unable to focus on TCG AArch64 maintenance, due to changed working conditions since some time now.

I think that in practice Richard has been taking care of this module anyway, so I think it is time to make it official.
Should I send a patch to change Maintained to Orphaned for the MAINTAINERS file?
Or maybe Peter, Richard you can directly appoint the replacement name in there?

Thanks,

Claudio
