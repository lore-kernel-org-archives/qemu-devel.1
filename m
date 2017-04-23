Received: from eggs.gnu.org ([2001:4830:134:3::10]:45173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d2Dbo-0002Rk-S4
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 05:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d2Dbk-0004YJ-3z
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 05:15:08 -0400
References: <1490365705-2912-1-git-send-email-sochin@aliyun.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <03e2cdb8-0c47-71e8-92f8-f6b6dce3581e@msgid.tls.msk.ru>
Date: Sun, 23 Apr 2017 12:15:02 +0300
MIME-Version: 1.0
In-Reply-To: <1490365705-2912-1-git-send-email-sochin@aliyun.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] channel-file: fix wrong parameter comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "sochin.jiang" <sochin@aliyun.com>, berrange@redhat.com
Cc: qemu-devel@nongnu.org, sochin.jiang@huawei.com, QEMU Trivial <qemu-trivial@nongnu.org>

24.03.2017 17:28, sochin.jiang wrote:
> From: "sochin.jiang" <sochin@aliyun.com>
> 
>     fix wrong parameter comments in channel-file.h.

Applied to -trivial.  Please don't duplicate subject and commit comment,
it's enough to leave commit empty if everything is said in the subject :)

Thanks,

/mjt
