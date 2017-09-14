Received: from eggs.gnu.org ([2001:4830:134:3::10]:51332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dsOuv-0005lc-QB
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dsOuu-000622-VI
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:50:33 -0400
References: <20170821155005.16885-1-otubo@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <09770957-c357-2d8e-147b-a9f1f8caa797@msgid.tls.msk.ru>
Date: Thu, 14 Sep 2017 10:50:31 +0300
MIME-Version: 1.0
In-Reply-To: <20170821155005.16885-1-otubo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] filter-mirror: segfault when specifying
 non existent device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, qemu-trivial@nongnu.org
Cc: lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org, zhangchen.fnst@cn.fujitsu.com

21.08.2017 18:50, Eduardo Otubo wrote:
> When using filter-mirror like the example below where the interface
> 'ndev0' does not exist on the host, QEMU crashes into segmentation
> fault.

Applied to -trivial, thanks!

/mjt
