Received: from eggs.gnu.org ([2001:4830:134:3::10]:58362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cdwhs-0004kA-Qk
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:21:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cdwho-0007r8-UT
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:21:04 -0500
References: <1486750977-15211-1-git-send-email-thuth@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <e4f8a86d-11bf-200d-7c75-97a763e81477@msgid.tls.msk.ru>
Date: Wed, 15 Feb 2017 13:20:59 +0300
MIME-Version: 1.0
In-Reply-To: <1486750977-15211-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] tests/prom-env: Enable the
 test for the sun4u machine, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>

10.02.2017 21:22, Thomas Huth wrote:
> The 32-bit TCG bug has been fixed a while ago, so we can enable
> this test for sparc64 now, too. Unfortunately, OpenBIOS does not
> work with the sun4v machine anymore (it needs to catch up with the
> improved emulation), so we can only enable this test for the sun4u
> machine right now.

Applied to -trivial, thanks!

/mjt
