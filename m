Received: from eggs.gnu.org ([2001:4830:134:3::10]:35102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dGMmZ-0001AP-Uh
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dGMmV-00033i-3A
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:52:43 -0400
References: <20170531192836.7187-1-jsnow@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <2a260806-0b89-7e09-c05f-bd6f2097d15d@msgid.tls.msk.ru>
Date: Thu, 1 Jun 2017 12:52:37 +0300
MIME-Version: 1.0
In-Reply-To: <20170531192836.7187-1-jsnow@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ide-test: check return of fwrite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-trivial@nongnu.org
Cc: thuth@redhat.com, qemu-devel@nongnu.org

31.05.2017 22:28, John Snow wrote:
> To quiet patchew, add an assert for fwrite's return value.

Applied to -trivial, thanks!

/mjt
