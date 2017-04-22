Received: from eggs.gnu.org ([2001:4830:134:3::10]:33982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d1zNc-0008IH-TD
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 14:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d1zNY-0002PA-0a
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 14:03:32 -0400
References: <20170308151544.7606-1-eblake@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <2c2be9fe-ecd9-120d-0296-8704442e5f64@msgid.tls.msk.ru>
Date: Sat, 22 Apr 2017 21:03:26 +0300
MIME-Version: 1.0
In-Reply-To: <20170308151544.7606-1-eblake@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9? v2] tests: Ignore more test
 executables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

08.03.2017 18:15, Eric Blake wrote:
> Ignore test executables when building in-tree:
> test-arm-mptimer introduced in commit 882fac3
> test-crypto-hmac introduced in commit 4fd460b
> test-aio-multithread introduced in commit 0c330a7

Applied to -trivial, thank you!

/mjt
