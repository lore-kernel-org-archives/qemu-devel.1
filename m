Received: from eggs.gnu.org ([2001:4830:134:3::10]:57605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d6WZv-00044q-Fw
	for qemu-devel@nongnu.org; Fri, 05 May 2017 02:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d6WZq-00007n-Iq
	for qemu-devel@nongnu.org; Fri, 05 May 2017 02:18:59 -0400
References: <20170428022329.30726-1-eblake@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <856a755d-cee1-04a5-dafc-eac09ec9c01b@msgid.tls.msk.ru>
Date: Fri, 5 May 2017 09:18:18 +0300
MIME-Version: 1.0
In-Reply-To: <20170428022329.30726-1-eblake@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests: Ignore another built executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, thuth@redhat.com, dgilbert@redhat.com

28.04.2017 05:23, Eric Blake wrote:
> Commit 78f86a2b7 added a new test, but forgot to exclude the built
> binary from version control.

Applied to -trivial (adding mention of test-hmp to subject), thanks!

/mjt
