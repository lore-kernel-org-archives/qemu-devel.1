Received: from eggs.gnu.org ([2001:4830:134:3::10]:49263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7l3-0001Ys-MO
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7l2-00035S-Ju
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:17:05 -0400
References: <20170728115131.31725-1-otubo@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <a6feb869-e73e-ffd3-278e-23fef4ae6a0c@msgid.tls.msk.ru>
Date: Mon, 31 Jul 2017 13:17:03 +0300
MIME-Version: 1.0
In-Reply-To: <20170728115131.31725-1-otubo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] unicore32: abort when entering "x 0" on
 the monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, qemu-trivial@nongnu.org
Cc: thuth@redhat.com, gxt@mprc.pku.edu.cn, qemu-devel@nongnu.org

28.07.2017 14:51, Eduardo Otubo wrote:
> Starting Qemu with "qemu-system-unicore32 -M puv3,accel=qtest -S -nographic"
> and entering "x 0 " at the monitor prompt leads to abort():

Applied to -trivial, thanks!

/mjt
