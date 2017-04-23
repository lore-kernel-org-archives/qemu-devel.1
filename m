Received: from eggs.gnu.org ([2001:4830:134:3::10]:44891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d2DZY-0001lW-7Y
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 05:12:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d2DZT-0004HW-91
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 05:12:48 -0400
References: <20170317021739.16877-1-famz@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <685f6fac-86c4-e4ff-f2a4-48a9f62193d9@msgid.tls.msk.ru>
Date: Sun, 23 Apr 2017 12:12:41 +0300
MIME-Version: 1.0
In-Reply-To: <20170317021739.16877-1-famz@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block: Make 'replication_state' an enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

17.03.2017 05:17, Fam Zheng wrote:
> BDRVReplicationState.replication_state is a name with a bit of
> duplication, plus it could be an enum like BDRVReplicationState.mode,
> which is be more readable and also more straightforward in a debuuger.

Applied to trivial (with comment fixup), thanks!

/mjt
