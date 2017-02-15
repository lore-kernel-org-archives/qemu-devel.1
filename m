Received: from eggs.gnu.org ([2001:4830:134:3::10]:57566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cdwdM-0000DS-KH
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cdwdI-0005hB-NP
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:16:24 -0500
References: <20170203170729.12399-1-pbonzini@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <f63ef2d8-59b3-37d3-fa0b-6507f0b796a2@msgid.tls.msk.ru>
Date: Wed, 15 Feb 2017 13:16:19 +0300
MIME-Version: 1.0
In-Reply-To: <20170203170729.12399-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] test-vmstate: remove
 yield_until_fd_readable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

03.02.2017 20:07, Paolo Bonzini wrote:
> The function is not needed anymore now that migration is built on
> top of QIOChannel.

Applied to -trivial, thanks!

/mjt
