Received: from eggs.gnu.org ([2001:4830:134:3::10]:57774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cdweQ-0001xA-94
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:17:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cdweM-000668-C6
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:17:30 -0500
References: <1486144722-6021-1-git-send-email-peter.maydell@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <e54fdd88-c5be-1ec8-c426-8e4ddf3379ed@msgid.tls.msk.ru>
Date: Wed, 15 Feb 2017 13:17:25 +0300
MIME-Version: 1.0
In-Reply-To: <1486144722-6021-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] CODING_STYLE: Mention preferred comment
 form
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, patches@linaro.org

03.02.2017 20:58, Peter Maydell wrote:
> Our defacto coding style strongly prefers /* */ style comments
> over the single-line // style, and checkpatch enforces this,
> but we don't actually document this. Mention it in CODING_STYLE.

Applied to -trivial, thanks!

/mjt
